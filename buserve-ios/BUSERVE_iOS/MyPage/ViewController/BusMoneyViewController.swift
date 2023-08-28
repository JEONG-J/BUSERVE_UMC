//
//  BusMoneyViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/23.
//

import UIKit

class BusMoneyViewController: UIViewController {

    @IBOutlet weak var myBusMoneyView: UIView!
    @IBOutlet weak var myBusMoneyLabel: UILabel!
    @IBOutlet weak var chargeBusMoneyButton: UIButton!
    @IBOutlet weak var changePaymentMethodButton: UIButton!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    let busMoneyDataManager = BusMoneyDataManager()
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            do {
                let busMoneyData = try await busMoneyDataManager.fetchBusMoney()
                
                let chargingMethodsData = try await busMoneyDataManager.fetchBusChargingMethods()
                
                await MainActor.run {
                    self.myBusMoneyLabel.text = formatToWon(busMoneyData.result.amount)
                    self.paymentMethodLabel.text = chargingMethodsData.result.name
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background
        self.configureNavigationBar()
        self.configureView()
    }
    private func configureNavigationBar() {
        self.navigationItem.title = "버정머니 관리하기"
        self.navigationController?.setCustomBackButton(sfSymbol: "chevron.left", imageColor: .Body, weight: .bold)
    }
    
    private func configureView() {
        navigationController?.navigationBar.tintColor = UIColor.Body
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        myBusMoneyView.layer.cornerRadius = 16.0
        myBusMoneyView.layer.borderColor = UIColor.MainColor.cgColor
        myBusMoneyView.layer.borderWidth = 2.0
        chargeBusMoneyButton.layer.cornerRadius = 16.0
        changePaymentMethodButton.layer.cornerRadius = 16.0
        
        chargeBusMoneyButton.titleLabel?.font = .bodyBold
        changePaymentMethodButton.titleLabel?.font = .bodyBold
        
        myBusMoneyView.clipsToBounds = true
        chargeBusMoneyButton.clipsToBounds = true
        changePaymentMethodButton.clipsToBounds = true
    }
    
    @IBAction func tapChargeBusMoneyButton(_ sender: Any) {
        guard let busMoneyChargeViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusMoneyChargeViewController") as? BusMoneyChargeViewController else { return }
        
        var currentMoney = 0
        
        if let text = myBusMoneyLabel.text {
            let cleanedString = text.replacingOccurrences(of: "원", with: "")
                                       .replacingOccurrences(of: ",", with: "")
            if let intValue = Int(cleanedString) {
                // intValue 는 이제 Int 타입입니다.
                currentMoney = intValue
            } else {
                print("변환할 수 없는 값입니다.")
            }
        } else {
            print("라벨이 비어있습니다.")
        }
        
        busMoneyChargeViewController.paymentMethod = paymentMethodLabel.text
        busMoneyChargeViewController.currentMoney = currentMoney
        
        self.navigationController?.pushViewController(busMoneyChargeViewController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func formatToWon(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedAmount = formatter.string(from: NSNumber(value: value)) {
            return "\(formattedAmount)원"
        } else {
            return "\(value)원"
        }
    }
    
}
