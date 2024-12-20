//
//  StatisticView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel
    var body: some View {
        let percentageChange = stat.percentageChange ?? 0
        VStack(alignment: .leading, spacing: 5) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: percentageChange >= 0 ? 0 : 180)
                    )

                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(
                stat.percentageChange ?? 0 >= 0
                    ? Color.theme.green
                    : Color.theme.red
            )
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

#Preview {
    let stat1 = DeveleperPreview.instance.statistic1
    let stat2 = DeveleperPreview.instance.statistic2
    return StatisticView(stat: stat1)
}
