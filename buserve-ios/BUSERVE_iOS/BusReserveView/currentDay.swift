//
//  currentDay.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/31.
//

import UIKit

class currentDay: UILabel {

    required init?(coder aDecorder : NSCoder) {
        super.init(coder: aDecorder)
        setTitle()
    }

    func setTitle(){
        self.text = "2023년 7월 14일 (금)"
        self.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        self.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        
        self.attributedText = NSMutableAttributedString(string: self.text!,
                                                        attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.paragraphStyle: paragraphStyle])

    }
}
