//
//  SheetViewController.swift

//
//  Created by 정의찬 on 2023/08/20.
//

import UIKit

class SheetView: UIView {
    
    let lat = 37.505158
    let lng = 126.957111

    
    var reserveBusMarker: ReserveBusMarker?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeConstraints()
        addPagesToScrollView(numberOfPages: 3)
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    private lazy var titleText : UILabel = {
        let title = UILabel()
        title.text = "내 예약 길찾기"
        title.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        title.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var inforView : SheetInforViewInScroll = {
        let infor = SheetInforViewInScroll()
        return infor
    }()
    
    private lazy var scrollView : SheetScrollView = {
        let scroll = SheetScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var  pageControl : MapPageControl = {
       let page = MapPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    func addPagesToScrollView(numberOfPages: Int) {
            scrollView.addPages(numberOfPages: numberOfPages)
            pageControl.numberOfPages = numberOfPages
        }
    
    
    
    private func makeConstraints(){
        [titleText, scrollView, pageControl].forEach { (self.addSubview($0))}
        
        scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 158).isActive = true
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 253),
            
            scrollView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ])
    }
    
    


}
