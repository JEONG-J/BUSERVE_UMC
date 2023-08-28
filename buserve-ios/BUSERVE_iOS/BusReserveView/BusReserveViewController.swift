//
//  BusStopViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/31.
//

import UIKit

class BusReserveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var BusStopTable: UITableView!
    
    @IBOutlet weak var BusNumber: UIButton!
    @IBOutlet weak var BusName: UIButton!
    
    var passedBusName: String?
    var passedBusNumber: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(passedBusNumber)
        
        if let name = passedBusName {
            BusName.setTitle(name, for: .normal)
        }
        if let number = passedBusNumber {
            BusNumber.setTitle(number, for: .normal)
        }
        
        BusNumber.setImage(UIImage(named: "white_bus.png"), for: .normal)
        BusNumber.tintColor = UIColor.white
        BusNumber.setTitleColor(UIColor.white, for: .normal)
        BusNumber.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        BusNumber.backgroundColor = UIColor(red: 0.07, green: 0.41, blue: 0.98, alpha: 1.00)
        BusNumber.layer.cornerRadius = 8
    }

    func numberOfSections(in tableView: UITableView) -> Int {
           return 3
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = BusStopTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BusReserveTableViewCell
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 86
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 5.0
       }
    
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    
    @IBAction func backView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   }
