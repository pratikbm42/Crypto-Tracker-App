//
//  SearchBarView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty
                    ? Color.theme.secondaryText
                    : Color.theme.accent
                )
            TextField("Search by name or symbol", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .keyboardType(.webSearch)
                .autocorrectionDisabled(true)

            if !searchText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(searchText.isEmpty
                        ? Color.theme.secondaryText
                        : Color.theme.accent
                    )
                    .onTapGesture {
                        searchText = ""
                        UIApplication.shared.endEditing()
                    }
            }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15), radius: 10
                )
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
