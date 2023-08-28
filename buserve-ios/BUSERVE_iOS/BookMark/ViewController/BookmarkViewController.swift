//
//  BookmarkViewController.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/07/31.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var busDataListView = BusDataTableView(isSortBookMark: true)
    private let favoriteBusRoutesManager = FavoriteBusRoutesManager()
    private lazy var placeHolderView = PlaceHolderView(placeholderText: "즐겨찾기한\n버스 노선이 없습니다.")
    private var activityIndicator: UIActivityIndicatorView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.MainColor
        return refreshControl
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        addSubviews()
        configureConstraints()
        
        showLoading()
        updateUI()
        
        placeHolderView.isHidden = true

//        Task {
//            do {
//                let data = try await favoriteBusRoutesManager.fetchFavortieBusRoutes()
//
//                let busData: [BusDataModel] = data.result.map { busResultData in
//                    return BusDataModel(
//                        busNumber: busResultData.routeName,
//                        Departure: busResultData.endPoint,
//                        Arrival: busResultData.startPoint,
//                        isBookmark: busResultData.favorite
//                    )
//                }
//
//                DispatchQueue.main.async {
//                    self.busDataListView.updateData(busData)
//                    self.hideLoading()
//                }
//
//            } catch {
//                hideLoading()
//            }
//        }
        
        
        busDataListView.refreshControl = refreshControl
    }
    
    // MARK: - methods or layouts
    
    private func addSubviews() {
        [busDataListView, activityIndicator, placeHolderView].forEach { view.addSubview($0) }
        busDataListView.addSubview(refreshControl)
        busDataListView.translatesAutoresizingMaskIntoConstraints = false
        placeHolderView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            busDataListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            busDataListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            busDataListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            busDataListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            placeHolderView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            placeHolderView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            placeHolderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            placeHolderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        updateUI()
            self.busDataListView.refreshControl?.endRefreshing()
    }
    
    private func showLoading() {
        activityIndicator.startAnimating()
        busDataListView.isUserInteractionEnabled = false  // tableView와 상호 작용 금지
        busDataListView.isHidden = true
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        busDataListView.isUserInteractionEnabled = true  // tableView와 상호 작용 허용
        busDataListView.isHidden = false
    }
    
    private func updateUI() {
        Task {
            do {
                let data = try await favoriteBusRoutesManager.fetchFavortieBusRoutes()
                
                if data.result.isEmpty {
                    DispatchQueue.main.async {
                        self.hideLoading()
                        self.placeHolderView.isHidden = false
                        self.busDataListView.isHidden = true
                    }
                } else {
                    self.placeHolderView.isHidden = true
                    self.busDataListView.isHidden = false
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
                        self.busDataListView.updateData(busData)
                        self.hideLoading()
                    }
                    
                }
            } catch {
                hideLoading()
            }
        }
    }
}
