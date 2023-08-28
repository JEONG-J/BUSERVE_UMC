//
//  LoginViewController.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/26.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private var kakaoLoginButton = SocialLoginButtonView(type: .kakao)
    private var googleLoginButton = SocialLoginButtonView(type: .google)
    private var appleLoginButton = SocialLoginButtonView(type: .apple)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .Body
        label.font = .LoginTitle
        label.translatesAutoresizingMaskIntoConstraints = false

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        let attributedText = NSMutableAttributedString(string: "반가워요!\n오늘부터 출퇴근길\nBUSERVE 와 함께해요!")
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))

        let rangeBUSERVE = (attributedText.string as NSString).range(of: "BUSERVE")
        let attributesBUSERVE: [NSAttributedString.Key: UIColor] = [
            .foregroundColor: .MainColor
        ]

        attributedText.addAttributes(attributesBUSERVE, range: rangeBUSERVE)
        label.attributedText = attributedText
        label.sizeToFit()
        
        return label
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .Background
        self.navigationController?.navigationBar.isHidden = true
        
        [titleLabel, kakaoLoginButton, googleLoginButton, appleLoginButton].forEach { view.addSubview($0) }
        
        kakaoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false

        configureConstraints()
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - layouts
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -78),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 238),
            
            
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 46),
            kakaoLoginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            kakaoLoginButton.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 172),


            googleLoginButton.heightAnchor.constraint(equalToConstant: 46),
            googleLoginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            googleLoginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            googleLoginButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: kakaoLoginButton.safeAreaLayoutGuide.bottomAnchor, constant: 12),


            appleLoginButton.heightAnchor.constraint(equalToConstant: 46),
            appleLoginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            appleLoginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            appleLoginButton.topAnchor.constraint(equalTo: googleLoginButton.safeAreaLayoutGuide.bottomAnchor, constant: 12),
            appleLoginButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
        ])
    }
    
    // MARK: - methods
    
    @objc func kakaoButtonTapped(_ sender: UIButton) {
        print("kakoButton Tapped")
        
        let kakaoAdapter = KakaoAuthenticateAdapter()
        
        Task {
            do {
                let result = try await SocialLoginManager.shared.login(with: kakaoAdapter)
                switch result {
                case .success:
                    print("Successfully logged in with kakao.")
                    UserDefaults.standard.set(true, forKey: "socialLoginState")
                    
                    if UserDefaults.standard.bool(forKey: "KakaoLoginState") {
                        // AppleLoginState가 true로 설정되어 있으면 이 부분이 실행됩니다.
                        SocialLoginManager.shared.checkLoginState()
                    } else {
                        // AppleLoginState가 false거나 설정되어 있지 않으면 이 부분이 실행됩니다.
                        DispatchQueue.main.async {
                            print("completedVC 로 이동")
                            
                            UserDefaults.standard.set(true, forKey: "KakaoLoginState")
                            let completedVC = CompletedSignUpViewController()
                            self.navigationController?.pushViewController(completedVC, animated: true)
                        }
                    }
                case .failure(let error):
                    print("Failed to login with kakao. Error: \(error)")
                }
            } catch {
                print("Login error: \(error)")
            }
        }
    }
    
    @objc func googleButtonTapped(_ sender: UIButton) {
        print("googleButton Tapped")
    }
    
    @objc func appleButtonTapped(_ sender: UIButton) {
        print("appleButton Tapped")
        
        let appleAdapter = AppleAuthenticateAdapter()
        
        Task {
            do {
                let result = try await SocialLoginManager.shared.login(with: appleAdapter)
                switch result {
                case .success:
                    print("Successfully logged in with Apple.")
                    UserDefaults.standard.set(true, forKey: "socialLoginState")
                    
                    if UserDefaults.standard.bool(forKey: "AppleLoginState") {
                        // KakoLoginState가 true로 설정되어 있으면 이 부분이 실행됩니다.
                        SocialLoginManager.shared.checkLoginState()
                    } else {
                        // KakoLoginState가 false거나 설정되어 있지 않으면 이 부분이 실행됩니다.
                        DispatchQueue.main.async {
                            print("completedVC 로 이동")
                            
                            UserDefaults.standard.set(true, forKey: "AppleLoginState")
                            let completedVC = CompletedSignUpViewController()
                            self.navigationController?.pushViewController(completedVC, animated: true)
                        }
                    }
                    
                    
                case .failure(let error):
                    print("Failed to login with Apple. Error: \(error)")
                }
            } catch {
                print("Login error: \(error)")
            }
        }
    }
}


extension LoginViewController {
    /// ( 라이트, 다크 ) 모드가 변경되었을 때 TableView 의 UI 색상을 업데이트
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            googleLoginButton.configuration?.background.strokeWidth = (traitCollection.userInterfaceStyle == .dark) ? 0 : 1
            
            appleLoginButton.configuration?.background.strokeWidth = (traitCollection.userInterfaceStyle == .dark) ? 1 : 0
        }
    }
}
