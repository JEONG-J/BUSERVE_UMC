//
//  SeatBtn.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/07.
//

import UIKit

class SeatBtn: UIButton{

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setupBtn()
    }
    
    func setupBtn(){
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1)
        self.setTitle("좌석 예약하기", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
}
