//
//  PrintbusNumber.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/23.
//

import UIKit

class PrintbusNumber: UIButton {

    required init?(coder aDecorder : NSCoder) {
        super.init(coder: aDecorder)
        setButton()
    }
    
    func setButton(){
        self.setImage(UIImage(named: "white_bus.png"), for: .normal)
        self.tintColor = UIColor.white
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle("9802", for: .normal)
        self.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        self.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        self.layer.cornerRadius = 8
    }

}
