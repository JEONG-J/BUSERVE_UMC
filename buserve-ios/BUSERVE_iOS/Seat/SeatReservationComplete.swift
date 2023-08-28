//
//  SeatReservationComplete.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/23.
//

import UIKit

class SeatReservationComplete: UIViewController {

    @IBOutlet weak var DetailView: UIView! //DetailUI View
    @IBOutlet weak var BusNumberImg: UIImageView! //DetailBus Img
    @IBOutlet weak var BusNameImg: UIImageView! //DetailBusStop Img
    @IBOutlet var BusInforText: [UILabel]!
    @IBOutlet weak var BusNumberView: UIView!
    @IBOutlet weak var BusRoadView: UIView!
    @IBOutlet weak var CheckBtn: UIButton! //Reservation Check
    @IBOutlet var SetTextStyle: [UILabel]!
    @IBOutlet var SetUnitText: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailView.layer.cornerRadius = 16
        DetailView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00).withAlphaComponent(0.75)
        
        BusNumberImg.image = UIImage(named: "white_bus.png")
        BusNameImg.image = UIImage(named: "black_bus.png")
        
        for i in BusInforText{
            i.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        }
        
        BusInforText[0].textColor = UIColor.white
        BusInforText[1].textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
        
        BusNumberView.layer.cornerRadius = 8
        BusNumberView.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        
        BusRoadView.layer.cornerRadius = 8
        BusRoadView.backgroundColor = UIColor.white
        BusRoadView.layer.borderColor = UIColor(red: 0.80, green: 0.83, blue: 0.85, alpha: 1.00).cgColor
        BusRoadView.layer.borderWidth = 1
        
        CheckBtn.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        CheckBtn.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        CheckBtn.layer.cornerRadius = 16
        CheckBtn.setTitleColor(.white, for: .normal)
        
        
        for i in SetUnitText{
            i.textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
            i.font = UIFont(name: "Pretendard-Regular", size: 16)
        }
        
        for i in SetTextStyle{
            i.textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
            i.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        }
    }
    
    
}
