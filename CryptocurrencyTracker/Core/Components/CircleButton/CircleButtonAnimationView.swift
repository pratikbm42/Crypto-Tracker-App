//
//  CircleButtonAnimationView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .frame(width: 80, height: 80)
            .scaleEffect(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .foregroundColor(.red)
            .animation(animate ? .easeOut(duration: 1.0) : nil, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
