//
//  CryptocurrencyTrackerApp.swift
//  CryptocurrencyTracker
//
// Created by pratik on 09/12/24.
//

import SwiftUI

@main
struct CryptocurrencyTrackerApp: App {
    @StateObject private var homeVM = HomeViewModel()
    @State private var showLaunchView: Bool = true

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(homeVM)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.opacity)
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
