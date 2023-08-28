//
//  ReservationDetailsViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/21.
//

import UIKit

class ReservationDetailsViewController: UIViewController {
    
    @IBOutlet weak var busNumberView: UIView!
    @IBOutlet weak var busNumberLabel: UILabel!
    @IBOutlet weak var busStationView: UIView!
    @IBOutlet weak var busStationLabel: UILabel!
    @IBOutlet weak var reservationDateLabel: UILabel!
    @IBOutlet weak var recentReservationView: UIView!
    
    
    @IBOutlet weak var reservationInformationLabel: UILabel!
    @IBOutlet weak var reservationDetailCollectionView: UICollectionView!
    
    
    private var reservationDetailsList: [ReservationDetail] = [
        ReservationDetail(reserveDate: "2023-07-21", busNumber: 123, busStation: "Bus Stop A", arrivalTime: "12:30 PM", seatNumber: 5),
        ReservationDetail(reserveDate: "2023-07-22", busNumber: 456, busStation: "Bus Stop B", arrivalTime: "2:45 PM", seatNumber: 10),
        ReservationDetail(reserveDate: "2023-07-23", busNumber: 789, busStation: "Bus Stop C", arrivalTime: "6:15 PM", seatNumber: 3)
    ]
    var selectedCellIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureView()
        self.reservationDetailCollectionView.delegate = self
        self.reservationDetailCollectionView.dataSource = self
    }
    private func configureNavigationBar() {
        self.title = ""
        self.navigationItem.title = "예약 내역"
        self.navigationController?.setCustomBackButton(sfSymbol: "chevron.left", imageColor: .Body, weight: .bold)
    }
    private func configureView() {
        self.busNumberView.layer.cornerRadius = 8.0
        self.busStationView.layer.cornerRadius = 8.0
        self.busStationView.layer.borderWidth = 1.0
        self.busStationView.layer.borderColor = UIColor.Tertiary.cgColor
        self.recentReservationView.layer.cornerRadius = 16.0
    }
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReservationDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservationDetailCell", for: indexPath) as? ReservationDetailCell else { return UICollectionViewCell() }
        let reservationDetail = self.reservationDetailsList[indexPath.row]
        cell.reservationDetailDateLabel.text = reservationDetail.reserveDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reservationDetailsList.count
    }
}

extension ReservationDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width, height: 72)
    }
}

extension ReservationDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
