//
//  BusSerachTextField.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/04.
//

import UIKit

class BusSearchTextField: UITextField, UITextFieldDelegate {

    // MARK: - Properties
    
    weak var searchDelegate: BusSearchTextFieldDelegate?
    var textPadding = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 10)
    
    private lazy var clearButton: UIButton =  {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .Tertiary
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.delegate = self
        self.placeholder = "예약하려는 버스를 검색해주세요."
        self.clearButtonMode = .whileEditing
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let configuration = UIImage.SymbolConfiguration(weight: .medium)
        
        if let image = UIImage(systemName: "magnifyingglass", withConfiguration: configuration) {
            setLeftViewWith(image: image, width: 22, height: 22, paddingLeft: 16, paddingRight: 3)
        }

        /// TextField 오른쪽에 버튼과 Padding 을 같이 포함하기 위한 내용
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: clearButton.frame.width + 13.87, height: 20))
        rightView.addSubview(clearButton)

        self.rightView = rightView
        self.rightViewMode = .whileEditing
        self.rightView?.isHidden = true
        self.clipsToBounds = true
        
        /// palceholder 의 색상을 바꾸기 위한 코드
        if let originalPlaceholder = self.placeholder {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: (traitCollection.userInterfaceStyle == .dark) ? UIColor.Tertiary : UIColor.Secondary,
                .font: UIFont.systemFont(ofSize: 16)
            ]

            self.attributedPlaceholder = NSAttributedString(string: originalPlaceholder, attributes: attributes)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        borderStyle = .none
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 2.5
        layer.borderColor = UIColor.MainColor.cgColor
        layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        layer.shadowOpacity = 0.6

        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2).cgPath
        layer.backgroundColor = UIColor.DarkModeSecondBackground.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - methods or layouts
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    /// x 버튼을 눌렀을 때 동작
    @objc func clearButtonTapped() {
        self.text = ""
        self.rightView?.isHidden = true
        searchDelegate?.busSearchTextFieldDidChange(self, text: "")
    }
    
    /// TextField 의 Text 값이 변경될 때 마다 동작 -> 값이 있다면 x 버튼을 보이게 변경
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            self.rightView?.isHidden = true
        } else {
            self.rightView?.isHidden = false
        }
        
        searchDelegate?.busSearchTextFieldDidChange(self, text: textField.text)
    }
}

protocol BusSearchTextFieldDelegate: AnyObject {
    func busSearchTextFieldDidChange(_ textField: BusSearchTextField, text: String?)
}
