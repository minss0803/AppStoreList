//
//  AppListCell.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher
import Cosmos

class AppListCell: UITableViewCell {
    private struct UI {
        static let borderColor = UIColor(white: 220.0 / 255.0, alpha: 1.0)
    }
    
    let cellContainerView = UIView()
    let appInfoContainerView = UIView()
    let appDetailInfoContainerView = UIView()
    
    let artworkImageView = UIImageView() // 앱 아트워크 이미지
    //==== 앱 정보
    let trackNameLabel = UILabel()       // 앱 이름
    let artistNameLabel = UILabel()      // 제작자 이름
    //==== 앱 분류 정보
    let genresLabel = UILabel()          // 앱 카테고리
    let formattedPriceLabel = UILabel()  // 앱 가격(언어별 포맷팅 되어있음)
    let averageUserRatingView = CosmosView() // 평균 별점
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: AppInfo) {
        self.do {
            $0.selectionStyle = .none
        }
        
        artworkImageView.do {
            $0.kf.setImage(with: URL(string: data.artworkUrl512 ?? ""))
        }
        
        trackNameLabel.do {
            $0.text = data.trackName
        }
        
        artistNameLabel.do {
            $0.text = data.artistName
        }
        
        genresLabel.do {
            $0.text = data.genres?.first
        }
        
        formattedPriceLabel.do {
            $0.text = data.formattedPrice
        }
        
        averageUserRatingView.do {
            $0.rating = Double(data.averageUserRating ?? 0)
        }
        
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = .clear
        }
        cellContainerView.do {
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UI.borderColor.cgColor
            $0.layer.cornerRadius = 20.0
        }
        
        appInfoContainerView.do {
            $0.backgroundColor = .white
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UI.borderColor.cgColor
        }
        artworkImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        trackNameLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .darkGray
        }
        artistNameLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .light)
            $0.textColor = .gray
        }
        genresLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .darkGray
        }
        formattedPriceLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .light)
            $0.textColor = .darkGray
        }
        averageUserRatingView.do {
            $0.settings.updateOnTouch = false
            $0.settings.fillMode = .half
            $0.settings.starSize = 15
            $0.settings.starMargin = 0
        }
    }
    
    func layout() {
        addSubview(cellContainerView)
        cellContainerView.addSubview(artworkImageView)
        cellContainerView.addSubview(appInfoContainerView)
        cellContainerView.addSubview(appDetailInfoContainerView)
        
        appInfoContainerView.addSubview(trackNameLabel)
        appInfoContainerView.addSubview(artistNameLabel)
        
        appDetailInfoContainerView.addSubview(genresLabel)
        appDetailInfoContainerView.addSubview(averageUserRatingView)
        appDetailInfoContainerView.addSubview(formattedPriceLabel)
        
        cellContainerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().priority(250)
        }
        
        artworkImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(snp.width)
        }
        
        appInfoContainerView.snp.makeConstraints {
            $0.top.equalTo(artworkImageView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        appDetailInfoContainerView.snp.makeConstraints {
            $0.top.equalTo(appInfoContainerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        trackNameLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(10)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(trackNameLabel.snp.bottom)
            $0.bottom.left.right.equalToSuperview().inset(10)
        }
        
        genresLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(10)
        }
        averageUserRatingView.snp.makeConstraints {
            $0.top.equalTo(genresLabel).inset(0)
            $0.left.greaterThanOrEqualTo(genresLabel.snp.right)
            $0.right.equalToSuperview().inset(10)
            $0.height.equalTo(15)
        }
        formattedPriceLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom)
            $0.bottom.left.right.equalToSuperview().inset(10)
        }
    }
}
