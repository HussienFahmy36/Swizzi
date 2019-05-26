//
//  CardView.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/26/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

class PinCardCell: UICollectionViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var placeHolderCardImage: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var pinCategoryLabel: UILabel!
    override func awakeFromNib() {
        cardImage.clipsToBounds = true
        cardImage.layer.cornerRadius = 5
        userProfileImage.clipsToBounds = true
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height / 2
        cardImage.contentMode = .scaleAspectFill

    }
}

