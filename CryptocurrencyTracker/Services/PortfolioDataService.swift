//
//  PortfolioDataService.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import CoreData
import Foundation

class PortfolioDataService {
    @Published var savedEntities: [PortfolioEntity] = []

    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"

    init() {
        self.container = NSPersistentContainer(name: self.containerName)
        self.container.loadPersistentStores { _, error in
            if let error = error {
                print("ERROR: Loading Core Data ... \(error)")
            }
        }
        self.getPortfolio()
    }

    // MARK: PUBLIC

    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = self.savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                self.update(entity: entity, amount: amount)
            } else {
                self.delete(entity: entity)
            }
        } else {
            self.add(coin: coin, amount: amount)
        }
    }

    // MARK: PRIVATE

    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: self.entityName)
        do {
            self.savedEntities = try self.container.viewContext.fetch(request)
        } catch {
            print("ERROR: Fetching Portfolio Entities ...")
        }
    }

    private func saveData() {
        do {
            try self.container.viewContext.save()
        } catch {
            print("ERROR: Saving to CORE Data ...")
        }
    }

    private func applyChanges() {
        self.saveData()
        self.getPortfolio()
    }

    private func add(coin: CoinModel, amount: Double) {
        let newEntity = PortfolioEntity(context: self.container.viewContext)
        newEntity.coinId = coin.id
        newEntity.amount = amount
        self.applyChanges()
    }

    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        self.applyChanges()
    }

    private func delete(entity: PortfolioEntity) {
        self.container.viewContext.delete(entity)
        self.applyChanges()
    }
}
