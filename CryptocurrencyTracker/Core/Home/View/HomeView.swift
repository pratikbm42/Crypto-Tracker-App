//
//  HomeView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    @State private var showPortfolio: Bool = false // for animate to right
    @State private var showPortfolioView: Bool = false // for show a sheet
    @State private var showSettingsView: Bool = false
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(
                    isPresented: $showPortfolioView,
                    onDismiss: {
                        showPortfolioView = false
                    },
                    content: {
                        PortfolioView()
                            .environmentObject(homeVM)
                    }
                )

            // Content Layer
            VStack {
                homeHeader
                    .sheet(isPresented: $showSettingsView, content: {
                        SettingsView()
                    })

                HomeStatsView(showPorfolio: $showPortfolio)
                    .padding(.top)

                SearchBarView(searchText: $homeVM.searchText)

                rowTitles

                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }

                Spacer()
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(HomeViewModel())
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)

            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }

    private var portfolioCoinsList: some View {
        List(homeVM.portfolioCoins) { coin in
            CoinRowView(
                coin: coin,
                showHoldingsColum: true
            )
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
            .background(
                lazyNavigationLink(coin: coin)
            )
        }
        .listStyle(.plain)
        .refreshable {
            onReloadData()
        }
    }

    private var allCoinsList: some View {
        List(homeVM.allCoins) { coin in
            CoinRowView(
                coin: coin,
                showHoldingsColum: false
            )
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
            .background(
                lazyNavigationLink(coin: coin)
            )
        }
        .listStyle(.plain)
        .refreshable {
            onReloadData()
        }
    }

    private var rowTitles: some View {
        HStack {
            Text("Coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(minWidth: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            reloadDataButton
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private var reloadDataButton: some View {
        Button(action: onReloadData, label: {
            Image(systemName: "arrow.clockwise")
                .rotationEffect(Angle(degrees: homeVM.isLoading ? 360 : 0), anchor: .center)
        })
    }

    private func onReloadData() {
        withAnimation(.linear(duration: 1)) {
            homeVM.reloadData()
        }
    }

    private func lazyNavigationLink(coin: CoinModel) -> some View {
        NavigationLink("", destination: LazyView(DetailsView(coin: coin)))
            .opacity(0) // Just to hide navigation right arrow
    }
}
