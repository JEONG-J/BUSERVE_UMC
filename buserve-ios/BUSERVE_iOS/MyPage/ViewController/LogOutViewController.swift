//
//  LogOutViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/23.
//

import UIKit

class LogOutViewController: UIViewController {
    
    @IBOutlet weak var logOutView: UIView!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background
        self.configureNavigationBar()
        self.configureView()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.Body
    }
    private func configureView() {
        self.logOutView.layer.cornerRadius = 16.0
        self.logOutButton.layer.cornerRadius = 16.0
    }
    
    @IBAction func tapLogOutButton(_ sender: Any) {
        SocialLoginManager.shared.logout()
    }
}
