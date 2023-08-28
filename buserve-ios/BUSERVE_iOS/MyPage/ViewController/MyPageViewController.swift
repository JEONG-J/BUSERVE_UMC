//
//  MyPageViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/21.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var reservationDetailsView: UIView!
    @IBOutlet weak var busMoneyView: UIView!
    @IBOutlet weak var myInformationMangementView: UIView!
    @IBOutlet weak var buserveHelpView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background
        self.configureView()
        self.tapGestureRecognizer()
    }
    private func configureView() {
        self.reservationDetailsView.layer.cornerRadius = 16.0
        self.busMoneyView.layer.cornerRadius = 16.0
        self.myInformationMangementView.layer.cornerRadius = 16.0
        self.buserveHelpView.layer.cornerRadius = 16.0
        self.myInformationMangementView.layer.borderWidth = (traitCollection.userInterfaceStyle == .dark) ? 0 : 1
        self.myInformationMangementView.layer.borderColor = UIColor.Tertiary.cgColor
        self.buserveHelpView.layer.borderWidth = (traitCollection.userInterfaceStyle == .dark) ? 0 : 1
        self.buserveHelpView.layer.borderColor = UIColor.Tertiary.cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            
            self.myInformationMangementView.layer.borderWidth = (traitCollection.userInterfaceStyle == .dark) ? 0 : 1
            self.buserveHelpView.layer.borderWidth = (traitCollection.userInterfaceStyle == .dark) ? 0 : 1
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func tapGestureRecognizer() {
        let reservationTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapReservationView(_:)))
        reservationDetailsView.addGestureRecognizer(reservationTapGestureRecognizer)
        let busMoneyTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBusMoneyView(_:)))
        busMoneyView.addGestureRecognizer(busMoneyTapGestureRecognizer)
        let myInformationTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMyInformationView(_:)))
        myInformationMangementView.addGestureRecognizer(myInformationTapGestureRecognizer)
        let buserveHelpTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBuserveHelpView(_:)))
        buserveHelpView.addGestureRecognizer(buserveHelpTapGestureRecognizer)
    }
    
    @objc func didTapReservationView(_ sender: UITapGestureRecognizer) {
        guard let reservationDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReservationDetailsViewController") as? ReservationDetailsViewController else { return }
        self.navigationController?.pushViewController(reservationDetailsViewController, animated: true)
        UIView.animate(withDuration: 0.1, animations: {
            self.reservationDetailsView.alpha = 0.4
        }) { (finished) in
            // UIView를 다시 밝게 만듭니다.
            UIView.animate(withDuration: 0.1, animations: {
                self.reservationDetailsView.alpha = 1.0
            })
        }
    }

    @objc func didTapBusMoneyView(_ sender: UITapGestureRecognizer) {
        guard let busMoneyViewController = self.storyboard?.instantiateViewController(withIdentifier: "BusMoneyViewController") as? BusMoneyViewController else { return }
        self.navigationController?.pushViewController(busMoneyViewController, animated: true)
        UIView.animate(withDuration: 0.1, animations: {
            self.busMoneyView.alpha = 0.4
        }) { (finished) in
            // UIView를 다시 밝게 만듭니다.
            UIView.animate(withDuration: 0.1, animations: {
                self.busMoneyView.alpha = 1.0
            })
        }
    }

    @objc func didTapMyInformationView(_ sender: UITapGestureRecognizer) {
        guard let myInformationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyInformationViewController") as? MyInformationViewController else { return }
        self.navigationController?.pushViewController(myInformationViewController, animated: true)
        UIView.animate(withDuration: 0.1, animations: {
            self.myInformationMangementView.alpha = 0.4
        }) { (finished) in
            // UIView를 다시 밝게 만듭니다.
            UIView.animate(withDuration: 0.1, animations: {
                self.myInformationMangementView.alpha = 1
            })
        }
    }

    @objc func didTapBuserveHelpView(_ sender: UITapGestureRecognizer) {
        guard let buserveHelpViewController = self.storyboard?.instantiateViewController(withIdentifier: "BuserveHelpViewController") as? BuserveHelpViewController else { return }
        self.navigationController?.pushViewController(buserveHelpViewController, animated: true)
        UIView.animate(withDuration: 0.1, animations: {
            self.myInformationMangementView.alpha = 0.4
        }) { (finished) in
            // UIView를 다시 밝게 만듭니다.
            UIView.animate(withDuration: 0.1, animations: {
                self.myInformationMangementView.alpha = 1
            })
        }
    }
    
}
