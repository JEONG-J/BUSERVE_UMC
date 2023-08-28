//
//  BusStopViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/01.
//

import UIKit

class BusStopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var busNumber: PrintbusNumber!
    @IBOutlet weak var busStopNameText: BusStopTitle!
    var nextBtn: BusStopTableViewCell?
    
    var busStopNumber = ["89070", "89054", "89060", "42380", "42397"]
    var busStopName = ["공단사거리", "검단지식산업센터", "검단오류역", "단봉초등학교", "유승아파트"]

    @IBOutlet weak var BusStopTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
       }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busStopName.count * 2
    }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if indexPath.row % 2 == 0{
               let cell = BusStopTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BusStopTableViewCell
               let index = indexPath.row / 2
               cell.BusStopTitle.text = busStopName[index]
               cell.SubTitle.text = busStopNumber[index]
               cell.nextBtn.addTarget(self, action: #selector(nextView), for: .touchUpInside)
               return cell
           }else{
               let cell = UITableViewCell()
               cell.backgroundColor = .Background
               cell.selectionStyle = .none
               return cell
           }
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 84
        } else {
            return 20
        }
    }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 5.0
       }
    
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        busNumber.setTitle(busStopNumber[indexPath.row/2], for: .normal)
    }
    
    
    @IBAction func backView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func nextView(_ sender: UIButton) {
        guard let nextVc = self.storyboard?.instantiateViewController(identifier: "BusReserveViewController") as? BusReserveViewController else {
            return
        }
        
        
        if let cell = sender.superview?.superview as? BusStopTableViewCell {
            
            nextVc.passedBusName = cell.BusStopTitle.text
            nextVc.passedBusNumber = cell.SubTitle.text
        }
        
        nextVc.modalTransitionStyle = .coverVertical
        nextVc.modalPresentationStyle = .fullScreen
        present(nextVc, animated: true, completion: nil)
    }



    

}
