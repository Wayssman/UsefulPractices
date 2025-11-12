//
//  UserDefaultsJSONSerializer.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import Foundation

protocol UserDefaultsSerializer {
    static func encode<T: Encodable>(value: T) -> Any?
    static func decode<T: Decodable>(value: Any?) -> T?
}

struct UserDefaultsJSONSerializer: UserDefaultsSerializer {
    static func encode<T: Encodable>(value: T) -> Any? {
        guard
            let encodedJSON = try? JSONEncoder().encode(value),
            let outputString = String(data: encodedJSON, encoding: .utf8)
        else { return nil }
        
        return outputString
    }
    
    static func decode<T: Decodable>(value: Any?) -> T? {
        guard let value = value else { return nil }
        
        guard
            let data = (value as? String)?.data(using: .utf8),
            let result = try? JSONDecoder().decode(T.self, from: data)
        else { return nil }
        
        return result
    }
}
