//
//  ViewController.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/07/19.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let map = NMFMapView(frame: view.frame)
        view.addSubview(map)
        
    }


}

