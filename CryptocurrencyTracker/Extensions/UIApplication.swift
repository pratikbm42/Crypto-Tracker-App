//
//  UIApplication.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    /// Function for hide keyboard
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
