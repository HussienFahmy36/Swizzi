//
//  PinCardViewModel.swift
//  SwizziSampleApp
//
//  Created by Hussien Gamal Mohammed on 5/27/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import UIKit
import Swizzi

extension URL {
    static func urlFrom(absolutePath: String) -> URL {
        return URL(string: absolutePath)!
    }
}
class PinViewModel {

    let swizzi = Swizzi(with: Bundle.main)
    var model: PinModel?
    var pinImage: UIImage?
    var pinUserName: String?
    var pinUserProfileImage: UIImage?
    var pinCategories: String?
    var pinImageTaskID: Int = 0
    var userProfileImageTaskID: Int = 0
    var errorMessage: String?
    var height: Int = 0
    var userName: String = ""

    init(model: PinModel) {
        self.model = model
        height = self.model?.height ?? 0
        userName = self.model?.user.username ?? ""
        pinCategories = categoriesString()
    }

    func downloadPinImage(downloadCompletion: @escaping () -> ()) {
        guard let modelToUser = model else {
            return
        }
        let pinImagePath = modelToUser.urls.regular
        pinImageTaskID = swizzi.downloadAsync(from: URL.urlFrom(absolutePath: pinImagePath), completionHandler: {[weak self] (data, error) in
            guard let `self` = self else {
                return
            }
            if data != nil && error == nil {
                DispatchQueue.main.async {[weak self] in
                    guard let `self` = self else {
                        return
                    }
                    self.pinImage = UIImage(data: data!)
                    downloadCompletion()
                }
            }
            else {
                self.errorMessage = error?.title.rawValue
                downloadCompletion()
            }
        })
    }

    func downloadUserProfileImage(downloadCompletion: @escaping () -> ()) {
        guard let modelToUser = model else {
            return
        }
        let pinImagePath = modelToUser.user.profileImage.small
        userProfileImageTaskID = swizzi.downloadAsync(from: URL.urlFrom(absolutePath: pinImagePath), completionHandler: {[weak self] (data, error) in
            guard let `self` = self else {
                return
            }
            if data != nil && error == nil {
                DispatchQueue.main.async {[weak self] in
                    guard let `self` = self else {
                        return
                    }
                    self.pinUserProfileImage = UIImage(data: data!)
                    downloadCompletion()

                }
            }
            else {
                self.errorMessage = error?.title.rawValue
                downloadCompletion()

            }
        })
    }

    private func categoriesString() -> String {

        let categoriesTitles = self.model?.categories.compactMap({$0.title.rawValue})
        let stringArray2 = categoriesTitles!.map({String($0)})
        let categoriesString = stringArray2.joined(separator: ", ")
        return categoriesString
//        let start = categoriesText.index(categoriesText.endIndex, offsetBy: -2)
//        let end = categoriesText.endIndex
//
//        categoriesText.replaceSubrange(start..<end, with: "")
//        cell.pinCategoryLabel.text = categoriesText

    }
}
