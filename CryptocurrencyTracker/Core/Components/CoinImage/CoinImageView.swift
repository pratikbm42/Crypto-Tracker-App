//
//  CoinImageView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel

    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark.circle.fill")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveleperPreview.instance.coin)
}
