//
//  UIViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/10.
//

import UIKit

extension UIViewController {
    
    func showPopUp(message: String? = nil,
                   attributedMessage: NSAttributedString? = nil,
                   leftActionTitle: String? = nil,
                   rightActionTitle: String? = nil,
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        let popUpViewController = PopUpViewController(messageText: message, attributedMessageText: attributedMessage)
        
        showPopUp(popUpViewController: popUpViewController,
                  leftActionTitle: leftActionTitle,
                  rightActionTitle: rightActionTitle,
                  leftActionCompletion: leftActionCompletion,
                  rightActionCompletion: rightActionCompletion)
    }
    
    func showPopUp(contentView: UIView,
                   leftActionTitle: String? = nil,
                   rightActionTitle: String? = nil,
                   leftActionCompletion: (() -> Void)? = nil,
                   rightActionCompletion: (() -> Void)? = nil) {
        let popUpViewController = PopUpViewController(contentView: contentView)
        
        showPopUp(popUpViewController: popUpViewController,
                  leftActionTitle: leftActionTitle,
                  rightActionTitle: rightActionTitle,
                  leftActionCompletion: leftActionCompletion,
                  rightActionCompletion: rightActionCompletion)
    }
    
    private func showPopUp(popUpViewController: PopUpViewController,
                           leftActionTitle: String?,
                           rightActionTitle: String?,
                           leftActionCompletion: (() -> Void)?,
                           rightActionCompletion: (() -> Void)?) {
        popUpViewController.addActionBtn(title: leftActionTitle) {
            popUpViewController.dismiss(animated: false, completion: leftActionCompletion)
            print("cancel")
        }
        
        popUpViewController.addActionBtn(title: rightActionTitle) {
            popUpViewController.dismiss(animated: false, completion: rightActionCompletion)
            print("Click")
        }
        present(popUpViewController, animated: false, completion: nil)
    }
}

extension String {
    func toAttributedString() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
