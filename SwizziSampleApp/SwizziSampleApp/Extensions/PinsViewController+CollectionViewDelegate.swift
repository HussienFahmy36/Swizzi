//
//  PinsViewController+CollectionViewDelegate.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/27/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import UIKit


extension PinsViewController {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout?.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardView", for: indexPath) as! PinCard
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let identifier = "PinImageViewController"
        if let pinDetailsVC = storyboard?.instantiateViewController(withIdentifier: identifier) as? PinImageViewController {
            self.navigationController?.pushViewController(pinDetailsVC, animated: true)
        }
    }

}
