//
//  BottomButtonView.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/27.
//

import UIKit

class BottomButtonView: UIButton {

    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupBottomButton(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBottomButton(_ title: String) {
        var configuration = UIButton.Configuration.filled()
        var titleAttr = AttributedString.init("\(title)")
        titleAttr.font = .bodyBold
        configuration.attributedTitle = titleAttr
        
        configuration.background.cornerRadius = 16

        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .MainColor
        
        self.configuration = configuration
        self.clipsToBounds = true
    }
}
