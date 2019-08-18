//
//  URLSession.swift
//  BSC
//
//  Created by Andrey Mosin on 17/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

extension URLSession {
    
    func dataTask(with url: URL, method: HTTPMethod, parameters: [String: Any] = [:], result: @escaping (Result<(URLResponse, Data?), Error>) -> Void) throws -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if !parameters.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        
        return dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                result(.failure(error))
                return
            }
            
            guard let response = response else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            
            result(.success((response, data)))
        }
    }
}
