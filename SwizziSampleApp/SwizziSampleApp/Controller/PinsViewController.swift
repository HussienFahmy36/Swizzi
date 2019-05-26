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
    var cardsItems: [PhotoElement] = []
    var taskIds: [Int] = []
    let swizzi = Swizzi(with: Bundle.main)
    var collectionViewLayout: PinterestLayout?

    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self

        collectionViewLayout = cardsCollectionView.collectionViewLayout as? PinterestLayout
        collectionViewLayout?.delegate = self
        let _ = swizzi.downloadAsync(from: URL(string: "http://pastebin.com/raw/wgkJgazE")!) {[weak self] (data, error) in
            guard let `self` = self else {
                return
            }
            let parser = SwizziJsonParser()
            if let cardsParsed = parser.parse(data: data, to: [PhotoElement].self) as? [PhotoElement] {
                self.cardsItems = cardsParsed
                DispatchQueue.main.async {[weak self] in
                    guard let `self` = self else {
                        return
                    }
                    self.cardsCollectionView.reloadData()
                }
            }

        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout?.invalidateLayout()
    }

    //MARK: - UICollectionViewDataSource + UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemToDownload = cardsItems[indexPath.row]
        var image = UIImage()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardView", for: indexPath) as! PinCardCell
        cell.userNameLabel.text = itemToDownload.user.username
        var categoriesText = "Categories: "
        itemToDownload.categories.forEach({
            categoriesText += $0.title.rawValue + ", "
        })
        let start = categoriesText.index(categoriesText.endIndex, offsetBy: -2)
        let end = categoriesText.endIndex

        categoriesText.replaceSubrange(start..<end, with: "")
        cell.pinCategoryLabel.text = categoriesText
        swizzi.downloadAsync(from: URL(string: itemToDownload.user.profileImage.small)!) { (data, error) in
            if error == nil {
                DispatchQueue.main.async {
                cell.userProfileImage.image = UIImage(data: data!)
                }
            }
        }
        cell.loadingIndicator.startAnimating()
        let taskID = swizzi.downloadAsync(from: URL(string: itemToDownload.urls.thumb)!) { (data, swizziError) in
            DispatchQueue.main.async {
                cell.loadingIndicator.stopAnimating()
                cell.loadingIndicator.isHidden = true
            }
            if swizziError == nil {
                if data != nil {
                    image = UIImage(data: data!) ?? UIImage()
                    DispatchQueue.main.async {
                        if image.size == .zero {
                            cell.placeHolderCardImage.isHidden = true
                            cell.cardImage.isHidden = true
                        }
                        else {
                            cell.cardImage.isHidden = false
                            cell.cardImage.image = image
                            cell.placeHolderCardImage.isHidden = true

                        }
                    }
                }

            }
            else {
                DispatchQueue.main.async {
                    cell.placeHolderCardImage.isHidden = false
                    cell.cardImage.isHidden = true
                    cell.placeHolderCardImage.text = "\(swizziError!.title.rawValue)"
                }
            }
        }
        taskIds.append(taskID)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

