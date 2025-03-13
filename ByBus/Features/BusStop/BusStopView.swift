//
//  BusStopView.swift
//  ByBus
//
//  Created by Elvis Cheng on 18/2/2025.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BusStopView: UIView {
    static let name = "BusStopView"
    
    private let route: Route
    private let viewModel: BusStopViewModel
    private let disposeBag = DisposeBag()
    
    private let originDestinView = SwapperView()
    private let separator = UIView.plain(bgColor: .separator)
    
    private lazy var tableView: UITableView = {
        var tv = UITableView.plain(id: UI.tableView.id)
        tv.delegate = self
        tv.dataSource = self
        tv.register(SectionCellView.self, forCellReuseIdentifier: SectionCellView.reuseID)
        tv.register(ExpandedCellView.self, forCellReuseIdentifier: ExpandedCellView.reuseID)
        return tv
    }()
    
    init(with route: Route, and viewModel: BusStopViewModel) {
        self.route = route
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUI()
        setLayout()
        setBinding()
        getBusStops()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
        originDestinView.setText(origin: route.origTc, destin: route.destTc)
    }
    
    private func setLayout() {
        addSubview(originDestinView)
        addSubview(separator)
        addSubview(tableView)
        
        originDestinView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(originDestinView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setBinding() {
        viewModel.reloadDataRelay.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.reloadRowRelay.asSignal()
            .emit(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }).disposed(by: disposeBag)
        
        originDestinView.swapBtn.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.viewModel.toggleDirection()
                self.originDestinView.swap()
                self.getBusStops()
        }).disposed(by: disposeBag)
    }
    
    private func getBusStops() {
        if let routeNo = route.routeNo {
            viewModel.getBusStops(no: routeNo)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Table View Delegate
extension BusStopView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.busStops.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busStop = viewModel.busStops[indexPath.section]
        
        if indexPath.row == 0 {
            // header cell
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionCellView.reuseID, for: indexPath) as! SectionCellView
            cell.setText(with: busStop)
            return cell
        } else {
            // expandable cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedCellView.reuseID, for: indexPath) as! ExpandedCellView
            cell.onSelect = { [weak self] isSelected, busStop in
                guard let self else { return }
                self.viewModel.saveStop(isSelected, busStop.id, busStop.routeNo, route.origin, route.destination)
            }
            cell.setText(with: busStop)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let childIndexPath = IndexPath(row: 1, section: indexPath.section)
        if indexPath.row == 0 {
            viewModel.busStops[indexPath.section].isExpanded.toggle()
            let busStop = viewModel.busStops[indexPath.section]
            if busStop.isExpanded {
                viewModel.getEta(index: indexPath.section, stopID: busStop.id, routeNo: busStop.routeNo)
            } else {
                tableView.reloadRows(at: [childIndexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let busStop = viewModel.busStops[indexPath.section]
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        }
        return busStop.isExpanded ? UITableView.automaticDimension : 0
    }
}


// MARK: - Accessibility Identifier
extension BusStopView {
    enum UI: String {
        case tableView = "tableView"
        case backBtn   = "backButton"
        
        var id: String {
            return "\(name)_\(rawValue)"
        }
    }
}
