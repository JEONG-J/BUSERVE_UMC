//
//  HomeViewController.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/04.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    weak var delegate: HomeViewControllerDelegate?
    private lazy var onBoardBusButton = OnBoardBusButtonView()
    private lazy var homeTitleLabel = HomeTitleLabelView()
    private lazy var busSearchTextField =  BusSearchTextField()
//    private lazy var busTableView = BusDataTableView(data: busDataModel, isSortBookMark: false)
    private lazy var busTableView = BusDataTableView(isSortBookMark: false)
    private lazy var searchBusTableView = BusDataTableView()
    private lazy var placeHolderView = PlaceHolderView(placeholderText: "예약하려는\n버스를 검색해주세요.")
//    private let locationManager = CLLocationManager()
    private let nearbyBusStopManager = NearByBusStopManager()
    private var activityIndicator: UIActivityIndicatorView!
    
    private var busSearchTextFieldLeadingConstraint: NSLayoutConstraint!
    private var busSearchTextFieldTopConstraint: NSLayoutConstraint!
    private var busTableViewHeightConstraint: NSLayoutConstraint!
    
    private var busDataCount = 0
    
    private lazy var homeScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var homeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 77
        stackView.alignment = .fill

        stackView.addArrangedSubview(homeTitleLabel)
        stackView.addArrangedSubview(onBoardBusButton)
        
        homeTitleLabel.widthAnchor.constraint(equalToConstant: 196).isActive = true
        onBoardBusButton.widthAnchor.constraint(equalToConstant: 62).isActive = true
        
        return stackView
    }()
    
    private lazy var butTableTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 근처 버스"
        label.font = .headingBold
        label.textColor = .Body
        label.sizeToFit()
        return label
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.MainColor
        return refreshControl
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), for: .normal)
        button.tintColor = UIColor.Body
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), for: .normal)
        button.tintColor = .Body
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarVC = self.tabBarController as? TabBarViewController {
            self.delegate = tabBarVC
        }
        
        self.placeHolderView.isHidden = true
        busSearchTextField.searchDelegate = self
        busSearchTextField.delegate = self
        busTableView.viewControllerDelegate = self
        nearbyBusStopManager.delegate = self
        
        onBoardBusButton.addTarget(self, action: #selector(getOnBusClicked), for: .touchUpInside)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        addSubviews()
        configureConstraints()
        hideKeyboardWhenTappedAround()
        
        showLoading()
        nearbyBusStopManager.requestLocation()
        
        view.backgroundColor = .Background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - layouts
    
    private func addSubviews() {
        
        view.addSubview(homeScrollView)
        homeScrollView.addSubview(contentView)
        homeScrollView.addSubview(refreshControl)

        [topStackView, busSearchTextField, butTableTitleLabel, busTableView, backButton, searchBusTableView, placeHolderView, locationButton, activityIndicator].forEach { contentView.addSubview($0) }
        
        [topStackView, homeScrollView, busSearchTextField, butTableTitleLabel ,busTableView, backButton, searchBusTableView, placeHolderView, locationButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureConstraints() {
        
        busSearchTextFieldLeadingConstraint = busSearchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        busSearchTextFieldLeadingConstraint.isActive = true
        
        busSearchTextFieldTopConstraint = busSearchTextField.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 32)
        busSearchTextFieldTopConstraint.isActive = true
        
        busTableViewHeightConstraint = busTableView.heightAnchor.constraint(equalToConstant: CGFloat(busDataCount) * 160.0)
        busTableViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            homeScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homeScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: homeScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: homeScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),


            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),


            busSearchTextFieldTopConstraint,
            busSearchTextFieldLeadingConstraint,
            busSearchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),


            butTableTitleLabel.topAnchor.constraint(equalTo: busSearchTextField.bottomAnchor, constant: 46),
            butTableTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            butTableTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            locationButton.leadingAnchor.constraint(equalTo: butTableTitleLabel.trailingAnchor, constant: 223),
            locationButton.centerYAnchor.constraint(equalTo: butTableTitleLabel.centerYAnchor),
            locationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),


            busTableView.topAnchor.constraint(equalTo: butTableTitleLabel.bottomAnchor, constant: 20),
            busTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            busTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            busTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backButton.centerYAnchor.constraint(equalTo: busSearchTextField.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 24), // 버튼의 폭 설정
            backButton.heightAnchor.constraint(equalToConstant: 24) // 버튼의 높이 설정
        ])
    }
    
    // MARK: - methods
    
    /// 다른 화면을 터치 시 키보드가 내려가는 메서드
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// busTableView 의 데이터를 다시 로드하는 메서드
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        busTableView.busData.sort { $0.isBookmark && !$1.isBookmark }
        busTableView.reloadData()
        
        // endRefreshing() 메서드를 호출하여 새로 고침 컨트롤을 종료합니다.
        refreshControl.endRefreshing()
    }
    
    @objc func getOnBusClicked(_ sender: UIButton) {
        print("탑승하기 버튼 Clicked")
    }
    
    @objc func locationButtonTapped(_ sender: UIButton) {
        showLoading()  // 로딩 표시 시작
        nearbyBusStopManager.requestLocation()
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        busTableView.isUserInteractionEnabled = false  // tableView와 상호 작용 금지
        busTableView.isHidden = true
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        busTableView.isUserInteractionEnabled = true  // tableView와 상호 작용 허용
        busTableView.isHidden = false
    }
}

// MARK: - Animation extension

extension HomeViewController {
    @objc func backButtonTapped() {
        // 뒤로가기 버튼을 숨기고, 기존 뷰를 표시하고 검색 텍스트 필드를 원래 위치로 이동
        backButton.isHidden = true
        homeScrollView.isScrollEnabled = true // 스크롤을 가능하게 변경
        busSearchTextField.resignFirstResponder() // TextField 의 선택을 해제
        busSearchTextField.text = ""
        busSearchTextField.placeholder = "예약하려는 버스를 검색해주세요."
        
        searchBusTableView.searchBusData(busNumber: "")
        searchBusTableView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.moveAutoLayoutBusSearchTextField(.down)
            self.showHideAnimationView(.show)
            self.upDownAnimationTabbar(.up)

            self.view.layoutIfNeeded()
        } completion: { _ in
            self.searchBusTableView.isHidden = true
        }
    }
    
    /// BusSearchTexstField 를 움직이게 하는 메서드
    func moveAutoLayoutBusSearchTextField(_ animation: AnimationView) {
        // 기존 제약 조건 비활성화
        self.busSearchTextFieldTopConstraint.isActive = false
        self.busSearchTextFieldLeadingConstraint.isActive = false
        
        // 새로운 제약 조건 설정
        switch animation {
        case .up:
            self.busSearchTextFieldTopConstraint = self.busSearchTextField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
            self.busSearchTextFieldLeadingConstraint = self.busSearchTextField.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 8)
        case .down:
            self.busSearchTextFieldTopConstraint = self.busSearchTextField.topAnchor.constraint(equalTo: self.topStackView.bottomAnchor, constant: 32)
            self.busSearchTextFieldLeadingConstraint = self.busSearchTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        }
        
        // 새로운 제약 조건 활성화
        self.busSearchTextFieldTopConstraint.isActive = true
        self.busSearchTextFieldLeadingConstraint.isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    /// View 를 숨기고 나타내는 애니메이션을 동작하는 메서드
    func showHideAnimationView(_ animation: ToogleView) {
        switch animation {
        case .show:
            self.topStackView.alpha = 1
            self.busTableView.alpha = 1
            self.butTableTitleLabel.alpha = 1
            self.locationButton.alpha = 1
            self.searchBusTableView.alpha = 0
            self.placeHolderView.alpha = 0
            
            self.topStackView.isHidden = false
            self.busTableView.isHidden = false
            self.butTableTitleLabel.isHidden = false
            self.locationButton.isHidden = false
            self.searchBusTableView.isHidden = true
            self.placeHolderView.isHidden = true
            
        case .hide:
            self.topStackView.alpha = 0
            self.busTableView.alpha = 0
            self.butTableTitleLabel.alpha = 0
            self.locationButton.alpha = 0
            self.searchBusTableView.alpha = 1
            self.placeHolderView.alpha = 1
            
            self.topStackView.isHidden = true
            self.busTableView.isHidden = true
            self.butTableTitleLabel.isHidden = true
            self.locationButton.isHidden = true
        }
    }
    
    /// TabBar 가 올라오고 내려가는 애니메이션을 동작하는 메서드
    func upDownAnimationTabbar(_ animation: AnimationTabbar) {
        switch animation {
        case .up:
            self.tabBarController?.tabBar.alpha = 1
            self.someFunctionWhereYouWantToShowTabBar()
        case .down:
            self.tabBarController?.tabBar.alpha = 0
            self.someFunctionWhereYouWantToHideTabBar()
        }
    }
    
    func someFunctionWhereYouWantToHideTabBar() {
        delegate?.shouldHideTabBar(true)
    }
    
    func someFunctionWhereYouWantToShowTabBar() {
        delegate?.shouldHideTabBar(false)
    }
}

// MARK: - extension

extension HomeViewController {
    /// ( 라이트, 다크 ) 모드가 변경되었을 때 TableView 의 UI 색상을 업데이트
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            
            if let originalPlaceholder = busSearchTextField.placeholder {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.Secondary_TertiaryColor,
                    .font: UIFont.systemFont(ofSize: 16)
                ]

                busSearchTextField.attributedPlaceholder = NSAttributedString(string: originalPlaceholder, attributes: attributes)
            }
            busSearchTextField.textColor = (traitCollection.userInterfaceStyle == .dark) ? .white : UIColor.Body
            busTableView.reloadData()
            searchBusTableView.reloadData()
        }
    }
}

extension HomeViewController: BusSearchTextFieldDelegate {
    /// TextField 의 Text 가 변경될 때 마다 동작하는 메서드
    func busSearchTextFieldDidChange(_ textField: BusSearchTextField, text: String?) {
        if ((text?.isEmpty) ?? true) {
            placeHolderView.isHidden = false
            searchBusTableView.isHidden = true
        } else {
            placeHolderView.isHidden = true
            searchBusTableView.isHidden = false
        }
        
        searchBusTableView.searchBusData(busNumber: text ?? "")
        searchBusTableView.reloadData()
    }
}

extension HomeViewController: UITextFieldDelegate {
    /// TextField 를 선택 시 동작하는 메서드
    func textFieldDidBeginEditing(_ textField: UITextField) {

        backButton.isHidden = false
        homeScrollView.isScrollEnabled = false
        busSearchTextField.placeholder = "버스 검색"
        
        UIView.animate(withDuration: 0.3) {
            self.moveAutoLayoutBusSearchTextField(.up)
            self.showHideAnimationView(.hide)
            self.upDownAnimationTabbar(.down)
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            print("애니메이션 끝남")
            self.searchBusTableView.isHidden = false
            self.placeHolderView.isHidden = false
            
            NSLayoutConstraint.activate([
                self.placeHolderView.topAnchor.constraint(equalTo: self.busSearchTextField.bottomAnchor, constant: 144),
                self.placeHolderView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                
                self.searchBusTableView.topAnchor.constraint(equalTo: self.busSearchTextField.bottomAnchor, constant: 20),
                self.searchBusTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
                self.searchBusTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
                self.searchBusTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}

protocol HomeViewControllerDelegate: AnyObject {
    func shouldHideTabBar(_ hide: Bool)
}

extension HomeViewController: BusTableViewCellDelegate {
    func didTapReservationButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let message = "버스 좌석을 예약하시려면\n노쇼 방지를 위해서\n위치 인증이 필요해요."
        let attributedString = NSMutableAttributedString(string: message)
        
        // PopUpViewController 인스턴스 생성
        let popUpVC = PopUpViewController(attributedMessageText: attributedString)

        // 버튼 및 동작 추가 (옵션)
        popUpVC.addActionBtn(title: "취소", titleColor: .Secondary, backgroundColor: .ButtonAlertBackground) {
            popUpVC.dismiss(animated: true, completion: nil)
        }
        
        // 버튼 및 동작 추가 (옵션)
        popUpVC.addActionBtn(title: "위치 인증하기", titleColor: .white, backgroundColor: .MainColor) {
            guard let noshow = storyboard.instantiateViewController(withIdentifier: "NoshowController") as? NoShowController else {
                print("Failed to instantiate Noshow")
                return
            }

            popUpVC.dismiss(animated: true) {
                print("PopUp dismissed")
                noshow.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(noshow, animated: true)
            }
        }
        
        // 팝업 뷰 컨트롤러 띄우기
        self.present(popUpVC, animated: true, completion: nil)
    }
}

extension HomeViewController: NearByBusStopManagerDelegate {
    func didUpdateNearByBusStopRoutes(_ data: BusStopRoutesData) {
        // TODO: 여기에서 데이터를 테이블 뷰의 데이터 소스에 할당하고, 테이블 뷰를 리로드하세요.
        
        let busData: [BusDataModel] = data.result.map { busResultData in
            return BusDataModel(
                busNumber: busResultData.routeName,
                Departure: busResultData.endPoint,
                Arrival: busResultData.startPoint,
                isBookmark: busResultData.favorite,
                busRouteId: busResultData.routeId
            )
        }
        
        DispatchQueue.main.async {
            self.busDataCount = busData.count
            
            self.busTableViewHeightConstraint.isActive = false
            self.busTableViewHeightConstraint = self.busTableView.heightAnchor.constraint(equalToConstant: CGFloat(self.busDataCount) * 160.0)
            self.busTableViewHeightConstraint.isActive = true
            
            self.busTableView.reloadData()
            self.busTableView.updateData(busData)
            self.hideLoading()
        }
    }

    func didFailWithError(_ error: Error) {
        // TODO: 여기에서 오류를 처리하거나 사용자에게 알림을 표시하세요.
        print("Failed to update data: \(error)")
    }
}
