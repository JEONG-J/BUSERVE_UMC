//
//  WithdrawViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/23.
//

import UIKit

class WithdrawViewController: UIViewController {
    
    @IBOutlet weak var withdrawView: UIView!
    @IBOutlet weak var withdrawButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureView()
    }
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.Body
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    private func configureView() {
        self.withdrawView.layer.cornerRadius = 16.0
        self.withdrawButton.layer.cornerRadius = 16.0
        self.withdrawButton.layer.borderColor = UIColor.Quaternary?.cgColor
        self.withdrawButton.layer.borderWidth = 1.0
    }
}
