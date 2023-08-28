//
//  BusStopTableViewCell.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/31.
//

import UIKit

class BusReserveTableViewCell: UITableViewCell {
    
    var clickedBtn : Bool = false
    var reserveBtn : UIButton!
    var arriveTimeText : UILabel!
    var scheduleText : UILabel!
    var remainingSeat : UILabel!
    var slashText : UILabel!
    var allSeat : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
        setTimeText()
        setSchedule()
        setBtn()
        setRemainig()
        setSlashText()
        setAllSeat()
    }
    
    func setCell(){
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.804, green: 0.827, blue: 0.851, alpha: 1).cgColor
    }
    
    func setTimeText() {
        arriveTimeText = UILabel()
        arriveTimeText.text = "06:00"
        arriveTimeText.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        arriveTimeText.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        
        arriveTimeText.translatesAutoresizingMaskIntoConstraints = false
        arriveTimeText.widthAnchor.constraint(greaterThanOrEqualToConstant: 46).isActive = true
        
        self.addSubview(arriveTimeText)
        
        arriveTimeText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        arriveTimeText.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
    }
    
    func setSchedule(){
        scheduleText = UILabel()
        scheduleText.text = "도착 예정"
        scheduleText.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        scheduleText.font = UIFont(name: "Pretendard-Regular", size: 16)
        
        scheduleText.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scheduleText)
        
        scheduleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        scheduleText.leadingAnchor.constraint(equalTo: self.arriveTimeText.trailingAnchor, constant: 4).isActive = true
        
    }
    
    func setBtn(){
        reserveBtn = UIButton()
        reserveBtn.setTitleColor(UIColor.white, for: .normal)
        reserveBtn.setTitle("예약", for: .normal)
        reserveBtn.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        reserveBtn.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        reserveBtn.layer.cornerRadius = 8
        
        reserveBtn.widthAnchor.constraint(greaterThanOrEqualToConstant: 76).isActive = true
        reserveBtn.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        reserveBtn.isUserInteractionEnabled = true
        reserveBtn.addTarget(self, action: #selector(clickBtn), for: .touchDown)
        reserveBtn.addTarget(self, action: #selector(cancelBtn), for: [.touchUpInside, .touchUpOutside])
        
        reserveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(reserveBtn)
       
        reserveBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        reserveBtn.leadingAnchor.constraint(greaterThanOrEqualTo: self.scheduleText.trailingAnchor, constant: 109).isActive = true
        reserveBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func clickBtn(sender: UIButton!){
        UIView.animate(withDuration: 0.1){
            sender.backgroundColor = UIColor(red: 0.22, green: 0.69, blue: 0.96, alpha: 1.00)
        }
    }
    @objc func cancelBtn(sender: UIButton!){
        UIView.animate(withDuration: 0.1){
            sender.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        }
        
    }
    
    func setRemainig() {
        remainingSeat = UILabel()
        let fullText = "잔여 12석"
        remainingSeat.textColor = UIColor(red: 0.525, green: 0.557, blue: 0.588, alpha: 1)
        remainingSeat.font = UIFont(name: "Pretendard-Regular", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        remainingSeat.textAlignment = .center
        
        let attrString = NSMutableAttributedString(string: fullText)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        let regex = try! NSRegularExpression(pattern: "\\d+석")
        let matches = regex.matches(in: fullText, options: [], range: NSMakeRange(0, fullText.utf16.count))
        
        for match in matches {
            attrString.addAttribute(.font, value: UIFont(name: "Pretendard-SemiBold", size: 14)!, range: match.range)
            attrString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: match.range)
        }
        remainingSeat.attributedText = attrString

        remainingSeat.widthAnchor.constraint(greaterThanOrEqualToConstant: 55).isActive = true
        remainingSeat.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(remainingSeat)
        
        remainingSeat.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        remainingSeat.topAnchor.constraint(equalTo: self.arriveTimeText.bottomAnchor, constant: 4).isActive = true
    }
    
    func setSlashText(){
        slashText = UILabel()
        slashText.text = "/"
        slashText.textColor = UIColor(red: 0.525, green: 0.557, blue: 0.588, alpha: 1)
        slashText.font = UIFont(name: "Pretendard-Regular", size: 14)
        
        slashText.widthAnchor.constraint(greaterThanOrEqualToConstant: 5).isActive = true
        slashText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slashText)
        
        slashText.leadingAnchor.constraint(equalTo: self.remainingSeat.trailingAnchor, constant: 4).isActive = true
        slashText.topAnchor.constraint(equalTo: self.scheduleText.bottomAnchor, constant: 7).isActive = true
    }
    
    func setAllSeat(){
        allSeat = UILabel()
        allSeat.text = "전체 20석"
        allSeat.textColor = UIColor(red: 0.525, green: 0.557, blue: 0.588, alpha: 1)
        allSeat.font = UIFont(name: "Pretendard-Regular", size: 14)
        
        allSeat.widthAnchor.constraint(greaterThanOrEqualToConstant: 57).isActive = true
        allSeat.translatesAutoresizingMaskIntoConstraints = false
        addSubview(allSeat)
        
        allSeat.leadingAnchor.constraint(equalTo: self.slashText.trailingAnchor, constant: 4).isActive = true
        allSeat.topAnchor.constraint(equalTo: self.scheduleText.bottomAnchor, constant: 8).isActive = true
        allSeat.trailingAnchor.constraint(lessThanOrEqualTo: self.reserveBtn.leadingAnchor, constant: 94).isActive = true
    }


    
}
