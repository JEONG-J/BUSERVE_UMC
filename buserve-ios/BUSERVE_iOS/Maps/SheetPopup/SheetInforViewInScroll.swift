//
//  SheetInforViewInScroll.swift
//  Created by 정의찬 on 2023/08/20.
//

import UIKit

class SheetInforViewInScroll: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        makeConstrain()
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)
    }
    
    private lazy var busNumber : UIButton = {
        let bus = UIButton()
        bus.setTitle("9802", for: .normal)
        bus.setTitleColor(UIColor.white, for: .normal)
        bus.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        bus.setImage(UIImage(named: "white_bus.png"), for: .normal)
        bus.backgroundColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1)
        bus.layer.cornerRadius = 8
        bus.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        bus.translatesAutoresizingMaskIntoConstraints = false
        return bus
    }()
    
    private lazy var busStop : UIButton = {
        let bus = UIButton()
        bus.setTitle("공단사거리", for: .normal)
        bus.setTitleColor(UIColor.black, for: .normal)
        bus.setImage(UIImage(named: "black_bus.png"), for: .normal)
        bus.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        bus.backgroundColor = UIColor.white
        bus.layer.cornerRadius = 8
        bus.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        bus.translatesAutoresizingMaskIntoConstraints = false
        return bus
    }()
    
    private lazy var reserveDay : UILabel = {
        let txt = UILabel()
        txt.text = "2023.07.14 (금)"
        txt.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var time : UILabel = {
        let txt = UILabel()
        txt.text = "06:00"
        txt.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var etc : UILabel = {
        let txt = UILabel()
        txt.text = "도착 예정 /"
        txt.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var number : UILabel = {
        let txt = UILabel()
        txt.text = "10번"
        txt.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var etc2 : UILabel = {
        let txt = UILabel()
        txt.text = "좌석"
        txt.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private func makeConstrain(){
        busStop.widthAnchor.constraint(greaterThanOrEqualToConstant: 118).isActive = true
        busStop.heightAnchor.constraint(equalToConstant: 34).isActive = true
        busNumber.heightAnchor.constraint(equalToConstant: 34).isActive = true
        busNumber.widthAnchor.constraint(greaterThanOrEqualToConstant: 87).isActive = true
        
        time.widthAnchor.constraint(greaterThanOrEqualToConstant: 46).isActive = true
        number.widthAnchor.constraint(greaterThanOrEqualToConstant: 32).isActive = true
        etc2.widthAnchor.constraint(greaterThanOrEqualToConstant: 28).isActive = true
        
        [busNumber, busStop, reserveDay,etc, time, number, etc2].forEach {self.addSubview($0)}
        
        NSLayoutConstraint.activate([
            busNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            busNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            
            busStop.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            busStop.leadingAnchor.constraint(equalTo: busNumber.trailingAnchor, constant: 16),
            
            reserveDay.topAnchor.constraint(equalTo: busStop.bottomAnchor, constant: 16),
            reserveDay.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
            
            etc.topAnchor.constraint(equalTo: reserveDay.bottomAnchor, constant: 8),
            etc.leadingAnchor.constraint(equalTo: time.trailingAnchor, constant: 6),
            
            time.topAnchor.constraint(equalTo: reserveDay.bottomAnchor, constant: 8),
            time.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75),
            
            number.leadingAnchor.constraint(equalTo: etc.trailingAnchor, constant: 4),
            number.topAnchor.constraint(equalTo: reserveDay.bottomAnchor, constant: 8),
            
            etc2.leadingAnchor.constraint(equalTo: number.trailingAnchor, constant: 6),
            etc2.topAnchor.constraint(equalTo: reserveDay.bottomAnchor, constant: 8)
        ])
    }
}
