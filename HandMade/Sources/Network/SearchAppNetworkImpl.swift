//
//  SearchAppNetworkImpl.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchAppNetworkImpl: SearchAppNetwork {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getAppList() -> Observable<Result<[AppInfo], SearchAppNetworkError>> {
        guard let url = makeGetAppListComponents().url else {
            let error = SearchAppNetworkError.error("올바르지 않은 URL입니다.")
            return .just(.failure(error))
        }
        return session.rx.data(request: URLRequest(url: url))
            .map { data in
                do {
                    let appList = try JSONDecoder().decode(SearchApp.self, from: data)
                    return .success(appList.results ?? [])
                } catch {
                    return .failure(.error("getRandomBeer API 에러"))
                }
        }
    }

}

private extension SearchAppNetworkImpl {
    struct SearchAppAPI {
        static let scheme = "https"
        static let host = "itunes.apple.com"
        static let path = "/search"
    }
    
    // URLComponents 생성
    // https://itunes.apple.com/search?term=핸드메이드&country=kr&media=software
    func makeGetAppListComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = SearchAppAPI.scheme
        components.host = SearchAppAPI.host
        components.path = SearchAppAPI.path
        components.queryItems = [
            URLQueryItem(name: "term", value: "핸드메이드"),
            URLQueryItem(name: "country", value: "kr"),
            URLQueryItem(name: "media", value: "software")
        ]
        
        return components
    }
}
