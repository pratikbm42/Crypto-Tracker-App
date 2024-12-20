//
//  CoinRowView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColum: Bool
    var body: some View {
        HStack(spacing: 0) {
            leftColum
            Spacer()
            if showHoldingsColum {
                centerColum
            }
            rightColum
        }
        .font(.subheadline)
    }
}

#Preview {
    var coin = DeveleperPreview.instance.coin
    return CoinRowView(coin: coin, showHoldingsColum: true)
}

extension CoinRowView {
    private var leftColum: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .padding(.leading, 10)
        }
    }
}

extension CoinRowView {
    private var centerColum: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWithDecimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.currentHoldings?.asNumberString() ?? "")
                .bold()
                .foregroundStyle(
                    (coin.priceChangePercentage24h ?? 0) >= 0
                        ? Color.theme.green
                        : Color.theme.red
                )
        }
    }
}

extension CoinRowView {
    private var rightColum: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWithDecimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24h?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24h ?? 0) >= 0
                        ? Color.theme.green
                        : Color.theme.red
                )
        }
        .frame(minWidth: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
