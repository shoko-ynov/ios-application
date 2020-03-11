//
//  ApiService.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 10/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

class Request {
    
    private let domain: String
    private var path: String = "/"
    private var body: Encodable?
    private var method: HTTPMethod = .GET
    private var token: String?
    private let encoder = JSONEncoder()
    
    init(domain: String = Config.baseApi) {
        self.domain = domain
    }
    
    func setPath(_ path: String) -> Request {
        self.path = path
        return self
    }
    
    func setBody(_ body: Encodable) -> Request {
        self.body = body
        return self
    }
    
    func setMethod(_ method: HTTPMethod) -> Request {
        self.method = method
        return self
    }
    
    func withAuthentication() -> Request {
        guard let tokenSaved = UserDefaults.standard.string(forKey: "TOKEN") else {
            return self
        }
        self.token = tokenSaved
        return self
    }
    
    private func getFullUrl() -> URL? {
        let url = "\(self.domain)\(self.path)"
        return URL(string: url)
    }
    
    private func decodeData<T: Decodable>(_ type: T.Type, data: Data) -> Result<GenericServerResponse<T>, Error> {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(GenericServerResponse<T>.self, from: data)
            return .success(decodedData)
        } catch let error {
            return .failure(error)
        }
    }
    
    private func getRequest() -> URLRequest? {
        guard let url = self.getFullUrl() else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let safeToken = self.token {
            request.addValue("Bearer \(safeToken)", forHTTPHeaderField: "Authorization")
        }
        
        guard let body = body else {
            return request
        }
        
        let encodable = AnyEncodable(body)
        request.httpBody = try? JSONEncoder().encode(encodable)
                
        return request
    }
    
    func send<T: Decodable>(_ type: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let request = self.getRequest() else { return }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else { return }
            
            do {
                print("Status code : \(urlResponse.statusCode)")
                if urlResponse.statusCode == 401 {
                    let response = self.decodeData(ApiError.self, data: data)
                    
                    switch response {
                    case .success(let decoded):
                        if(decoded.data.code == "INVALID_REFRESH_TOKEN") {
                            UserDefaults.standard.set("", forKey: "TOKEN")
                            UserDefaults.standard.set("", forKey: "refreshToken")
                        } else {
                            let service: AuthAPIService = AuthAPIService()
                            service.refreshToken()
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                    
                } else if urlResponse.statusCode != 200 && urlResponse.statusCode != 201 && urlResponse.statusCode != 204 {
                    throw NSError(domain: "Server error, status code : \(urlResponse.statusCode)", code: 500)
                }
                
                
                let response = self.decodeData(T.self, data: data)
                
                switch response {
                case .success(let decoded):
                    completion(.success(decoded.data))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            } catch let parseError as NSError {
                completion(.failure(parseError))
            }
            
        }.resume()
    }
    
}


enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
