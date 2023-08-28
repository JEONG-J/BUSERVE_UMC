//
//  BusStopTitle.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/01.
//

import UIKit

class BusStopTitle: currentDay{
    
    required init?(coder aDecorder : NSCoder) {
        super.init(coder: aDecorder)
    }
    
    override func setTitle() {
        super.setTitle()
        self.text = "시민의숲.양재꽃시장 방면"
        self.textAlignment = .center
    }
}
