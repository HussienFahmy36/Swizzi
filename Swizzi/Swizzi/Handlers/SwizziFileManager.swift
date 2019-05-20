//
//  SwizziFileManager.swift
//  Swizzi
//
//  Created by Hussien Gamal Mohammed on 5/20/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

internal enum FileType: String {
    case json = "json"
}
internal class SwizziFileManager {

    func loadData(from bundle: Bundle, with fileName: String, andExt ext: FileType) -> Data? {
        switch ext {
        case .json:
            return dataFromJsonFile(bundle: bundle, with: fileName)
        }
    }


    private func dataFromJsonFile(bundle: Bundle, with fileName: String) -> Data? {
        guard let path = bundle.path(forResource: fileName, ofType: FileType.json.rawValue) else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let jsonData = try? Data(contentsOf: url) else {
            return nil
        }
        return jsonData
    }
}
