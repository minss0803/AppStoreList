//
//  AppTitleView.swift
//  HandMade
//
//  Created by Adcapsule on 05/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

/**
 앱 정보 노출
 1) 이름
 2) 제작자
 3) 가격
 4) 웹에서 보기, 공유하기
 */
class AppTitleView: UIView {
    private struct UI {
        static let borderColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
    }
    let disposeBag = DisposeBag()
    
    //==== 앱 정보
    let trackNameLabel = UILabel()       // 앱 이름
    let artistNameLabel = UILabel()      // 제작자 이름
    let formattedPriceLabel = UILabel()  // 앱 가격
    
    let deepLinkBorderView = UIView()
    let deeplinkStackView = UIStackView()
    let openWebButton = UIButton()       // 웹에서 보기
    let shareButton = UIButton()         // 공유하기
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(data: AppInfo) {
        trackNameLabel.do {
            $0.text = data.trackName
        }
        artistNameLabel.do {
            $0.text = data.artistName
        }
        formattedPriceLabel.do {
            $0.text = data.formattedPrice
        }
    }
    func attribute() {
        trackNameLabel.do {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .black
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        artistNameLabel.do {
            $0.font = .systemFont(ofSize: 10, weight: .light)
            $0.textColor = .gray
        }
        formattedPriceLabel.do {
            $0.font = .systemFont(ofSize: 25, weight: .bold)
            $0.textColor = .black
        }

        deeplinkStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
        }
        openWebButton.do {
            $0.setTitle("웹에서 보기", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderColor = UI.borderColor.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 10.0
        }
        shareButton.do {
            $0.setTitle("공유하기", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderColor = UI.borderColor.cgColor
            $0.layer.borderWidth = 1.0
            $0.layer.cornerRadius = 10.0
        }
    }
    
    func layout() {
        addSubview(trackNameLabel)
        addSubview(artistNameLabel)
        addSubview(formattedPriceLabel)
        addSubview(deeplinkStackView)
        deeplinkStackView.addArrangedSubview(openWebButton)
        deeplinkStackView.addArrangedSubview(shareButton)
        
        trackNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(trackNameLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(20)
        }
        formattedPriceLabel.snp.makeConstraints {
            $0.top.equalTo(artistNameLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(20)
        }
        deeplinkStackView.snp.makeConstraints {
            $0.top.equalTo(formattedPriceLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

    }
}
