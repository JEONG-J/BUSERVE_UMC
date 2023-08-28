//
//  NavigationExtension.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/18.
//

import Foundation
import UIKit

extension UINavigationController {
    func setCustomBackButton(title: String? = nil, image: UIImage? = nil, sfSymbol: String? = nil, textColor: UIColor? = nil, imageColor: UIColor? = nil, weight: UIImage.SymbolWeight? = nil) {
        guard let topVC = self.topViewController else { return }

        let backButton: UIBarButtonItem
        
        if let title = title {
            backButton = UIBarButtonItem(title: title, style: .plain, target: topVC, action: #selector(topVC.leftBackButtonTapped))
            backButton.tintColor = textColor
        } else if let image = image {
            backButton = UIBarButtonItem(image: image, style: .plain, target: topVC, action: #selector(topVC.leftBackButtonTapped))
            backButton.tintColor = imageColor
        } else if let sfSymbol = sfSymbol {
            let config = UIImage.SymbolConfiguration(weight: weight ?? .regular)
            let systemImage = UIImage(systemName: sfSymbol, withConfiguration: config)
            backButton = UIBarButtonItem(image: systemImage, style: .plain, target: topVC, action: #selector(topVC.leftBackButtonTapped))
            backButton.tintColor = imageColor
        } else {
            return
        }

        topVC.navigationItem.leftBarButtonItem = backButton
        topVC.navigationItem.hidesBackButton = true
    }
}

extension UIViewController {
    @objc func leftBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
