//
//  PopUpViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/10.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {

    private var messageText: String?
    private var attributedMessageText: NSAttributedString?
    private var contentView: UIView?

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .ButtonAlertBackground // .white
        view.layer.cornerRadius = 16
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        return view
    }()

    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12.0
        view.alignment = .center

        return view
    }()

    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 14.0
        view.distribution = .fillEqually

        return view
    }()

    private lazy var messageLabel: UILabel? = {
        guard messageText != nil || attributedMessageText != nil else { return nil }

        let label = UILabel()
        label.text = messageText
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textColor = .Body // UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        label.numberOfLines = 0

        if let attributedMessageText = attributedMessageText?.mutableCopy() as? NSMutableAttributedString {
            
            if let regularFont = UIFont(name: "Pretendard-Regular", size: 16) {
                    let fullRange = NSRange(location: 0, length: attributedMessageText.length)
                    attributedMessageText.addAttributes([.font: regularFont], range: fullRange)
                }
                
            
            if let partBold = UIFont(name: "Pretendard-SemiBold", size: 16){
                let boldWords = ["버스 좌석", "예약", "노쇼 방지", "위치 인증"]
                
                for word in boldWords{
                    let range = (attributedMessageText.string as NSString).range(of: word)
                    if range.location != NSNotFound{
                        attributedMessageText.addAttributes([.font: partBold], range: range)
                    }
                }
            }
            label.attributedText = attributedMessageText
        }

        return label
    }()

    
    convenience init(messageText: String? = nil,
                     attributedMessageText: NSAttributedString? = nil) {
        self.init()

        self.messageText = messageText
        self.attributedMessageText = attributedMessageText
        modalPresentationStyle = .overFullScreen
    }

    convenience init(contentView: UIView) {
        self.init()

        self.contentView = contentView
        modalPresentationStyle = .overFullScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addSubviews()
        makeConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }

    public func addActionBtn(title: String? = nil,
                            titleColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                            backgroundColor: UIColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1),
                            completion: (() -> Void)? = nil) {
        guard let title = title else { return }

        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)

        // enable
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setBackgroundImage(backgroundColor.image(), for: .normal)

        // disable
        button.setTitleColor(.gray, for: .disabled)
        button.setBackgroundImage(UIColor.gray.image(), for: .disabled)

        // layer
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true

        button.addAction(for: .touchUpInside) { _ in
            completion?()
        }

        buttonStackView.addArrangedSubview(button)
    }

    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(containerStackView)
        view.backgroundColor = .gray.withAlphaComponent(0.8)
    }

    private func addSubviews() {
        view.addSubview(containerStackView)

        if let contentView = contentView {
            containerStackView.addSubview(contentView)
        } else {
            if let messageLabel = messageLabel {
                containerStackView.addArrangedSubview(messageLabel)
            }
        }

        if let lastView = containerStackView.subviews.last {
            containerStackView.setCustomSpacing(24.0, after: lastView)
        }

        containerStackView.addArrangedSubview(buttonStackView)
    }

    private func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.heightAnchor.constraint(equalToConstant: 216).isActive = true

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -298),

            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),

            buttonStackView.heightAnchor.constraint(equalToConstant: 48),
            buttonStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor)
        ])
    }
}

// MARK: - Extension

extension UIColor {
    /// Convert color to image
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UIControl {
    public typealias UIControlTargetClosure = (UIControl) -> ()

    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }

    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure

        } set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }

    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }

}
