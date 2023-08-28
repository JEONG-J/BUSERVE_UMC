//
//  ChargeCompleteViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/08/04.
//

import UIKit

class ChargeCompleteViewController: UIViewController {

    @IBOutlet weak var completeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.navigationController?.navigationBar.isHidden = true
    }
    private func configureView() {
        self.completeButton.layer.cornerRadius = 16.0
    }
    
    @IBAction func tapCompleteButton(_ sender: UIButton) {
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is BusMoneyViewController {  // YourInitialViewController는 원하는 뷰 컨트롤러 클래스의 이름으로 변경해야 합니다.
                    viewController.navigationController?.navigationBar.isHidden = false
                    navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }
    }
}
