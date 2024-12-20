//
//  HomeStatsView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    @Binding var showPorfolio: Bool
    var body: some View {
        HStack {
            ForEach(homeVM.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: showPorfolio ? .trailing : .leading
        )
    }
}

#Preview {
    HomeStatsView(showPorfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
