//
//  UserDefaultsPropertyWrapperUsage.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import UIKit
import SwiftUI

final class UDWrapperUsageViewController: UIViewController {
    // MARK: Subtypes
    struct Model: Codable {
        static let empty = Model(name: "", age: 0)
        
        let name: String
        let age: Int
    }
    
    // MARK: Properties
    @Persistent(key: .counterKey) var savedCounter: Int?
    @Persistent(key: .modelKey, serializer: .jsonString) var savedModel: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Last saved values: ", savedCounter ?? 0, savedModel ?? .empty)
        savedCounter = Int.random(in: 0...10)
        savedModel = .init(name: "Name", age: Int.random(in: 20...80))
    }
}

struct UDWrapperUsageViewControllerWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return UDWrapperUsageViewController().view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

#Preview {
    struct PreviewContainer: View {
        @State private var refreshID = UUID()
        
        var body: some View {
            UDWrapperUsageViewControllerWrapper()
                .id(refreshID)
                .onTapGesture {
                    refreshID = UUID()
                }
        }
    }
    
    return PreviewContainer()
}
