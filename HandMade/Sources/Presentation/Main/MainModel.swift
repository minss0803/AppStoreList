//
//  MainModel.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import RxSwift

struct MainModel {
    let searchAppNetwork: SearchAppNetwork
    
    init(searchAppNetwork: SearchAppNetwork = SearchAppNetworkImpl()) {
        self.searchAppNetwork = searchAppNetwork
    }
    
    func getSearchAppList() -> Observable<Result<[AppInfo], SearchAppNetworkError>> {
        return searchAppNetwork.getAppList()
    }
}
