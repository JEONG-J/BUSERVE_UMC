//  SeatCollectionViewCell.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/07.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {
    
    var seatNum : UILabel!

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        setCell()
        setTitle()
    }
    func setTitle(){
        seatNum = UILabel()
        seatNum.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(seatNum)
        seatNum.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        seatNum.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    func setCell(){
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1).cgColor
    }
}
