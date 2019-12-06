//
//  MainViewModel.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct MainViewModel: MainViewBindable {
    let disposeBag = DisposeBag()
    
    let showAppDetail: Driver<AppInfo>
    let didCellSelected = PublishSubject<AppInfo>()
    
    let viewWillAppear = PublishSubject<Void>()
    let cellData: Driver<[AppInfo]>
    let reloadList: Signal<Void>
    let errorMessage: Signal<String>
    
    private let cells = BehaviorRelay<[AppInfo]>(value: [])
    
    init(model: MainModel = MainModel()) {
        // Request Handler
        let appListResult = viewWillAppear
            .flatMapLatest(model.getSearchAppList)
            .asObservable()
            .share()
        
        let _ = appListResult
            .map { result -> [AppInfo]? in
                guard case .success(let value) = result else {
                    return nil
                }
                return value
            }
            .filterNil()
            .bind(to: cells)
    
        // error Handler
        let appListError = appListResult
            .map { result -> String? in
                guard case .failure(let error) = result else {
                    return nil
                }
                return error.message
            }
            .filterNil()
        
        errorMessage = appListError
            .asSignal(onErrorJustReturn: "서비스가 불안정 합니다. 잠시 후 다시 이용해주세요.")
        
        // Result Handler
        cellData = cells
                  .asDriver(onErrorDriveWith: .empty())
        
        reloadList = appListResult
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
        
        // Others
        showAppDetail = didCellSelected
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
