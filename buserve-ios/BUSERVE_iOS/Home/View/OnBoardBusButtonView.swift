//
//  OnBoardBusButton.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/04.
//

import UIKit

class OnBoardBusButtonView: UIButton {

    // MARK: - Properties
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSocialButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.3 : 1
        }
    }

    // MARK: - methods or layouts
    
    func setupSocialButton() {
        var configuration = UIButton.Configuration.plain()
        
        let originalImage = UIImage(named: "BuserveLogo")
        let resizedImage = originalImage?.resized(to: CGSize(width: 34, height: 29))
        
        configuration.image = resizedImage
        configuration.imagePadding = 8
        configuration.imagePlacement = NSDirectionalRectEdge.top
        
        configuration.subtitle = "탑승하기"
        configuration.baseForegroundColor = .Secondary_TertiaryColor
        configuration.buttonSize = .small
        
        self.titleLabel?.font = .captionBold1
        self.configuration = configuration
        self.clipsToBounds = true
    }
}
