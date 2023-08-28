//
//  BusDataTableViewCell.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/31.
//

import UIKit

protocol ButtonTappedDelegate: AnyObject {
    func cellButtonTapped(index: Int?)
}

class BusDataTableViewCell: UITableViewCell {

    static let tableCellId = "BusCell"
    weak var delegate: ButtonTappedDelegate?
    var index: Int?
    
    @objc func checkBoxButtonTapped(sender: UIButton) {
        delegate?.cellButtonTapped(index: index)
    }
    
    lazy var busImage: UIImageView = {
       let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        image.image = UIImage(named: "bus")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var busNum: UILabel = {
        var label = UILabel()
        label.font = .headingBold
        label.textColor = .Body
        return label
    }()

    lazy var routeMap: UILabel = {
        var label = UILabel()
        label.font = .body
        label.textColor = .Body
        return label
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 119).isActive = true
        return button
    }()
                  
    lazy var reservationButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = "좌석 예약하기"
        button.configuration?.baseBackgroundColor = .MainColor
        button.configuration?.background.cornerRadius = 16
        
        var titleContainer = AttributeContainer()
        titleContainer.font = .bodyBold
        
        button.configuration?.attributedTitle = AttributedString("좌석 예약하기", attributes: titleContainer)
        
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6

        stackView.addArrangedSubview(busImage)
        stackView.addArrangedSubview(busNum)
        
        let spacingView = UIView()
        spacingView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        stackView.addArrangedSubview(spacingView)
        stackView.addArrangedSubview(routeMap)

        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(reservationButton)
    
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(topStackView)
        contentView.addSubview(bottomStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        configureTableCell()

        bookmarkButton.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemneted")
    }

    private func configureTableCell() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}
