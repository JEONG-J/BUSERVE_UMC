//
//  CollectionTitle.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/07.
//

import UIKit

class CollectionTitle: UILabel {

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setTitle()
    }
    
    func setTitle(){
        self.textColor = UIColor(red: 0.525, green: 0.557, blue: 0.588, alpha: 1)
        self.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }

}
