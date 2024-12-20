//
//  LaunchView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import SwiftUI

struct LaunchView: View {
    @Binding var showLaunchView: Bool
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0

    private let loadingText: [String] = "Loading your portfolio...".map { String($0) }

    let timer = Timer.publish(every: 0.1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            Color.Launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            ZStack {
                if showLaunchView {
                    HStack(spacing: 0.0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.Launch.accent)
                                .offset(y: counter == index ? -8 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            onReceiveTimer()
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}

extension LaunchView {
    private func onReceiveTimer() {
        withAnimation(.linear) {
            if counter == (loadingText.count - 1) {
                counter = 0
                loops += 1
                if loops >= 2 {
                    showLaunchView.toggle()
                }
            }
            else {
                counter += 1
            }
        }
    }
}
