//
//  PlaceholderView.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/15.
//

import UIKit

class PlaceHolderView: UIView {

    // MARK: - Properties
    
    lazy var busImage: UIImageView = {
       let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        image.image = (traitCollection.userInterfaceStyle == .dark) ? UIImage(named: "DarkModeBuserveLogo") : UIImage(named: "LightModeBuserveLogo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    lazy var placeHolderLabel: UILabel = {
//        var label = UILabel()
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 3
//        paragraphStyle.alignment = .center
//
//        let attributedString = NSAttributedString(string: "예약하려는\n버스를 검색해주세요.",
//                                                  attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
//                                                               NSAttributedString.Key.font: UIFont.body,
//                                                               NSAttributedString.Key.foregroundColor: UIColor.Secondary_TertiaryColor])
//
//        label.attributedText = attributedString
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configurePlaceHolder()
    }
    
    convenience init(placeholderText: String) {
        self.init(frame: .zero)
        setPlaceholderText(placeholderText)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - methods or layouts
    
    private func configurePlaceHolder() {
        [busImage, placeHolderLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            busImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            busImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            busImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            busImage.bottomAnchor.constraint(equalTo: self.placeHolderLabel.topAnchor, constant: -20),
            
            placeHolderLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            placeHolderLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            placeHolderLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setPlaceholderText(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = .center
        
        let attributedString = NSAttributedString(string: text,
                                                  attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                               NSAttributedString.Key.font: UIFont.body,
                                                               NSAttributedString.Key.foregroundColor: UIColor.Secondary_TertiaryColor])
        
        placeHolderLabel.attributedText = attributedString
    }
    
    /// ( 라이트, 다크 ) 모드가 변경되었을 때 TableView 의 UI 색상을 업데이트
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            busImage.image = (traitCollection.userInterfaceStyle == .dark) ? UIImage(named: "DarkModeBuserveLogo") : UIImage(named: "LightModeBuserveLogo")
        }
    }
}
