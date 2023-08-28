//
//  BusDataTableView.swift
//  BUSERVE_iOS
//
//  Created by ParkJunHyuk on 2023/08/05.
//

import UIKit

class BusDataTableView: UITableView {

    // MARK: - Properties
    
    private let favoriteBusRoutesManager = FavoriteBusRoutesManager()
    var busData: [BusDataModel] = []
    var isSortBookMark: Bool = false
    weak var viewControllerDelegate: BusTableViewCellDelegate?
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.separatorStyle = .none
        self.backgroundColor = .Background
        self.register(BusTableViewCell.self, forCellReuseIdentifier: "BusCellId")
        self.delegate = self
        self.dataSource = self
    }
    
    convenience init(isSortBookMark: Bool) {
        self.init(frame: .zero, style: .plain)
        self.isSortBookMark = isSortBookMark
        
        isSortBookMark ? self.filterBookmarkBusData() : self.sortBookmarkBusData()
        
        if isSortBookMark {
            self.isScrollEnabled = true
        } else {
            self.isScrollEnabled = false
        }
    }
    
    func updateData(_ newData: [BusDataModel]) {
        self.busData = newData
        self.reloadData()
    }
    
//    convenience init(data: [BusDataModel], isSortBookMark: Bool) {
//        self.init(frame: .zero, style: .plain)
//        self.isSortBookMark = isSortBookMark
//        self.busData = data
//
//        isSortBookMark ? self.filterBookmarkBusData() : self.sortBookmarkBusData()
//
//        if isSortBookMark {
//            self.isScrollEnabled = true
//        } else {
//            self.isScrollEnabled = false
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods or layouts
    
    /// 즐겨찾은 버스를 상단으로 정렬해주는 함수
    private func sortBookmarkBusData() {
        self.busData.sort { $0.isBookmark && !$1.isBookmark }
    }
    
    /// BookMark 페이지에서 Bookmark 된 데이터만 정렬해주는 함수
    private func filterBookmarkBusData() {
        self.busData = self.busData.filter{ $0.isBookmark == true }
    }
    
    /// BookMark 페이지에서 Bookmark 된 데이터만 정렬해주는 함수
    func searchBusData(busNumber: String) {
        self.busData = busData.filter{ $0.busNumber.contains(busNumber) }
    }
}

    // MARK: - TableView Delegate

/// TableView 는 Cell 간격을 둘 수 없어 짝수번째의 Cell 에 데이터를 입력, 홀수번째는 빈 Cell 로 간격을 설정
extension BusDataTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busData.count * 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 138
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusCellId", for: indexPath) as! BusTableViewCell
            cell.delegate = viewControllerDelegate
            cell.backgroundColor = .DarkModeSecondBackground
            cell.selectionStyle = .none
            cell.layer.borderWidth = (traitCollection.userInterfaceStyle == .dark) ? 0 : 1
            cell.layer.cornerRadius = 16
            cell.layer.borderColor = UIColor.Tertiary.cgColor
            let index = indexPath.row / 2
            let data = busData[index]
            let routeMap = "\(data.Departure + " ↔ " + data.Arrival)"
            
            cell.busNum.text = "\(data.busNumber)"
            cell.routeMap.text = "\(routeMap)"
            
            cell.settingBookmarkButton(isBookmarked: data.isBookmark)
            
            /// 클로저를 사용하여 버튼이 눌렸을 때 수행하는 작업
            cell.onBookmarkButtonTap = { [weak self] in
                if self?.busData[index].isBookmark == false {
                    Task {
                        do {
                            print(data.busRouteId)
                            let result = try await self?.favoriteBusRoutesManager.addFavortieBusRoutes(routeID: data.busRouteId)
                            
                            self?.busData[index].isBookmark.toggle()
                            self?.reloadRows(at: [indexPath], with: .automatic)
                        } catch {
                            print("즐겨찾기 추가가 되지 않았음")
                        }
                    }
                } else {
                    Task {
                        do {
                            print(data.busRouteId)
                            let result = try await self?.favoriteBusRoutesManager.deleteFavortieBusRoutes(routeID: data.busRouteId)
                            
                            self?.busData[index].isBookmark.toggle()
                            self?.reloadRows(at: [indexPath], with: .automatic)
                        } catch {
                            print("즐겨찾기 삭제가 되지 않았음")
                        }
                    }
                }
            }
            return cell
            
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .Background
            cell.selectionStyle = .none
            return cell
        }
        
    }
}
