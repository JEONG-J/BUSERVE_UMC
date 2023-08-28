//
//  SocialLoginButtonView.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/26.
//

import UIKit

class SocialLoginButtonView: UIButton {

    var loginType: socialLoginType

    init(type: socialLoginType) {
        self.loginType = type
        super.init(frame: .zero)
        setupSocialButton(loginType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.6 : 1
        }
    }

    func setupSocialButton(_ type: socialLoginType) {
        var configuration = UIButton.Configuration.filled()

        configuration.image = type.image
        configuration.title = type.title
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = type.titleColor
        configuration.baseBackgroundColor = type.backColor
        configuration.imagePadding = 6

        switch type {
        case .google:
            print("google 버튼 생성")
            configuration.background.strokeColor = .Body
            if self.traitCollection.userInterfaceStyle == .dark {
                configuration.background.strokeWidth = 0
                print("google Dark")
            } else {
                print("google")
                configuration.background.strokeWidth = 1
                self.setNeedsLayout()
            }
        case .apple:
            print("Apple 버튼 생성")
            configuration.background.strokeColor = .white
            if self.traitCollection.userInterfaceStyle == .dark {
                print("Apple Dark")
                configuration.background.strokeWidth = 1
            } else {
                print("Apple")
                configuration.background.strokeWidth = 0
            }
            
            self.setNeedsLayout()
        default:
            break
        }
        
//        if self.traitCollection.userInterfaceStyle == .dark && type == .google {
//            configuration.background.strokeWidth = 0
//        } else if type == .google {
//            configuration.background.strokeColor = .Body
//            configuration.background.strokeWidth = 1
//        }
//
//
//        if self.traitCollection.userInterfaceStyle == .dark && type == .apple {
//            configuration.background.strokeColor = .white // or your desired color
//            configuration.background.strokeWidth = 1
//        } else if type == .apple {
//            configuration.background.strokeWidth = 0
//        }

        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.configuration = configuration
        self.clipsToBounds = true
    }
}

enum socialLoginType: String {
    case kakao, google, apple
    
    var image: UIImage? {
        switch self {
        case .kakao:
            return UIImage(named: "KakaoTalk")
        case .google:
            return UIImage(named: "Google")
        case .apple :
            return UIImage(named: "Apple")
        }
    }
    
    var title: String {
        switch self {
        case .kakao:
            return "Kakao로 시작하기"
        case .google:
            return "Google로 시작하기"
        case .apple :
            return "Apple로 시작하기"
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .kakao, .google:
            return .LoginTextColor
        case .apple:
            return .white
        }
    }
    
    var backColor: UIColor {
        switch self {
        case .kakao:
            return .KakaoBackground
        case .google:
            return .GoogleBackground
        case .apple :
            return .AppleBackground
        }
    }
}

