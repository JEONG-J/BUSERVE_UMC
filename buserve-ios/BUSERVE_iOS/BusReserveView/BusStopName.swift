//
//  BusStopName.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/31.
//

import UIKit

class BusStopName: UIButton {

    required init?(coder aDecorder : NSCoder) {
        super.init(coder: aDecorder)
        setButton()
    }
    
    func setButton(){
        self.setImage(UIImage(named: "black_bus.png"), for: .normal)
        self.tintColor = UIColor.black
        self.setTitleColor(UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1), for: .normal)
        self.setTitle("공단사거리", for: .normal)
        self.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(red: 0.80, green: 0.83, blue: 0.85, alpha: 1.00).cgColor
        self.layer.borderWidth = 1
    }

}
