//
//  PinsProvider.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/27/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import Swizzi

class PinsDataWorker {

    let urlToDownload: URL? = URL(string: "http://pastebin.com/raw/wgkJgazE")
    let swizzi: Swizzi = Swizzi(with: Bundle.main)

    init() {
    }

    func downloadViewModels(completionHandler: @escaping ([PinViewModel], SwizziError?) -> ()) {
        if let url = urlToDownload{
            _ = swizzi.downloadAsync(from: url, completionHandler: { (data, error) in
                if error == nil {
                    let parser = SwizziJsonParser()
                    if let cardsParsed = parser.parse(data: data, to: [PinModel].self) {
                        let viewModels = cardsParsed.compactMap({PinViewModel.init(model: $0)})
                        completionHandler(viewModels, nil)
                        } else{
                        completionHandler([], error)
                    }
                } else {
                    completionHandler([], error)
                }
            })
        } else {
            completionHandler([], nil)
        }
    }
}
