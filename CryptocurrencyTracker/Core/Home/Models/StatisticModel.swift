//
//  StatisticModel.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?

    init(title: String, value: String, precentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = precentageChange
    }
}
