//
//  String.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation

extension String {
    func removeHTMLOccurances() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
