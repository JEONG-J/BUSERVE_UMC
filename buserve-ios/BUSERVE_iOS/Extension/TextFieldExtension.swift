//
//  TextFieldExtension.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/04.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addrightimage(image: UIImage) {
        let rightimage = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        rightimage.image = image
        self.rightView = rightimage
        self.rightViewMode = .always
    }
    
    func setRightViewWith(image: UIImage, width: CGFloat, height: CGFloat, paddingRight: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.image = image.withTintColor(.Body, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: width + paddingRight, height: height))
        view.addSubview(imageView)
        
        self.rightView = view
        self.rightViewMode = .always
    }
    
    func setLeftViewWith(image: UIImage, width: CGFloat, height: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat) {
        let imageView = UIImageView(frame: CGRect(x: paddingLeft, y: 0, width: width, height: height))
        imageView.image = image.withTintColor(.Body, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: width + paddingRight, height: height))
        view.addSubview(imageView)
        
        self.leftView = view
        self.leftViewMode = .always
    }
}
