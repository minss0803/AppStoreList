//
//  AppDetailModel.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation

struct AppDetailModel {

    
    func convertKilobyte(from bytes:Double) -> Double {
        return bytes / 1024 / 1024
    }
    
    func parseData(data: AppInfo) -> [AppDetailInfoView.Data] {
        let appSize = convertKilobyte(from: Double(data.fileSizeBytes ?? "0") ?? 0)
        return [(type: .size, titleName: "크기", value: String(format:"%.1f", appSize) + "MB", expandValue: ""),
                (type: .age, titleName: "연령", value: data.contentAdvisoryRating ?? "", expandValue: ""),
                (type: .releaseNote, titleName: "새로운 기능", value: data.version ?? "", expandValue: data.releaseNotes ?? "")]
    }
    
}
