//
//  MapPageControl.swift
//
//  Created by 정의찬 on 2023/08/22.
//

import UIKit

class MapPageControl: UIPageControl {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setPage()
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setPage(){
        self.backgroundColor = .clear
        self.pageIndicatorTintColor = .gray
        self.currentPageIndicatorTintColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1)
        self.currentPage = 0
    }
}
