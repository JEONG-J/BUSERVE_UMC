//
//  TabBarViewController.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/12.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 0
        self.tabBar.tintColor = .MainColor
        self.tabBar.barTintColor = .DarkModeSecondBackground
        self.tabBar.isTranslucent = false // 시스템 상 블러 효과가 기본으로 적용되어 있어 제거해주는 역할
        self.tabBar.layer.cornerRadius = 30.0
        self.tabBar.layer.masksToBounds = true
        setupTabItems()
        
        if let navigationController = self.navigationController {
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 100
        tabFrame.origin.y = self.view.frame.size.height - 100
        self.tabBar.frame = tabFrame
        
        setupTopLineTabBarLayout()
   }

    // MARK: - Tab Setup
    
    private func setupTopLineTabBarLayout() {
        let layer = CAShapeLayer()
        let path = UIBezierPath()

        let cornerRadius: CGFloat = 30.0 // 탭바의 라운드 처리된 부분의 반경입니다.

        // 좌측 상단 시작점
        path.move(to: CGPoint(x: 0, y: cornerRadius))

        // 좌측 상단 라운드 처리된 부분 그림
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: .pi,
                    endAngle: 1.5 * .pi,
                    clockwise: true)

        // 상단 우측까지 그림
        path.addLine(to: CGPoint(x: tabBar.bounds.width - cornerRadius, y: 0))

        // 우측 상단 라운드 처리된 부분 그림
        path.addArc(withCenter: CGPoint(x: tabBar.bounds.width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: 1.5 * .pi,
                    endAngle: 2 * .pi,
                    clockwise: true)

        layer.path = path.cgPath
        layer.strokeColor = UIColor.Tertiary_SecondaryColor.cgColor //(traitCollection.userInterfaceStyle == .dark) ? UIColor.Secondary.cgColor : UIColor.Tertiary.cgColor // 테두리 색상 설정
        layer.lineWidth = 1.5 // 테두리 두께 설정
        layer.fillColor = UIColor.clear.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: cornerRadius * 2) // gradientLayer의 크기 설정
        gradientLayer.colors = [UIColor.clear.cgColor,
                                layer.strokeColor!,
                                layer.strokeColor!,
                                UIColor.clear.cgColor] // 알파값이 변화하는 그라디언트

        let roundPercent = cornerRadius / tabBar.bounds.width
        gradientLayer.locations = [0, NSNumber(value: Float(roundPercent)), NSNumber(value: 1.0 - Float(roundPercent)), 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        tabBar.layer.addSublayer(layer)
        layer.mask = gradientLayer  // gradientLayer를 mask로 설정하여 두께를 조절
    }
    
    private func setupTabItems() {
        let notSelectedHomeIconhomeIcon = UIImage(named: "notSelectedHomeIcon")
        let notSelectedBookMarkIcon = UIImage(named: "notSelectedBookMarkIcon")
        let notSelectedNearBusStationIcon = UIImage(named: "notSelectedNearBusStationIcon")
        let notSelectedMyPageIcon = UIImage(named: "notSelectedMyPageIcon")
        
        let selectedHomeIconhomeIcon = UIImage(named: "selectedHomeIcon")
        let selectedBookMarkIcon = UIImage(named: "selectedBookMarkIcon")
        let selectedNearBusStationIcon = UIImage(named: "selectedNearBusStationIcon")
        let selectedMyPageIcon = UIImage(named: "selectedMyPageIcon")
        
        let home = createNavigation(title: nil, notselectedImage: notSelectedHomeIconhomeIcon, selectedImage: selectedHomeIconhomeIcon, viewController: HomeViewController())
        let bookMark = createNavigation(title: "즐겨찾기", notselectedImage: notSelectedBookMarkIcon, selectedImage: selectedBookMarkIcon, viewController: BookmarkViewController())
        let nearBusStation = createNavigation(title: "내 근처 버스정류장", notselectedImage: notSelectedNearBusStationIcon, selectedImage: selectedNearBusStationIcon, viewController: BusReserveViewController())
        let myPage = createStoryBoardNavigation(title: "마이페이지", notselectedImage: notSelectedMyPageIcon, selectedImage: selectedMyPageIcon, viewController: "MyPageViewController")
        
        self.setViewControllers([home, bookMark, nearBusStation, myPage], animated: true)
    }
    
    // MARK: - methods

    private func createNavigation(title: String?, notselectedImage: UIImage?, selectedImage: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        
        viewController.navigationItem.title = title
        navigation.tabBarItem.image = notselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        
        return navigation
    }
    
    private func createStoryBoardNavigation(title: String?, notselectedImage: UIImage?, selectedImage: UIImage?, viewController: String) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewController)
        
        let navigation = UINavigationController(rootViewController: viewController)
        
        viewController.navigationItem.title = title
        navigation.tabBarItem.image = notselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        
        return navigation
    }
}
// MARK: - extension

extension UITabBarController {
    func updateViewLayoutsForTabBar(hidden: Bool) {
        if hidden {
            // tabBar가 숨겨져 있으면 전체 뷰의 높이를 tabBar의 높이만큼 늘려줍니다.
            selectedViewController?.view.frame.size.height = view.frame.height + tabBar.frame.height - 36
        } else {
            // tabBar가 표시되면 전체 뷰의 높이를 원래대로 되돌립니다.
            selectedViewController?.view.frame.size.height = view.frame.height + 36
        }
    }

    func hideTabBarAnimated(hide:Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            if hide {
                self.tabBar.transform = CGAffineTransform(translationX: 0, y: self.tabBar.frame.height)
                self.tabBar.isHidden = true
            } else {
                self.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
                self.tabBar.isHidden = false
            }
        }) { (finished) in
            if finished {
                self.updateViewLayoutsForTabBar(hidden: hide)
            }
        }
    }
}

extension UITabBarController: HomeViewControllerDelegate {
    func shouldHideTabBar(_ hide: Bool) {
        hideTabBarAnimated(hide: hide)
    }
}
