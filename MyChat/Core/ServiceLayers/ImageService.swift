//
//  ImageService.swift
//  MyChat
//
//  Created by Сергей Штейман on 12.12.2022.
//

import UIKit

protocol ImageCacheServicable {
    func save(image: UIImage, fileName: String) throws
    func fetchImage(with fileName: String) -> UIImage?
}

final class ImageCacheService: ImageCacheServicable {
    func save(image: UIImage, fileName: String) throws {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw LocalError.imageCacheDocumentsDirectory
        }

        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        guard let data = image.jpegData(compressionQuality: 1) else {
            throw LocalError.imageCacheData
        }

        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(atPath: fileURL.path)
        }

        try data.write(to: fileURL)
    }

    func fetchImage(with fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}

extension String {
    static let userAvatarFileName = "userAvatar.jpg"
}
