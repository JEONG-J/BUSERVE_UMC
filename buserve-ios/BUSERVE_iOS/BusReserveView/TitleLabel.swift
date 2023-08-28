//
//  TitleLabel.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/31.
//

import UIKit

class TitleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTitile()
    }
    
    func setTitile(){
        self.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        self.font = UIFont(name: "Pretendard-Regular", size: 16)
        
        
    }

}
