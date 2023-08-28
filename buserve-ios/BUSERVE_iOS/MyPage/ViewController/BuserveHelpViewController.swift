//
//  BuserveHelpViewController.swift
//  BUSERVE_iOS
//
//  Created by 정태우 on 2023/07/23.
//

import UIKit

class BuserveHelpViewController: UIViewController {
    
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var customerSupportView: UIView!
    @IBOutlet weak var policyView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hrLine1: UIView!
    @IBOutlet weak var hrLine2: UIView!
    var subview1: UIView!
    var subview2: UIView!
    var subview3: UIView!
    var subviewState: [UIView: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        subview1 = UIView(frame: CGRect(x: 0, y: noticeView.frame.height, width: noticeView.frame.width, height: 200))
        subview1.backgroundColor = UIColor.blue
        noticeView.addSubview(subview1)

        subview2 = UIView(frame: CGRect(x: 0, y: customerSupportView.frame.height, width: customerSupportView.frame.width, height: 200))
        subview2.backgroundColor = UIColor.green
        customerSupportView.addSubview(subview2)

        subview3 = UIView(frame: CGRect(x: 0, y: policyView.frame.height, width: policyView.frame.width, height: 200))
        subview3.backgroundColor = UIColor.red
        policyView.addSubview(subview3)

        // UITapGestureRecognizer를 생성하여 view1에 추가
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        noticeView.addGestureRecognizer(tapGestureRecognizer1)

        // UITapGestureRecognizer를 생성하여 view2에 추가
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        customerSupportView.addGestureRecognizer(tapGestureRecognizer2)

        // UITapGestureRecognizer를 생성하여 view3에 추가
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        policyView.addGestureRecognizer(tapGestureRecognizer3)
        
        subviewState[noticeView] = false
        subviewState[customerSupportView] = false
        subviewState[policyView] = false
        subview1.alpha = 0.0
        subview2.alpha = 0.0
        subview3.alpha = 0.0
        self.view.sendSubviewToBack(subview1)
        self.view.sendSubviewToBack(subview2)
        self.view.sendSubviewToBack(subview3)
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "BUSERVE 도움말"
        self.navigationController?.setCustomBackButton(sfSymbol: "chevron.left", imageColor: .Body, weight: .bold)
    }
    private func configureScrollView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true

        // 스크롤뷰의 contentSize를 콘텐츠 뷰의 크기로 설정하여 스크롤 가능한 영역을 지정합니다.
        scrollView.contentSize = contentView.bounds.size
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    // 각 view를 눌렀을 때 호출되는 메서드
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            // 누른 view에 해당하는 subview를 찾아서 toggle로 나타내거나 숨김
            var subview: UIView?

            switch tappedView {
            case noticeView:
                subview = subview1
            case customerSupportView:
                subview = subview2
            case policyView:
                subview = subview3
            default:
                break
            }

            if let subview = subview {
                if self.subviewState[tappedView] == false {
                    UIView.animate(withDuration: 0.3, animations: {
                    subview.alpha = 1.0
                    self.subviewState[tappedView] = true
                    self.adjustViewPositions(tappedView: tappedView, showSubview: true)
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                    subview.alpha = 0.0
                    self.subviewState[tappedView] = false
                    self.adjustViewPositions(tappedView: tappedView, showSubview: false)
                    })
                }
            }
        }
    }
    func adjustViewPositions(tappedView: UIView, showSubview: Bool) {
        if tappedView == noticeView {
            UIView.animate(withDuration: 0.3) {
                if showSubview {
                    self.customerSupportView.frame.origin.y += self.subview1.frame.height
                    self.policyView.frame.origin.y += self.subview1.frame.height
                    self.hrLine1.frame.origin.y += self.subview1.frame.height
                    self.hrLine2.frame.origin.y += self.subview1.frame.height
                } else {
                    self.customerSupportView.frame.origin.y -= self.subview1.frame.height
                    self.policyView.frame.origin.y -= self.subview1.frame.height
                    self.hrLine1.frame.origin.y -= self.subview1.frame.height
                    self.hrLine2.frame.origin.y -= self.subview1.frame.height
                }
            }
        }
        if tappedView == customerSupportView {
            UIView.animate(withDuration: 0.3) {
                if showSubview {
                    self.policyView.frame.origin.y += self.subview2.frame.height
                    self.hrLine2.frame.origin.y += self.subview1.frame.height
                } else {
                    self.policyView.frame.origin.y -= self.subview2.frame.height
                    self.hrLine2.frame.origin.y -= self.subview1.frame.height
                }
            }
        }
    }
}
