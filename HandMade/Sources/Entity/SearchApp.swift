//
//  SearchApp.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation

struct SearchApp: Codable {
    let resultCount: Int?
    let results: [AppInfo]?
}

struct AppInfo: Codable {
    let screenshotUrls: [String]?   // 앱 스크린샷
    let artworkUrl512: String?      // 아트워크 이미지
    let trackName: String?          // 앱 이름
    let artistName: String?         // 제작자 이름
    let genres: [String]?           // 앱 카테고리
    let formattedPrice: String?     // 앱 가격
    let averageUserRating: Float?   // 평균 별점
    let fileSizeBytes: String?       // 앱 용량
    let contentAdvisoryRating:String?// 연령대
    let version:String?             // 최신버전
    let releaseNotes:String?        // 업데이트 내역
    let description: String?        // 앱 소개
    let trackViewUrl: String?       // 앱 링크
    
    enum CodingKeys: String, CodingKey {
        case screenshotUrls, artworkUrl512, trackName, artistName, genres, formattedPrice, averageUserRating, fileSizeBytes, contentAdvisoryRating, version, releaseNotes, description, trackViewUrl
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.screenshotUrls = try? values.decode([String].self, forKey: .screenshotUrls)
        self.artworkUrl512 = try? values.decode(String.self, forKey: .artworkUrl512)
        self.trackName = try? values.decode(String.self, forKey: .trackName)
        self.artistName = try? values.decode(String.self, forKey: .artistName)
        self.genres = try? values.decode([String].self, forKey: .genres)
        self.formattedPrice = try? values.decode(String.self, forKey: .formattedPrice)
        self.averageUserRating = try? values.decode(Float.self, forKey: .averageUserRating)
        self.fileSizeBytes = try? values.decode(String.self, forKey: .fileSizeBytes)
        self.contentAdvisoryRating = try? values.decode(String.self, forKey: .contentAdvisoryRating)
        self.version = try? values.decode(String.self, forKey: .version)
        self.releaseNotes = try? values.decode(String.self, forKey: .releaseNotes)
        self.description = try? values.decode(String.self, forKey: .description)
        self.trackViewUrl = try? values.decode(String.self, forKey: .trackViewUrl)
    }
}
