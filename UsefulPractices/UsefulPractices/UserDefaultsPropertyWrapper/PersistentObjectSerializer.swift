//
//  PersistentObjectSerializer.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import Foundation

enum PersistentObjectSerializer {
    case jsonString
    
    var serializerType: UserDefaultsSerializer.Type {
        switch self {
        case .jsonString:
            return UserDefaultsJSONSerializer.self
        }
    }
}
