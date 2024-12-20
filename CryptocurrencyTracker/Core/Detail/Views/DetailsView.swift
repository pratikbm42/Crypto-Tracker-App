//
//  DetailsView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject private var detailVM: CoinDetailViewModel
    @State private var showCompleteDescription: Bool = false

    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    private let gridSpacing: CGFloat = 30

    init(coin: CoinModel) {
        _detailVM = ObservedObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ChartView(coin: detailVM.coin)
                    .frame(height: 300)
                overViewSection
                aditionalDetailsSection
            }
            .padding(.horizontal)
        }
        .navigationTitle(detailVM.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                topBarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailsView(coin: DeveleperPreview.instance.coin)
    }
}

extension DetailsView {
    private var overViewSection: some View {
        VStack(alignment: .leading) {
            Text("Overview".uppercased())
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            if let description = detailVM.coinDescription {
                Text(description)
                    .font(.callout)
                    .foregroundStyle(Color.theme.secondaryText)
                    .lineLimit(showCompleteDescription ? nil : 3)

                Button(action: {
                    withAnimation(.easeInOut) {
                        showCompleteDescription.toggle()
                    }
                }, label: {
                    Text(showCompleteDescription ? "Less ..." : "Read More ...")
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)

                })
            }

            LazyVGrid(columns: gridColumns, alignment: .leading, spacing: gridSpacing, content: {
                ForEach(detailVM.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
        }
    }

    private var aditionalDetailsSection: some View {
        VStack(alignment: .leading) {
            Text("Aditional Details".uppercased())
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            LazyVGrid(columns: gridColumns, alignment: .leading, spacing: gridSpacing, content: {
                ForEach(detailVM.aditionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })

            if let stringURL = detailVM.websiteURL, let url = URL(string: stringURL) {
                Link(destination: url, label: {
                    HStack {
                        Image(systemName: "network")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Website")
                            .font(.headline)
                    }
                    .foregroundStyle(.blue)

                })
            }

            if let stringURL = detailVM.subredditURL, let url = URL(string: stringURL) {
                Link(destination: url, label: {
                    HStack {
                        Image("reddit-icon")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Reddit")
                            .font(.headline)
                    }
                    .foregroundStyle(.blue)

                })
            }
        }
    }

    private var topBarTrailingItems: some View {
        HStack {
            Text(detailVM.coin.symbol.uppercased())
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: detailVM.coin)
                .frame(height: 30)
        }
    }
}
