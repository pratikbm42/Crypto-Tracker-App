//
//  ChartView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct ChartView: View {
    @State private var trimPercent: CGFloat = 0

    private let data: [Double]
    private let yMin: Double
    private let yMax: Double
    private let yAxisSize: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date

    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []

        self.yMin = data.min() ?? 0
        self.yMax = data.max() ?? 0
        self.yAxisSize = yMax - yMin

        self.lineColor = ((data.last ?? 0) - (data.first ?? 0)) > 0
            ? Color.theme.green
            : Color.theme.red

        self.endingDate = Date(iso8601String: coin.lastUpdated ?? "")
        self.startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }

    var body: some View {
        VStack {
            chartView
                .background(chartBackground)
                .overlay(alignment: .leading, content: {
                    chartYAxis
                })
            chartDateLabel
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2)) {
                    trimPercent = 1
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveleperPreview.instance.coin)
        .frame(height: 300)
}

extension ChartView {
    var chartView: some View {
        GeometryReader { geometry in

            Path { path in
                let frameW = geometry.size.width
                let frameH = geometry.size.height

                let dx = frameW / CGFloat(data.count - 1)

                let yScale = frameH / yAxisSize

                for index in data.indices {
                    let xPosition = CGFloat(index) * dx

                    let dy = data[index] - yMin
                    let yPosition = frameH - (yScale * dy)

                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .trim(from: 0.0, to: trimPercent)
            .stroke(
                lineColor,
                style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
            )
            .shadow(
                color: lineColor,
                radius: 8,
                x: 0,
                y: 10
            )
            .shadow(
                color: lineColor.opacity(0.5),
                radius: 8,
                x: 0,
                y: 15
            )
            .shadow(
                color: lineColor.opacity(0.3),
                radius: 8,
                x: 0,
                y: 20
            )
        }
    }

    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }

    private var chartYAxis: some View {
        VStack {
            Text(yMax.formattedWithAbbreviations())
            Spacer()
            Text(((yMax + yMin) * 0.5).formattedWithAbbreviations())
            Spacer()
            Text(yMin.formattedWithAbbreviations())
        }
    }

    private var chartDateLabel: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
