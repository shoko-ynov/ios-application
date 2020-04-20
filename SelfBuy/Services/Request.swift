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
    private var canRefreshToken = true
    
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
        guard let tokenSaved = AuthenticationManager.getToken() else {
            return self
        }
        self.token = tokenSaved
        
        return self
    }
    
    func disableCanRefreshToken() -> Request {
        self.canRefreshToken = false
        
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
    
    func callRequest(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = self.getRequest() else { return }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else { return }
            
            do {
                print("Status code : \(urlResponse.statusCode)")
                if urlResponse.statusCode == 401 {
                    if (!self.canRefreshToken) {
                        AuthenticationManager.removeTokens()
                        return
                    }
                    
                    let service: AuthAPIService = AuthAPIService()
                    
                    self.canRefreshToken = false
                    service.refreshToken() {
                        switch $0 {
                        case .success(let token):
                            AuthenticationManager.setToken(token: token)
                            self.token = token.token
                            self.callRequest(completion: completion)
                        case .failure(let error):
                            print(error)
                            AuthenticationManager.removeTokens()
                            completion(.failure(error))
                        }
                    }
                    
                    return
                } else if urlResponse.statusCode != 200 && urlResponse.statusCode != 201 && urlResponse.statusCode != 204 {
                    throw NSError(domain: "Server error, status code : \(urlResponse.statusCode)", code: 500)
                }
                
                completion(.success(data))
                
            } catch let parseError as NSError {
                completion(.failure(parseError))
            }
            
        }.resume()
    }
    
    func sendWithDecode<T:Decodable>(_ type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        callRequest { result in
            do {
                let decoder = JSONDecoder()
                
                switch result {
                case .success(let data):
                    let decodedData = try decoder.decode(GenericServerResponse<T>.self, from: data)
                    completion(.success(decodedData.data))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            } catch let error {
                return completion(.failure(error))
            }
        }
    }
    
    func send(completion: @escaping (Result<NSNull, Error>) -> Void) {
        callRequest {
            switch $0 {
            case .success(_):
                completion(.success(.init()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
