//
//  CurrentLoactionAuth.swift
//  BUSERVE_iOS
//
//  Created by 정의찬 on 2023/08/23.
//

import UIKit
import FloatingPanel

class CurrentLoactionAuth: MapsViewController, FloatingPanelControllerDelegate {
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheet()
        setBtn()
        
        
    }
    
    override func setBtn() {
        locationBtn.sizeBtn(335, 454.66666666666663, 50, 50)
    }
    private func sheet(){
        let apper = SurfaceAppearance()
        apper.cornerRadius = 16.0
        
        let fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.layout = SetPanelLayout()
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "currentLocationSheetPop") as? currentLocationSheetPop
        else{
            return
        }
        
        fpc.surfaceView.appearance = apper
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        
        
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        let yPos = fpc.surfaceView.frame.origin.y
        self.locationBtn.frame.origin.y = yPos - self.locationBtn.frame.height - 15
        print(yPos - self.locationBtn.frame.height - 10)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class SetPanelLayout: FloatingPanelLayout{
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.4, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 10, edge: .bottom, referenceGuide: .safeArea),
    ]
}
