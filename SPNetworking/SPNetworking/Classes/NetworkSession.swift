//
//  NetworkSession.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation
import Combine

public protocol NetworkSessionProtocol: AnyObject {
    func publisher<T>(_ request: URLRequest,
                      decodingType: T.Type) -> AnyPublisher<T, ApiError> where T: Codable
}

public class NetworkSession: NSObject, NetworkSessionProtocol {
    private lazy var session = URLSession(configuration: .default)
    
    public func publisher<T>(_ request: URLRequest,
                             decodingType: T.Type) -> AnyPublisher<T, ApiError> where T: Codable {
        return session.dataTaskPublisher(for: request)
            .tryMap ({ data, response in
                
                let responseData = data
                NetworkUtils.Print(responseData)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIErrorHandler.requestFailed
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    let error = try JSONDecoder().decode(ApiError.self, from: responseData)
                    throw error
                }
                return responseData
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let apiError = error as? ApiError {
                    return apiError
                } else {
                    return NetworkUtils.getApiError(code: -1, message: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
