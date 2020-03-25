//
//  StripeRequest.swift
//  SelfBuy
//
//  Created by Léo GIGT on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

class StripeRequest {
    private var url: String
    private var body: Encodable?
    private var method: HTTPMethod = .GET
    private var token: String?
    private let encoder = JSONEncoder()
    
    init(url : String) {
        self.url = url
    }
    
    func setBody(_ body: Encodable) -> StripeRequest {
        self.body = body
        return self
    }
    
    func setMethod(_ method: HTTPMethod) -> StripeRequest {
        self.method = method
        return self
    }
    
    private func getRequest() -> URLRequest? {
        var request = URLRequest(url: URL(string: self.url)!)
        request.httpMethod = self.method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let body = body else {
            return request
        }
        
        let encodable = AnyEncodable(body)
        request.httpBody = try? JSONEncoder().encode(encodable)
                
        return request
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
    
    func send<T: Decodable>(_ type: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let request = self.getRequest() else { return }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else { return }
            
            do {
                print("Status code : \(urlResponse.statusCode)")
                if urlResponse.statusCode == 401 {
                    
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
