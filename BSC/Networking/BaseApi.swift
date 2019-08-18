//
//  BaseApi.swift
//  BSC
//
//  Created by Andrey Mosin on 14/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

enum ApiEndPoint: String {
    case notes = "notes"
    case note = "notes/%@"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

private struct VoidParameters: Encodable {
    
}

class ApiProvider {
    
    private static let session = URLSession.shared
    private static let baseApi = URL(string: "https://private-anon-af2f08244e-note10.apiary-mock.com")!
    
    class func request<T: Decodable>(method: HTTPMethod, endPoint: ApiEndPoint, loadingHandler: (() -> Void), resultHandler: @escaping ((Result<T, Error>) -> Void)) {
        request(method: method, endPoint: endPoint, parameters: VoidParameters(), loadingHandler: loadingHandler, resultHandler: resultHandler)
    }
    
    class func request<T: Decodable>(method: HTTPMethod, endPoint: String, loadingHandler: (() -> Void), resultHandler: @escaping ((Result<T, Error>) -> Void)) {
        request(method: method, endPoint: makeUrl(from: endPoint), parameters: VoidParameters(), loadingHandler: loadingHandler, resultHandler: resultHandler)
    }
    
    class func request(method: HTTPMethod, endPoint: String, loadingHandler: (() -> Void), resultHandler: @escaping ((Result<Void, Error>) -> Void)) {
        request(method: method, endPoint: makeUrl(from: endPoint), parameters: VoidParameters(), loadingHandler: loadingHandler, resultHandler: resultHandler)
    }
    
    class func request<T: Encodable, U: Decodable>(method: HTTPMethod, endPoint: ApiEndPoint, parameters: T,
                                                   loadingHandler: (() -> Void),
                                                   resultHandler: @escaping ((Result<U, Error>) -> Void)) {
        request(method: method, endPoint: makeUrl(from: endPoint), parameters: parameters, loadingHandler: loadingHandler, resultHandler: resultHandler)
    }
    
    class func request<T: Decodable>(method: HTTPMethod, endPoint: String, parameters: [String: Any],
                                     loadingHandler: (() -> Void),
                                     resultHandler: @escaping ((Result<T, Error>) -> Void)) {
        request(method: method, endPoint: makeUrl(from: endPoint), parameters: parameters, loadingHandler: loadingHandler, resultHandler: resultHandler)
    }
        
    class func request<T: Encodable, U: Decodable>(method: HTTPMethod, endPoint: URL, parameters: T,
                                             loadingHandler: (() -> Void),
                                             resultHandler: @escaping ((Result<U, Error>) -> Void)) {
        request(method: method, endPoint: endPoint, parameters: parameters.asDictionary(), loadingHandler: loadingHandler, resultHandler: resultHandler)
    }
    
    class func request<T: Decodable>(method: HTTPMethod, endPoint: URL, parameters: [String: Any],
                                                   loadingHandler: (() -> Void),
                                                   resultHandler: @escaping ((Result<T, Error>) -> Void)) {
        
        loadingHandler()
        
        do {
            let task = try session.dataTask(with: endPoint, method: method, parameters: parameters) { result in
                switch result {
                case .failure(let e):
                    resultHandler(.failure(e))
                    
                case .success(_, let data):
                    
                    do {
                        if let data = data {
                            let entity = try JSONDecoder().decode(T.self, from: data)
                            resultHandler(.success(entity))
                        }
                        
                    } catch {
                        resultHandler(.failure(error))
                    }
                }
            }
            
            task.resume()
        } catch {
            resultHandler(.failure(error))
        }
    }
    
    class func request<T: Encodable>(method: HTTPMethod, endPoint: URL, parameters: T,
                                                   loadingHandler: (() -> Void),
                                                   resultHandler: @escaping ((Result<Void, Error>) -> Void)) {
        
        loadingHandler()
        
        do {
            let task = try session.dataTask(with: endPoint, method: method, parameters: parameters.asDictionary()) { result in
                switch result {
                case .failure(let e):
                    resultHandler(.failure(e))
                    
                case .success:
                    resultHandler(.success(()))
                }
            }
            
            task.resume()
        } catch {
            resultHandler(.failure(error))
        }
    }
    
    private class func makeUrl(from endPoint: ApiEndPoint) -> URL {
        let url = baseApi.appendingPathComponent(endPoint.rawValue)
        return url
    }
    
    private class func makeUrl(from endPoint: String) -> URL {
        let url = baseApi.appendingPathComponent(endPoint)
        return url
    }
}
