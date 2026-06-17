//
//  UsefulPracticesApp.swift
//  UsefulPractices
//
//  Created by Alexandr Zhelanov on 12/11/25.
//

import SwiftUI

@main
struct UsefulPracticesApp: App {
    var body: some Scene {
        WindowGroup {
            /*UIKitMaskedTextProgressBarWrapper()
                .aspectRatio(5, contentMode: .fit)
                .padding()*/
            //SkeletonExample(isLoading: false)
            //SkeletonExample(isLoading: true)
            FocusableViewControllerWrapper()
        }
    }
}
