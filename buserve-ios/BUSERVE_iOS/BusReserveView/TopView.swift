//
//  TopView.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/31.
//

import UIKit

class TopView: UIView {

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    func setView(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 2, height: 2) // 위치조정
        self.layer.shadowRadius = 8 // 반경
        self.layer.shadowOpacity = 1 // alpha값  */
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                         y: bounds.maxY - layer.shadowRadius,
                                                         width: bounds.width,
                                                         height: layer.shadowRadius)).cgPath
    }
}
