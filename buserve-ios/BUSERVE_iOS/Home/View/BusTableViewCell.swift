//
//  BusTableViewCell.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/05.
//

import UIKit

class BusTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let busCellId = "BusCellId"
    var onBookmarkButtonTap: (() -> Void)?
    weak var delegate: BusTableViewCellDelegate?
    
    lazy var busImage: UIImageView = {
       let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        image.image = (traitCollection.userInterfaceStyle == .dark) ? UIImage(named: "DarkModeBus") : UIImage(named: "LightModeBus")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var busNum: UILabel = {
        var label = UILabel()
        label.font = .headingBold
        label.textColor = .Body
        label.sizeToFit()
        return label
    }()

    lazy var routeMap: UILabel = {
        var label = UILabel()
        label.font = .body
        label.textColor = .Body
        label.sizeToFit()
        return label
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 119).isActive = true
        return button
    }()
                  
    lazy var reservationButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.baseBackgroundColor = .MainColor
        button.configuration?.background.cornerRadius = 15
        button.widthAnchor.constraint(equalToConstant: 156).isActive = true
        var titleContainer = AttributeContainer()
        titleContainer.font = .bodyBold
        
        button.configuration?.attributedTitle = AttributedString("좌석 예약하기", attributes: titleContainer)
        
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.addArrangedSubview(busImage)
        
        let spacingView1 = UIView()
        spacingView1.widthAnchor.constraint(equalToConstant: 6).isActive = true
        
        
        stackView.addArrangedSubview(spacingView1)
        
        stackView.addArrangedSubview(busNum)
        

        let spacingView2 = UIView()
        spacingView2.widthAnchor.constraint(equalToConstant: 16).isActive = true
        

        stackView.addArrangedSubview(spacingView2)
        stackView.addArrangedSubview(routeMap)
        
        busNum.setContentHuggingPriority(.required, for: .horizontal)
        routeMap.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        busImage.widthAnchor.constraint(equalToConstant: 18).isActive = true
        spacingView1.widthAnchor.constraint(equalToConstant: 6).isActive = true
        spacingView2.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(reservationButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycles
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .Background
        
        self.addSubview(topStackView)
        contentView.addSubview(bottomStackView)
        
        configureTableCell()

        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonClicked), for: .touchUpInside)
        
        reservationButton.addTarget(self, action: #selector(reservationButtonClicked), for: .touchUpInside)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemneted")
    }

    // MARK: - methods or layouts
    
    private func configureTableCell() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            topStackView.widthAnchor.constraint(equalToConstant: 295),

            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
    
    @objc func bookmarkButtonClicked(_ sender: UIButton) {
        onBookmarkButtonTap?()
    }

    @objc func reservationButtonClicked(_ sender: UIButton) {
        delegate?.didTapReservationButton()
    }
    
    func settingBookmarkButton(isBookmarked: Bool) {
        if isBookmarked {
            bookmarkButton.configuration = UIButton.Configuration.bookmarkButtonStyle(style: .bookmarked, traitCollection: self.traitCollection)
        } else {
            bookmarkButton.configuration = UIButton.Configuration.bookmarkButtonStyle(style: .notBookmarked, traitCollection: self.traitCollection)
        }
    }
    
    /// ( 라이트, 다크 ) 모드가 변경되었을 때 TableView 의 UI 색상을 업데이트
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            busImage.image = (traitCollection.userInterfaceStyle == .dark) ? UIImage(named: "DarkModeBus") : UIImage(named: "LightModeBus")
        }
    }
}

protocol BusTableViewCellDelegate: AnyObject {
    func didTapReservationButton()
}
