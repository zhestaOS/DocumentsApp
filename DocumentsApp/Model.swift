//
//  Model.swift
//  DocumentsApp
//
//  Created by Евгения Шевякова on 06.09.2023.
//

import UIKit

class Model {
    
    var path: String

    init(path: String) {
        self.path = path
    }

    var items: [String] {
        if UserDefaults().bool(forKey: isSortToAlphabetical) {
            return (try? FileManager.default.contentsOfDirectory(atPath: path))?.sorted(by: { $0 > $1 }) ?? []
        } else {
            return (try? FileManager.default.contentsOfDirectory(atPath: path))?.sorted(by: { $0 < $1 }) ?? []
        }
    }

    func addImage(image: UIImage) {

        let name = UUID().uuidString
        let url = URL(filePath: path).appending(component: name)

        if let data = image.pngData() {
            do {
                try data.write(to: url)
            } catch {
                print("Unable to write image data to disk")
                print(error.localizedDescription)
            }
        }
    }

    func deleteItem(withIndex index: Int) {
        let pathForDelete = path + "/" + items[index]
        try? FileManager.default.removeItem(atPath: pathForDelete)
    }
}
