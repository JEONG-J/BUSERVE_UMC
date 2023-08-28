//
//  BusSelectViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/07.
//

import UIKit

class BusSeatSelectViewController: UIViewController {
    
    var listLeft = ["1", "2", "5", "6",  "9", "10",
                    "13", "14", "17", "18", "21",
                    "22", "25", "26", "29","30"]
    var listRight = ["3", "4", "7", "8","11", "12",
                     "15", "16", "19", "20","23", "24",
                     "27","28"]
    
    
    @IBOutlet weak var seatCollectionView: UICollectionView!
    @IBOutlet weak var seatCollectionViewRight: UICollectionView!
    
    var selectedIndexPathLeft: IndexPath? = nil
    var selectedIndexPathRight: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seatCollectionView.dataSource = self
        self.seatCollectionView.delegate = self
        self.seatCollectionViewRight.dataSource = self
        self.seatCollectionViewRight.delegate = self
    }
    
    func configureDeselectedCell(_ cell: SeatCollectionViewCell) {
        cell.backgroundColor = UIColor.white
        cell.seatNum.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        cell.seatNum.font = UIFont(name: "Pretendard-Regular", size: 16)
        cell.setCell()
    }
}

extension BusSeatSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.seatCollectionView{
            return listLeft.count
        }else{
            return listRight.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if collectionView == self.seatCollectionView {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellLeft", for: indexPath) as! SeatCollectionViewCell
               cell.seatNum.text = listLeft[indexPath.row]
               return cell
           } else if collectionView == self.seatCollectionViewRight {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellRight", for: indexPath) as! SeatCollectionViewCell
               cell.seatNum.text = listRight[indexPath.row]
               return cell
           } else {
               fatalError("Unknown collection view")
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SeatCollectionViewCell
        cell.backgroundColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1)
        cell.seatNum.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        cell.seatNum.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderWidth = 0
        
        if collectionView == self.seatCollectionView{
            if let previousIndexPathRight = selectedIndexPathRight{
                seatCollectionViewRight.deselectItem(at: previousIndexPathRight, animated: true)
                if let previousCell = seatCollectionViewRight.cellForItem(at: previousIndexPathRight) as? SeatCollectionViewCell {
                    configureDeselectedCell(previousCell)
                }
                selectedIndexPathRight = nil
            }
            selectedIndexPathLeft = indexPath
        } else if collectionView == self.seatCollectionViewRight{
            if let previousIndexPathLeft = selectedIndexPathLeft{
                seatCollectionView.deselectItem(at: previousIndexPathLeft, animated: true)
                if let previousCell = seatCollectionView.cellForItem(at: previousIndexPathLeft) as?  SeatCollectionViewCell{
                    configureDeselectedCell(previousCell)
                }
                selectedIndexPathLeft = nil
            }
            selectedIndexPathRight = indexPath
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SeatCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.seatNum.textColor = UIColor(red: 0.204, green: 0.227, blue: 0.251, alpha: 1)
        cell.seatNum.font = UIFont(name: "Pretendard-Regular", size: 16)
        cell.setCell()
    }
    
}

extension BusSeatSelectViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 36
        let size = CGSize(width: width, height: width)
        return size
    }
}
