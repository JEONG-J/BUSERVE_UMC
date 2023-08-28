//
//  SheetScrollView.swift
//
//  Created by 정의찬 on 2023/08/20.
//

import UIKit

class SheetScrollView: UIScrollView, UIScrollViewDelegate {
    
    var onPageChanged: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setScroll()
        self.delegate = self
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setScroll(){
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 0.75)
        self.isPagingEnabled = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            onPageChanged?(Int(pageNumber))
        }
    
    func addPages(numberOfPages: Int){
        for i in 0..<numberOfPages{
            let inforView = SheetInforViewInScroll()
            inforView.frame = CGRect(x: CGFloat(i) * self.frame.width, y: 0, width: self.frame.width, height: self.frame.height)
            self.addSubview(inforView)
        }
        self.contentSize = CGSize(width: self.frame.width * CGFloat(numberOfPages), height: self.frame.height)
    }
}
