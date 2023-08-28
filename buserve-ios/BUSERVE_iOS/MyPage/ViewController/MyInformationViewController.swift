//
//  MyInformationVIewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/23.
//

import UIKit

class MyInformationViewController: UIViewController {
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var accountDeletionButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var signUpMethodLabel: UILabel!
    @IBOutlet weak var signUpMethodImageView: UIImageView!
    
    private var userInfoManager = UserInfoManager(loadUseCase: LoadUserInfoUseCase())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .Background
        self.configureNavigationBar()
        self.configureView()
        
        Task {
            guard let userInfo = try await userInfoManager.loadUserInfo() else {
                return
            }
            await updateUI(with: userInfo)
        }
    }
    
    func updateUI(with user: UserInfo) async {
        await MainActor.run {
            self.nameLabel.text = user.name
            self.mailLabel.text = user.email
            self.signUpMethodLabel.text = user.socialLoginType
            
            switch user.socialLoginType {
            case "Apple":
                self.signUpMethodImageView.image =  (traitCollection.userInterfaceStyle == .dark) ? UIImage(named: "DarkModeAppleLogoIcon") : UIImage(named: "LightModeAppleLogoIcon")
                
            case "Google":
                self.signUpMethodImageView.image =  UIImage(named: "GoogleLogoIcon")
            case "Kakao":
                self.signUpMethodImageView.image =  UIImage(named: "KakaoLogoIcon")
            default:
                break
            }
            
            self.signUpMethodImageView.contentMode = .scaleAspectFit
//            self.signUpMethodImageView.clipsToBounds = true
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "내 정보 관리"
        self.navigationController?.setCustomBackButton(sfSymbol: "chevron.left", imageColor: .Body, weight: .bold)
    }
    
    private func configureView() {
        navigationController?.navigationBar.tintColor = UIColor.Body
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.logOutButton.layer.cornerRadius = 16.0
        self.accountDeletionButton.layer.cornerRadius = 16.0
        self.accountDeletionButton.layer.borderColor = UIColor.Quaternary?.cgColor
        self.accountDeletionButton.layer.borderWidth = 1.0
    }
    
//    @objc func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func tapLogOutButton(_ sender: UIButton) {
        guard let logOutViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogOutViewController") as? LogOutViewController else { return }
        self.navigationController?.pushViewController(logOutViewController, animated: true)
    }
    
    @IBAction func tapWithdrawButton(_ sender: Any) {
        guard let withdrawViewController = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawViewController") as? WithdrawViewController else { return }
        self.navigationController?.pushViewController(withdrawViewController, animated: true)
    }
    
    /// ( 라이트, 다크 ) 모드가 변경되었을 때 TableView 의 UI 색상을 업데이트
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.signUpMethodImageView.image =  (traitCollection.userInterfaceStyle == .dark) ? UIImage(named: "DarkModeAppleLogoIcon") : UIImage(named: "LightModeAppleLogoIcon")
        }
    }
}
