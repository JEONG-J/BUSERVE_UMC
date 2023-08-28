//
//  HomeTitleLabelView.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/04.
//

import UIKit

class HomeTitleLabelView: UIView {
    
    // MARK: - Properties
    
    lazy var buserveTitle: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "BuserveTitle")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    lazy var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘도"
        label.font = .subtitleBold
        label.textColor = .Body
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    lazy var rightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "와"
        label.font = .subtitleBold
        label.textColor = .Body
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    lazy var bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "함께 출근해요"
        label.font = .subtitleBold
        label.textColor = .Body
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(leftTitleLabel)
        stackView.addArrangedSubview(buserveTitle)
        stackView.addArrangedSubview(rightTitleLabel)
        
        leftTitleLabel.widthAnchor.constraint(equalToConstant: 63).isActive = true
        rightTitleLabel.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .fill

        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomTitleLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - methods or layouts
    
    private func configureLabel() {
        [verticalStackView].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
