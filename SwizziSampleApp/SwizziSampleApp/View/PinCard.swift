//
//  CardView.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/26/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

class PinCard: UICollectionViewCell {

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

    func configure(with viewModel: PinViewModel) {
        loadingIndicator.isHidden = false
        self.placeHolderCardImage.isHidden = true
        loadingIndicator.startAnimating()
        viewModel.downloadUserProfileImage {
            viewModel.downloadPinImage {
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.isHidden = true
                    self.userProfileImage.image = viewModel.pinUserProfileImage
                    self.cardImage.image = viewModel.pinImage
                    if self.cardImage.image?.size == CGSize.zero || self.cardImage.image == nil {
                        self.placeHolderCardImage.text = "Image not found"
                        self.placeHolderCardImage.isHidden = false
                        self.cardImage.isHidden = true

                    }
                    else {
                        self.placeHolderCardImage.isHidden = true
                        self.cardImage.isHidden = false
                    }
                    
                }

            }
        }
        userNameLabel.text = viewModel.userName
        pinCategoryLabel.text = viewModel.pinCategories
    }
}

