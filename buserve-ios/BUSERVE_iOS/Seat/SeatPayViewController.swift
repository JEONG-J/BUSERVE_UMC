//
//  SeatPayViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/22.
//

import UIKit

class SeatPayViewController: UIViewController {
    
    /* Label IBOutlet */
    
    @IBOutlet var TitleLabel: [UILabel]! //Title Label array
    @IBOutlet var DetailInformation: [UILabel]! //Detail Information Text
    @IBOutlet var DetailUnit: [UILabel]! //Detail Information Unit Text
    @IBOutlet var FirstMoneyInfor: [UILabel]! //top Money Information Text
    @IBOutlet var SecondMoneyInfor: [UILabel]!   //bottom Money Information Text
    @IBOutlet weak var BottomLabel: UILabel!
    /* View IBOutlet */
    @IBOutlet weak var DetailView: UIView!
    @IBOutlet weak var MoneyView: UIView!
    /* Button */
    @IBOutlet weak var busNumberBtn: UIButton!
    @IBOutlet weak var BusStopBtn: UIButton!
    @IBOutlet weak var PayBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView()
        setCollection()
        SetMoneyTitle()
        SetMoneyView()
        SetPayBtn()
        SetBusNumber()
        SetBusStop()
    }
    
    /* ----------------------------- */
    
    @IBAction func payClick(_ sender: Any) {
        self.performSegue(withIdentifier: "seatReservationComplete", sender: self)
    }
    
    func detailView(){
        //Detail View
        DetailView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00).withAlphaComponent(0.75)
        DetailView.layer.cornerRadius = 16
        
        //BottomLabel
        BottomLabel.textColor = UIColor(red: 0.53, green: 0.56, blue: 0.59, alpha: 1.00)
        BottomLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    func setCollection(){
        //Title Label
        for i in TitleLabel{
            i.textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
            i.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        }
        
        //Detail Information
        for i in DetailInformation{
            i.font = UIFont(name: "Pretendard-SemiBold", size: 18)
            i.textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
        }
        
        for i in DetailUnit{
            i.font = UIFont(name: "Pretendard-Regular", size: 18)
            i.textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
        }
    }
    
    func SetMoneyTitle(){
        //Money Infor
        for i in FirstMoneyInfor{
            i.textColor = UIColor(red: 0.53, green: 0.56, blue: 0.59, alpha: 1.00)
            i.font = UIFont(name: "Pretendard-Regular", size: 16)
        }
        
        for i in SecondMoneyInfor{
            i.textColor = UIColor(red: 0.20, green: 0.23, blue: 0.25, alpha: 1.00)
            i.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        }
    }
    
    func SetMoneyView(){
        //Money View
        MoneyView.layer.borderColor = UIColor(red: 0.91, green: 0.93, blue: 0.94, alpha: 1.00).cgColor
        MoneyView.layer.borderWidth = 1
        MoneyView.layer.cornerRadius = 16
    }
    
    func SetPayBtn(){
        //Bottom Btn
        PayBtn.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        PayBtn.setTitleColor(.white, for: .normal)
        PayBtn.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        PayBtn.layer.cornerRadius = 16
    }
    
    func SetBusNumber(){
        busNumberBtn.setImage(UIImage(named: "white_bus.png"), for: .normal)
        busNumberBtn.tintColor = UIColor.white
        busNumberBtn.setTitleColor(UIColor.white, for: .normal)
        busNumberBtn.setTitle("9802", for: .normal)
        busNumberBtn.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        busNumberBtn.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        busNumberBtn.layer.cornerRadius = 8
    }
    
    func SetBusStop(){
        BusStopBtn.setImage(UIImage(named: "black_bus"), for: .normal)
        BusStopBtn.tintColor = UIColor.black
        BusStopBtn.setTitleColor(UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1), for: .normal)
        BusStopBtn.setTitle("공단사거리", for: .normal)
        BusStopBtn.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        BusStopBtn.layer.cornerRadius = 8
        BusStopBtn.layer.borderWidth = 1
        BusStopBtn.layer.borderColor = UIColor(red: 0.804, green: 0.827, blue: 0.851, alpha: 1).cgColor
    }
}
