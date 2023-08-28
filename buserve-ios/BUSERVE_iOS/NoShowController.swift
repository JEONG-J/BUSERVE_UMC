//
//  Noshow.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/24.
//

import UIKit

class NoShowController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var CheckLabel: UILabel!
    @IBOutlet var ClickBtn: [UIButton]!
    
    @IBOutlet weak var InforView: UIView!
    @IBOutlet weak var InforLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.setCustomBackButton(sfSymbol: "chevron.left", imageColor: .Body, weight: .bold)

        
        TitleLabel.font = UIFont(name: "Pretendard-Bold", size: 24)
        TitleLabel.textColor = .Body // UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
        
        
//        InforView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00).withAlphaComponent(0.75)
        InforView.layer.cornerRadius = 16
        
        let text =
        [
        "BUSERVE는 광역버스 좌석을 예약하는 앱입니다. 즉, 시간과 약속이 가장 중요합니다. 타인에게 피해가 가지 않도록 예약을 잘 지켜주세요.",
        "예약 노쇼 2회 시, 1주일간 예약을 할 수 없습니다.",
        "예약 노쇼 누적 5회 이상 시, 예약 노쇼를 한번 할 때마다 패널티 금액이 부여됩니다.",
        "패널티 금액은 노쇼한 좌석 예약 버스 교통비의 20%입니다."
        ]
        
        let fullString = NSMutableAttributedString()
        for(index, line) in text.enumerated(){
            let paragraphStyle = NSMutableParagraphStyle()
            /* SetParagaphStyle */
            paragraphStyle.lineSpacing = 10.0
            paragraphStyle.firstLineHeadIndent = 10
            paragraphStyle.headIndent = 26
            paragraphStyle.tailIndent = -10
            paragraphStyle.lineBreakStrategy = .pushOut
            
            /* Set font of LineNumber and Line */
            if let font = UIFont(name: "Pretendard-Regular", size: 15), let partBold = UIFont(name: "Pretendard-Bold", size: 15){
                let pointer = NSMutableAttributedString(
                    string: "\(index+1). \(line)\n",
                    attributes: [.font: font])
                    pointer.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, pointer.length))
                    
                let boldWord = ["BUSERVE", "1주일간", "패널티 금액", "20%"]
                for i in boldWord{
                    let range = (pointer.string as NSString).range(of: i)
                    if range.location != NSNotFound{
                        pointer.addAttributes([.font: partBold], range: range)
                    }
                }
                    fullString.append(pointer)
            }
        }
        
        /* Set InforLabel */
        InforLabel.attributedText = fullString
        InforLabel.numberOfLines = 0
        
        CheckLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        
        for i in ClickBtn{
            i.layer.cornerRadius = i.layer.frame.size.width / 2
            i.tintColor = UIColor.white
            if i == ClickBtn.first{
                i.backgroundColor = .Tertiary_SecondaryColor // UIColor(red: 0.80, green: 0.83, blue: 0.85, alpha: 1.00)
                i.setImage(UIImage(named: "cancel.png"), for: .normal)
                
                i.addTarget(self, action: #selector(CancelButtonClicked), for: .touchUpInside)
            }else{
                i.backgroundColor = .MainColor // UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
                i.setImage(UIImage(named: "Check.png"), for: .normal)
                
                i.addTarget(self, action: #selector(CheckButtonClicked), for: .touchUpInside)
            }
        }
        
        
    }
    @IBAction func changeView(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CurrentLoactionAuth") as? CurrentLoactionAuth else{
            return
        }
        
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc func CancelButtonClicked(_ sender: UIButton) {
        print("취소하기 버튼 버튼 Clicked")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func CheckButtonClicked(_ sender: UIButton) {
        print("예약하기 버튼 Clicked")
        
        guard let busReserveViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusReserveViewController") as? BusReserveViewController else { return }
        self.navigationController?.pushViewController(busReserveViewController, animated: true)
    }
}
