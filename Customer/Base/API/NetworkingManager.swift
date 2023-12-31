//
//  NetworkingManager.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/14/23.
//

import Foundation


protocol NetworkingManagerImpl {
    func request<T: Codable>(session: URLSession,_ endpoint: Endpoint, type: T.Type) async throws -> T
    func request(session: URLSession,_ endpoint: Endpoint) async throws
}


final class NetworkingManager: NetworkingManagerImpl {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(session: URLSession = .shared,_ endpoint: Endpoint, type: T.Type) async throws -> T {
        
      
        guard let url = endpoint.url else {
           throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
        return res
    }
    
//    func request<T: Codable>(_ endpoint: Endpoint, type: T.Type, completion: @escaping (Result<T,Error>) -> Void){
//        
//      
//        guard let url = endpoint.url else {
//            completion(.failure(NetworkingError.invalidURL))
//            return
//            
//        }
//        
//        let request = buildRequest(from: url, methodType: endpoint.methodType)
//        
//        let dataTask = URLSession.shared.dataTask(with: request){ data, response, error in
//            
//            
//            if error != nil {
//                completion(.failure(NetworkingError.custom(error: error!)))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse,
//                  (200...300) ~= response.statusCode else {
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NetworkingError.invalidData))
//                return
//            }
//            
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let res = try decoder.decode(T.self, from: data)
//                completion(.success(res))
//            } catch {
//                completion(.failure(NetworkingError.failedToDecode(error: error)))
//            }
//        }
//        
//        dataTask.resume()
//    }
    
    func request(session: URLSession = .shared,_ endpoint: Endpoint) async throws {
       
        guard let url = endpoint.url else {
           throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        let ( _, response ) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
    
//    func request(_ endpoint: Endpoint, completion: @escaping (Result<Void,Error>) -> Void){
//       
//        guard let url = endpoint.url else {
//            completion(.failure(NetworkingError.invalidURL))
//            return
//            
//        }
//        let request = buildRequest(from: url, methodType: endpoint.methodType)
//        let dataTask = URLSession.shared.dataTask(with: request){ data, response, error in
//            
//            
//            if error != nil {
//                completion(.failure(NetworkingError.custom(error: error!)))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse,
//                  (200...300) ~= response.statusCode else {
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
//                return
//            }
//            completion(.success(()))
//        }
//        
//        dataTask.resume()
//    }
}


extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case(.custom(let lhsType), .custom(let rhsType)):
                return lhsType.localizedDescription == rhsType.localizedDescription
        case(.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case(.invalidData, .invalidData):
            return true
        case(.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
                
        }
    }
    
    
}


extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
            
        }
    }
}



private extension NetworkingManager {
    func buildRequest(from url: URL,
                      methodType:Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
