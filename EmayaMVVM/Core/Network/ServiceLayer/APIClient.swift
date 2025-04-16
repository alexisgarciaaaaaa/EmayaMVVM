//
//  APIClient.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI
import Combine

protocol APIClient {
    associatedtype EndPointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndPointType) -> AnyPublisher<T, Error>
}

enum ApiError: Error {
    case invalidResponse
    case invalidData
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    typealias EndPointType = EndpointType
    
    func request<T: Decodable>(_ endpoint: EndPointType) -> AnyPublisher<T, Error> {
        var urlComponents = URLComponents(url: endpoint.baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)
        
        if let parameters = endpoint.parameters, endpoint.method == .get {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let finalURL = urlComponents?.url else {
            return Fail(error: ApiError.invalidResponse).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let bodyData = try? endpoint.bodyToData(), endpoint.method != .get {
            request.httpBody = bodyData
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw ApiError.invalidResponse
                }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📥 API Response JSON: \n\(jsonString)")
                } else {
                    print("❌ We cannot convert the data")
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    
}
