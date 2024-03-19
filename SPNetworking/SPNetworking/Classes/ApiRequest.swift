//
//  ApiRequest.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
}

public protocol ApiRequest {
    var baseUrl: String { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension ApiRequest {
    func makeRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(endPoint))
        request.httpMethod = method.rawValue
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        print("\nURL: \(String(describing: baseUrl))")
        print("End Point: \(endPoint)")
        let requestParams = params
        if let params = params, let requestParams = params.json {
            print("REQUEST PARAMS: \(String(describing: requestParams))")
        }
        
        switch method {
        case .GET:
            request = try URLEncoding.default.encode(request, with: requestParams)
        case .POST, .PUT:
            request = try JSONEncoding.default.encode(request, with: requestParams)
        }
        return request
    }
}
