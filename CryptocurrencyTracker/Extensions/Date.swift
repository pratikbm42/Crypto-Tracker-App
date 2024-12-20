//
//  Date.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation

extension Date {
    /// Initializes a Date object from an ISO 8601 formatted string.
    /// If the string cannot be parsed, it defaults to the current date and time.
    /// ```
    /// // Example 1: Valid ISO 8601 String
    /// let date = Date(iso8601String: "2024-06-08T19:47:10.594Z")
    /// // date is now a valid Date object
    ///
    /// // Example 2: Invalid ISO 8601 String
    /// let invalidDate = Date(iso8601String: "invalid-date-string")
    /// // invalidDate is now the current date and time
    /// ```
    /// - Parameter iso8601String: The ISO 8601 formatted string to be converted.
    init(iso8601String: String) {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: iso8601String) ?? Date()
        self.init(timeInterval: 0, since: date)
    }

    /// Converts a Date object into a short date string representation.
    /// ```
    /// // Example
    /// let date = Date(iso8601String: "2024-06-08T19:47:10.594Z")
    /// let dateString = date.asShortDateString()
    /// // dateString might be "6/8/24" depending on the current locale
    /// ```
    /// - Returns: A string representation of the date in short date format.
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }

    /// A DateFormatter configured for short date style.
    /// ```
    /// // Example
    /// let formatter = Date().shortFormatter
    /// let dateString = formatter.string(from: Date())
    /// // dateString might be "6/8/24" depending on the current locale
    /// ```
    /// - Returns: A DateFormatter instance configured for short date style.
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
