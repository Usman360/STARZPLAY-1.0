//
//  Network-Extension.swift
//  STARZPLAY
//
//  Created by Usman on 18/03/2024.
//

import Foundation

//MARK: - Extensions
extension URLRequest {
    public var method: HTTPMethod? {
        get { httpMethod.flatMap(HTTPMethod.init) }
        set { httpMethod = newValue?.rawValue }
    }

    public func validate() throws {
        if method == .GET, let _ = httpBody {
            throw NetworkError.urlRequestValidationFailed
        }
    }
}

extension Data {
    var NetworkPrettyPrintedJSONString: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else {
            return String(decoding: self, as: UTF8.self)
        }
        
        return prettyPrintedString
    }
    func decode<T: Codable>(type: T.Type) -> T? {
        do {
            let decodedObject = try JSONDecoder().decode(type, from: self)
            return decodedObject
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

extension Dictionary {
    func serialize() -> Data? {
        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: self,
                options:.prettyPrinted
            )
            return jsonData
        }
        catch {
            print("Error while converting \(self) to data")
            return nil
        }
    }
    
    var json: String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            return String(bytes: jsonData, encoding: String.Encoding.utf8)
        }
        return nil
    }
}


extension NSNumber {
     var isBool: Bool {
        String(cString: objCType) == "c"
    }
}

extension String {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidUrl }
        return url
    }
}


extension CharacterSet {
    /// Creates a CharacterSet from RFC 3986 allowed characters.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    public static let URLQueryAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
}
