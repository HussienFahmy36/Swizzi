//
//  ViewController.swift
//  SwizziImageDownloader
//
//  Created by Hussien Gamal Mohammed on 5/26/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit
import Swizzi

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let swizzi = Swizzi(with: Bundle.main)

        let path = Bundle.main.path(forResource: "BaseJson", ofType: "json")
        swizzi.downloadAsync(from: URL(fileURLWithPath: path!)) { (data, erro) in

            let parser = SwizziJsonParser()
            let decoder = JSONDecoder()
            let dataDecoded = try? decoder.decode([PhotoElement].self, from: data!)
        }
    }


}

