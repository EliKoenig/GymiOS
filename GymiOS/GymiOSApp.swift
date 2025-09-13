//
//  GymiOSApp.swift
//  GymiOS
//
//  Created by lending on 9/11/25.
//

import SwiftUI

@main
struct GymiOSApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.18, alpha: 1.0)
        appearance.shadowColor = .clear // Remove bottom line
        appearance.shadowImage = UIImage() // Extra: remove shadow image
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white // Ensure icons are white
        // Set global window background color to match app background for all windows/scenes
        for scene in UIApplication.shared.connectedScenes {
            if let windowScene = scene as? UIWindowScene {
                for window in windowScene.windows {
                    window.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.10, alpha: 1.0)
                }
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
