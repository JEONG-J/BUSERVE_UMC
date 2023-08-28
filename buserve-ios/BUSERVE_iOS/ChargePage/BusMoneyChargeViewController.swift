//
//  busMoneyChargeViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/08/04.
//

import UIKit

class BusMoneyChargeViewController: UIViewController {

    @IBOutlet weak var busMoneyChargeView: UIView!
    @IBOutlet weak var busMoneyChargeTextField: UITextField!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var chargeMethodLabel: UILabel!
    @IBOutlet weak var currentMoneyLabel: UILabel!
    @IBOutlet weak var afterChargeMoneyLabel: UILabel!
    @IBOutlet weak var busMoneyChargeButton: UIButton!
    
    let busMoneyDataManager = BusMoneyDataManager()
    
    var currentMoney: Int = 0
    var busChargeMoney: Int = 0 {
        didSet {
            updateUI()
        }
    }
    var paymentMethod: String?
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background
        self.configureNavigationBar()
        self.configureView()
        
        chargeMethodLabel.text = paymentMethod
        currentMoneyLabel.text = "\(formatToWon(currentMoney))"
        afterChargeMoneyLabel.text =  "\(formatToWon(currentMoney))"
        
        busMoneyChargeTextField.delegate = self
    }
    
    private func configureNavigationBar() {
        self.title = ""
        self.navigationItem.title = "버정머니 충전하기"
        self.navigationController?.setCustomBackButton(sfSymbol: "chevron.left", imageColor: .Body, weight: .bold)
    }
    
    private func configureView() {
        self.busMoneyChargeView.layer.cornerRadius = 16.0
        self.busMoneyChargeView.layer.borderColor = UIColor.MainColor.cgColor
        self.busMoneyChargeView.layer.borderWidth = 2.0
        self.busMoneyChargeTextField.borderStyle = .none
        self.busMoneyChargeButton.layer.cornerRadius = 16.0
        let placeholderText = "금액을 입력해주세요."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.Tertiary
        ]

        // Placeholder를 NSAttributedString으로 변환하여 설정합니다.
        busMoneyChargeTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        self.eraseButton.isHidden = true
    }
    
    func updateButtonVisibility() {
        if let text = busMoneyChargeTextField.text, !text.isEmpty {
            eraseButton.isHidden = false
        } else {
            eraseButton.isHidden = true
        }
    }
    
    @IBAction func tapEraseButton(_ sender: UIButton) {
        busMoneyChargeTextField.text = ""
        busChargeMoney = 0
    }
    
    @IBAction func tapBusMoneyChargeButton(_ sender: UIButton) {
            
        Task {
            do {
                let result = try await busMoneyDataManager.changeBusCharginMoney(chargeMoney: busChargeMoney)
                
                if result {
                    await MainActor.run {
                        guard let chargeCompleteViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChargeCompleteViewController") as? ChargeCompleteViewController else { return }
                        self.navigationController?.pushViewController(chargeCompleteViewController, animated: true)
                    }
                } else {
                    print("요청 처리 실패")
                }
            } catch {
                print("요청 처리 실패")
            }
        }
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
    
    func updateUI() {
        afterChargeMoneyLabel.text = "\(formatToWon(busChargeMoney + currentMoney))"
    }
}

extension BusMoneyChargeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var currentText = textField.text ?? ""
        
        if string.isEmpty {
            busChargeMoney = busChargeMoney / 10
            currentText = String(busChargeMoney)
            print("백스페이스 눌림")
        } else {
            if currentText.isEmpty {
                currentText = string
            } else {
                currentText.removeLast()
                if currentText.count < 6 {
                    currentText = String(busChargeMoney) + string
                }
            }
        }
        busChargeMoney = Int(currentText.replacingOccurrences(of: ",", with: "")) ?? 0
        textField.text = (numberFormatter.string(from: NSNumber(value: busChargeMoney)) ?? "") + "원"
        if busChargeMoney == 0 {
            textField.text = ""
        }
        print(busChargeMoney)
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateButtonVisibility()
    }
}
