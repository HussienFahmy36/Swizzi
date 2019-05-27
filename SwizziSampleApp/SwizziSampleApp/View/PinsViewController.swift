//
//  ViewController.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/26/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit
import Swizzi
class PinsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    let scaleFactor = 10
    let itemsPerRow = 3
    var viewModels: [PinViewModel] = []
    let swizzi = Swizzi(with: Bundle.main)
    var pinDataWorker: PinsDataWorker = PinsDataWorker()
    var collectionViewLayout: PinterestLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        collectionViewLayout = cardsCollectionView.collectionViewLayout as? PinterestLayout
        collectionViewLayout?.delegate = self
        pinDataWorker.downloadViewModels(completionHandler: {[weak self] (viewModelsReceived, error) in
            guard let `self` = self else {
                return
            }
            if viewModelsReceived.count > 0 &&
                error == nil {
                self.viewModels = viewModelsReceived
                DispatchQueue.main.async {
                    self.cardsCollectionView.reloadData()

                }
            }
        })
    }
}

