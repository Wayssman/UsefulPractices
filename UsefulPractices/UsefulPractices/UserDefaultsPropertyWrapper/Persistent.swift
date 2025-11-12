//
//  Persistent.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import Foundation

@propertyWrapper
final class Persistent<Value: Codable> {
    // MARK: Properties
    let key: String
    let serializer: UserDefaultsSerializer.Type?
    var wrappedValue: Value? {
        get {
            if let lastValue { return lastValue }
            
            let storedValue = UserDefaults.standard.value(forKey: key)
            
            guard let serializer else {
                return storedValue as? Value
            }
            return serializer.decode(value: storedValue)
        }
        set {
            defer { lastValue = newValue }
            
            guard let value = newValue else {
                UserDefaults.standard.removeObject(forKey: key)
                return
            }

            guard let serializer else {
                UserDefaults.standard.set(newValue, forKey: key)
                return
            }
            
            guard let valueToWrite = serializer.encode(value: value) else {
                assertionFailure("Failed to encode value with serializer")
                return
            }
            UserDefaults.standard.set(valueToWrite, forKey: key)
        }
    }
    
    private var lastValue: Value?
    
    // MARK: Initializers
    init(key: PersistenceKey, serializer: PersistentObjectSerializer? = nil) {
        self.key = key.rawValue
        self.serializer = serializer?.serializerType
    }
}
