//
//  LocalFileManager.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation
import SwiftUI

final class LocalFileManager {
    static let instance = LocalFileManager()
    private init() {
        // Do noting
    }

    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // Create folder
        createFolderIfNotExist(folderName: folderName)

        // Get path for image
        guard
            let data = image.pngData(),
            let imageURL = getImageURL(imageName: imageName, folderName: folderName)
        else { return }

        // Save image to path
        do {
            try data.write(to: imageURL)
        } catch {
            print("Error saving image. \(error)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let imageURL = getImageURL(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: imageURL.path)
        else { return nil }
        return UIImage(contentsOfFile: imageURL.path)
    }

    private func createFolderIfNotExist(folderName: String) {
        guard let folderURL = getFolderURL(folderName: folderName) else { return }

        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
            } catch {
                print("Error creating directory. Folder name: \(folderName) . \(error)")
            }
        }
    }

    private func getFolderURL(folderName: String) -> URL? {
        guard
            let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        return cachesURL.appendingPathComponent(folderName)
    }

    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getFolderURL(folderName: folderName)
        else { return nil }

        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
