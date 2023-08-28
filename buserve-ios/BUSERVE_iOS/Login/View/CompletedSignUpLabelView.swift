//
//  CompletedSignUpLabelView.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/27.
//

import UIKit

class CompletedSignUpLabelView: UIView {

    lazy var competedTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가입이 완료 되었습니다 :)"
        label.font = .subtitleBold
        label.textColor = .Body
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    lazy var competedSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금부터 BUSERVE로\n버스 좌석 예약을 하러 가볼까요?"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .body_Reading
        label.textColor = .Secondary_TertiaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureLabel() {
        
        [competedTitleLabel, competedSubtitleLabel].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            competedTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            competedTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            competedTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            
            competedSubtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            competedSubtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            competedSubtitleLabel.topAnchor.constraint(equalTo: competedTitleLabel.bottomAnchor, constant: 16),
            competedSubtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    
        ])
    }
}
