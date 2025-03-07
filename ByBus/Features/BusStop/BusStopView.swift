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
    private var direction: Direction = .outbound
    private let disposeBag = DisposeBag()
    
    private let originDestinView = SwapperView()
    private let separator = UIView.plain(bgColor: .separator)
    let backBtn = UIButton.icon(imgName: "chevron.left", bgColor: .clear, imgColor: .systemBlue)
    
    private lazy var tableView: UITableView = {
        var tv = UITableView.plain(id: "\(Self.name)_table")
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
        addSubview(backBtn)
        addSubview(originDestinView)
        addSubview(separator)
        addSubview(tableView)
        
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalTo(originDestinView.snp.centerY)
            $0.size.equalTo(24)
        }
        
        originDestinView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(backBtn.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
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
        
        originDestinView.swapBtn.rx.tap.asSignal()
            .emit(onNext: { [weak self] in
                guard let self else { return }
                self.direction = self.direction.toggle
                self.originDestinView.swap()
                self.getBusStops()
        }).disposed(by: disposeBag)
    }
    
    private func getBusStops() {
        if let routeNo = route.routeNo {
            viewModel.getBusStops(no: routeNo, direction: direction)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: SectionCellView.reuseID, for: indexPath) as! SectionCellView
            cell.setText(with: busStop)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedCellView.reuseID, for: indexPath) as! ExpandedCellView
        cell.setText(with: busStop)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let childIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        if indexPath.row == 0 {
            viewModel.busStops[indexPath.section].isExpanded.toggle()
            tableView.reloadRows(at: [childIndexPath], with: .automatic)
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
