//
//  SheetViewController.swift

//
//  Created by 정의찬 on 2023/08/20.
//

import UIKit
import NMapsMap

protocol SheetViewDelegate: AnyObject {
    func updateCoordinatesAndRefreshUI(lat: Double, lng: Double)  // 새로 추가된 메서드
}

class SheetViewController: UIViewController {
    
    private var sheetUIView : SheetView!

    weak var delegate: SheetViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private lazy var checkBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("길찾기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        btn.backgroundColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1)
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(TouchDown), for: .touchDown)
        btn.addTarget(self, action: #selector(TouchUp), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func setView(){
        sheetUIView = SheetView()
        
        self.view.addSubview(sheetUIView)
        self.view.addSubview(checkBtn)
        checkBtn.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        sheetUIView.translatesAutoresizingMaskIntoConstraints = false
        sheetUIView.heightAnchor.constraint(equalToConstant: 270).isActive = true
        
        NSLayoutConstraint.activate([
            sheetUIView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            sheetUIView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            sheetUIView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            checkBtn.topAnchor.constraint(equalTo: sheetUIView.bottomAnchor, constant: 20),
            checkBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            checkBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
    }
    
    @objc func TouchUp (_sender : Any){
        checkBtn.backgroundColor = UIColor(red: 0.071, green: 0.408, blue: 0.984, alpha: 1)
        let newLatitude: Double = 37.592724  // 예시 값
        let newLongitude: Double = 126.615294  // 예시 값
            delegate?.updateCoordinatesAndRefreshUI(lat: newLatitude, lng: newLongitude)
        
    }
    
    @objc func TouchDown(_ sender: Any){
        checkBtn.backgroundColor = .gray
    }
    
}
