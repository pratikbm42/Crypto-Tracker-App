//
//  Double.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Converts a Double into a  Currency as a String with 2 decimals places
    /// ```
    /// convert 1234.5678 to "$1,234.56"
    /// convert 12.3456 to "$12.34"
    /// convert 0.15225 to "$0.15"
    /// ```
    func asCurrencyWithDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }

    /// Converts a Double into a String representation
    /// ```
    /// convert 1234.5678 to "1234.56"
    /// convert 12.3456 to "12.34"
    /// convert 0.15225 to "0.15"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }

    /// Converts a Double into a String representation with percent symbol
    /// ```
    /// convert 1234.5678 to "1234.56%"
    /// convert 12.3456 to "12.34%"
    /// convert 0.15225 to "0.15%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }

    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
}
