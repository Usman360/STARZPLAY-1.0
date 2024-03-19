//
//  NetworkManager.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation
import Combine

public class NetworkManager: ObservableObject {
    private var session: NetworkSession?
    
    public static let shared: NetworkManager = NetworkManager()
    private init() {
        initialSetup()
    }
    
    public func initialSetup() {
        self.session = NetworkSession()
    }
    public func request<T>(_ request: ApiRequest, decodingType: T.Type) -> AnyPublisher<T, ApiError> where T: Codable {
        guard let session = session else {
            
            return Fail(error:
                            NetworkUtils.getApiError(
                                code: -1,
                                message: APIErrorHandler.requestFailed.errorDescription ?? "")).eraseToAnyPublisher()
        }
        do {
            let urlRequest = try request.makeRequest()
            return session.publisher(urlRequest, decodingType: decodingType)
        }
        catch (let error){
            return Fail(error:
                            NetworkUtils.getApiError(
                                code: -1,
                                message: APIErrorHandler.normalError(error).errorDescription ?? "")).eraseToAnyPublisher()
        }
    }
}
