//
//  MainViewController.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAppState
import SnapKit
import Then
import Toaster

protocol MainViewBindable {
    //View -> ViewModel
    var viewWillAppear: PublishSubject<Void> { get }
    var didCellSelected: PublishSubject<AppInfo> { get }
    
    //ViewModel -> View
    var showAppDetail: Driver<AppInfo> { get }
    var cellData: Driver<[AppInfo]> { get }
    var reloadList: Signal<Void> { get }
    var errorMessage: Signal<String> { get }
}

class MainViewController: ViewController<MainViewBindable> {
    
    let tableView = UITableView()
    
    override func bind(_ viewModel: MainViewBindable) {
        self.disposeBag = DisposeBag()

        // 화면이 나타날때 마다 목록 API를 재호출 합니다.
        self.rx.viewWillAppear
            .map { _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        // 테이블뷰의 아이템을 선택했을 때, viewModel에 선택된 아이템데이터를 bind 합니다.
        tableView.rx.modelSelected(AppInfo.self)
            .bind(to: viewModel.didCellSelected)
            .disposed(by: disposeBag)
        // 선택된 데이터를 기반으로, 상세 화면 띄웁니다.
        viewModel.showAppDetail
            .asDriver()
            .drive(onNext: { [weak self] (info) in
                let view = AppDetailViewController()
                let viewModel = AppDetailViewModel()
                view.bind(viewModel)
                
                viewModel.detailData.onNext(info)
                self?.navigationController?.pushViewController(view, animated: true)
            })
            .disposed(by: disposeBag)
        // API를 통해 전달된 데이트를 테이블뷰에 표시합니다.
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: String(describing: AppListCell.self), for: index) as! AppListCell
                cell.setData(data: data)
                return cell
            }
            .disposed(by: disposeBag)
        // API 연동 성공 시, 테이블 뷰를 리로딩 합니다.
        viewModel.reloadList
            .emit(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // API 연동 실패 시, 토스트 메시지를 띄웁니다.
        viewModel.errorMessage
            .emit(onNext: { (msg) in
                Toast(text: msg, delay: 0, duration: 0.5).show()
            })
            .disposed(by: disposeBag)

    }
    
    override func attribute() {
        title = "핸드메이드"
        navigationItem.do {
            if #available(iOS 11.0, *) {
                $0.largeTitleDisplayMode = .always
            }
        }
        self.do {
            if #available(iOS 11.0, *) {
                $0.automaticallyAdjustsScrollViewInsets = false
            }
        }
        tableView.do {
            $0.register(AppListCell.self, forCellReuseIdentifier: String(describing: AppListCell.self))
            $0.separatorStyle = .none
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 500
            $0.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11.0, *) {
                $0.contentInsetAdjustmentBehavior = .automatic
            }
        }
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
