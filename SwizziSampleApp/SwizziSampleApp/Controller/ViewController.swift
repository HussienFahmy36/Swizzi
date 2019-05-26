//
//  ViewController.swift
//  SwizziSampleApp
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
        swizzi.downloadAsync(from: URL(string: "http://pastebin.com/raw/wgkJgazE")!) { (data, error) in
            let parser = SwizziJsonParser()
            let dataDecoded = parser.parse(data: data, to: [PhotoElement].self)
            print(dataDecoded)

        }
    }


}

