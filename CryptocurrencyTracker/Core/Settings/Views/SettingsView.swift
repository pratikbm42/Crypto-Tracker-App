//
//  SettingsView.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView(content: {
            List {
                appSection
                coinGeckoSection
                developerSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton {
                        dismiss()
                    }
                }
            })
        })
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var appSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is created by Pratik Morge using MVVM architecture, Combine, and CoreData for a robust and efficient structure.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
        } header: {
            Text("Crypto Tracker App")
        }
    }

    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text("The crypto currency data that is used in this app comes from a free API CoinGecko!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let url = URL(string: Constants.coingeckoUrl) {
                Link("Visit CoinGecko", destination: url)
                    .foregroundStyle(.blue)
            }
        } header: {
            Text("CoinGecko")
        }
    }

    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("dev-avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("This app is develop by Pratik Morge. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let url = URL(string: Constants.githubProjectURL) {
                Link(destination: url, label: {
                    HStack {
                        Image("github-icon")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        Text("Github")
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.blue)
            }
            if let url = URL(string: Constants.discordDevURL) {
                Link(destination: url, label: {
                    HStack {
                        Image("discord-icon")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("Discord")
                    }

                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.blue)
            }

        } header: {
            Text("Developer")
        }
    }
}
