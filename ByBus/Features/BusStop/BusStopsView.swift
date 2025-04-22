//
//  BusStopsView.swift
//  ByBus
//
//  Created by Elvis Cheng on 18/2/2025.
//

import UIKit
import MapKit
import SnapKit
import RxSwift
import RxCocoa

final class BusStopsView: UIView {
    static let name = "BusStopsView"
    
    private let viewModel: BusStopsViewModel
    private let disposeBag = DisposeBag()
    
    private let originDestinView = SwapperView()
    private let separator = UIView.plain(bgColor: .separator)
    
    private let locationManager = CLLocationManager()
    
    private lazy var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        mapView.userTrackingMode = .followWithHeading
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var tableView: UITableView = {
        var tv = UITableView.plain(id: UI.tableView.id, backgroundColor: .systemGroupedBackground)
        tv.delegate = self
        tv.dataSource = self
        tv.register(BusStopCellView.self, forCellReuseIdentifier: BusStopCellView.reuseID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        return tv
    }()
    
    init(with viewModel: BusStopsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUI()
        setLayout()
        setBinding()
        getBusStops()
        showUserCurrentLocation()
    }
    
    private func setUI() {
        backgroundColor = .systemBackground
        originDestinView.setText(origin: viewModel.route.origin.value, destin: viewModel.route.destination.value)
    }
    
    private func setLayout() {
        addSubview(originDestinView)
        addSubview(separator)
        addSubview(mapView)
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
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(originDestinView.snp.height).multipliedBy(3.5)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom)
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
                self.viewModel.switchDirection()
                self.originDestinView.swap()
                self.getBusStops()
            }).disposed(by: disposeBag)
    }
    
    private func getBusStops() {
        Task {
            if let routeNo = viewModel.route.routeNo {
                await viewModel.getBusStops(no: routeNo)
                drawPins()
            }
        }
    }
    
    private func drawPins() {
        mapView.removeAnnotations(mapView.annotations)
        
        let coordinates = viewModel.coordinates
        for (index, coordinate) in coordinates.enumerated() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(index + 1)"
            mapView.addAnnotation(annotation)
        }
        
        zoomToCoordinate(coordinate: coordinates.first, regionRadius: 1000)
    }
    
    private func zoomToCoordinate(coordinate: CLLocationCoordinate2D?, regionRadius: CLLocationDistance) {
        if let coordinate {
            let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    private func showUserCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Table View Delegate
extension BusStopsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.busStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let busStop = viewModel.busStops[row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BusStopCellView.reuseID, for: indexPath) as! BusStopCellView
        cell.setText(with: busStop)
        cell.onSelect = { [weak self] busStop in
            guard let self else { return }
            self.saveBusStop(with: busStop)
        }
        return cell
    }
    
    private func saveBusStop(with busStop: BusStop) {
        Task {
            let origin = self.viewModel.route.origin
            let destination = self.viewModel.route.destination
            await self.viewModel.saveBookmark(id: busStop.id, routeNo: busStop.routeNo, name: busStop.name, origin: origin, destination: destination)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        viewModel.busStops[row].isExpanded.toggle()
        let busStop = viewModel.busStops[row]
        if busStop.isExpanded {
            Task {
                await viewModel.getEta(index: indexPath.row, stopID: busStop.id, routeNo: busStop.routeNo)
            }
        } else {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        zoomToCoordinate(coordinate: viewModel.busStops[row].coordinate, regionRadius: 1000)
    }
}


// MARK: - MKMapViewDelegate
extension BusStopsView: MKMapViewDelegate {

}


// MARK: - CLLocationManagerDelegate
extension BusStopsView: CLLocationManagerDelegate {

}


// MARK: - Accessibility Identifier
extension BusStopsView {
    enum UI: String {
        case tableView = "tableView"
        case backBtn   = "backButton"
        
        var id: String {
            return "\(name)_\(rawValue)"
        }
    }
}
