//
//  CardsViewController+PinteresetLayoutDelegate.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/27/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import UIKit

extension PinsViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {

        return CGFloat(cardsItems[indexPath.item].height / scaleFactor) 
    }

}
