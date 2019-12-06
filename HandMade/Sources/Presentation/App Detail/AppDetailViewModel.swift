//
//  AppDetailViewModel.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct AppDetailViewModel: AppDetailViewBindable {
    let detailData = PublishSubject<AppInfo>()
    
    let appInfoData: Driver<AppInfo>
    let appDetailInfoData: Driver<[AppDetailInfoView.Data]>
    let screenShotData: Driver<[String]>
    let reloadList: Signal<Void>
    
    init(model: AppDetailModel = AppDetailModel()) {
        
        appInfoData = detailData
            .map { $0 }
            .asDriver(onErrorDriveWith: .empty())

        appDetailInfoData = detailData
            .map(model.parseData)
            .asDriver(onErrorJustReturn: [])
        
        screenShotData = detailData
            .map { $0.screenshotUrls }
            .filterNil()
            .asDriver(onErrorJustReturn: [])
        
        reloadList = Observable
            .combineLatest(appInfoData.asObservable(), appDetailInfoData.asObservable())
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    
    }
}
