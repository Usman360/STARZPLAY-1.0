//
//  NetworkUtils.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation

public struct ApiError: Error, Codable  {
    public let status_message: String?
    public let success: Bool?
    public let status_code: Int?
}

public enum APIErrorHandler: Error {
    case customApiError(ApiError)
    case requestFailed
    case normalError(Error)
    case tokenExpired
    case emptyErrorWithStatusCode(String)
    case invalidEncryptionKeys
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "request failed"
        case .normalError(let error):
            return errorDescription
        case .tokenExpired:
            return "Token problems"
        case .emptyErrorWithStatusCode(let status):
            return status
        default:
            return "Internal error!"
        }
    }
}

enum NetworkError : Error {
    case invalidUrl
    case urlRequestValidationFailed
    case parameterEncodingFailed
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .urlRequestValidationFailed:
            return "Invalid request"
        case .parameterEncodingFailed:
            return "The `URLRequest` did not have a `URL` to encode."
        }
    }
}

struct NetworkUtils {
    // Printing json
    static func Print(_ object: Any?, _ path: String? = nil, _ key: String? = nil) {
    #if DEBUG
        if let responseData = object as? Data {
            let strResult = responseData.NetworkPrettyPrintedJSONString
            if let key = key {
                Swift.print("\n \(key) : - \(path ?? ""): \n\(strResult)")
            }else {
                Swift.print("\n \(path ?? ""): \n\(strResult)")
            }
        }else {
            Swift.print(object ?? "")
        }
    #endif
    }
    
    public static func getApiError(code: Int, message: String) -> ApiError {
        ApiError(status_message: message,
                 success: false,
                 status_code: nil)
    }
}
