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
    private var body: String?
    private var method: HTTPMethod = .GET
    private var token: String?
    private let encoder = JSONEncoder()
    
    init(url : String) {
        self.url = url
    }
    
    func setBody(_ body: String) -> StripeRequest {
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
        
        let encodedApiKey = Config.stripePublicKey.data(using: .utf8)!.base64EncodedString()
        
        request.addValue("Basic \(encodedApiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        guard let body = body else {
            return request
        }
        
        request.httpBody = NSMutableData(data: body.data(using: .utf8)!) as Data;
                
        return request
    }
    
    private func decodeData<T: Decodable>(_ type: T.Type, data: Data) -> Result<T, Error> {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return .success(decodedData)
        } catch let error {
            return .failure(error)
        }
    }
    
    func send<T: Decodable>(_ type: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        guard let request = self.getRequest() else { return }
        print("request")
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else { return }
            
            do {
                print("Status code : \(urlResponse.statusCode)")
                if urlResponse.statusCode == 401 {
                    
                } else if urlResponse.statusCode != 200 && urlResponse.statusCode != 201 && urlResponse.statusCode != 204 {
                    throw NSError(domain: "Server error, status code : \(urlResponse.statusCode)", code: 500)
                }
                
                let response = self.decodeData(type, data: data)
                
                switch response {
                case .success(let decoded):
                    completion(.success(decoded))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch let parseError as NSError {
                completion(.failure(parseError))
            }
            
        }.resume()
    }
}
