//
//  AppDetailInfoView.swift
//  HandMade
//
//  Created by Adcapsule on 05/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class AppDetailInfoView: UIView {
    private struct UI {
        static let valueTitleColor = UIColor(red: 98.0 / 255.0, green: 124.0 / 255.0, blue: 1.0, alpha: 1.0)
        static let underLineColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
        static let expandBgColor = UIColor(white: 230.0 / 255.0, alpha: 1.0)
        static let collaspeDegree = CGAffineTransform(rotationAngle: 360 * CGFloat(Double.pi/180))
        static let expandDegree = CGAffineTransform(rotationAngle: 180 * CGFloat(Double.pi/180))
    }
    
    typealias Data = (type:AppDetailInfoType, titleName: String, value: String, expandValue: String)
    
    //==== 앱 상세정보
    var type: AppDetailInfoType?
    let titleLabel = UILabel()          // 타이틀 (예시: 크기)
    let valueLabel = UILabel()          // 값 (예시: 76KB)
    let arrowImageView = UIImageView()  // 화살표 이미지
    let underlineView = UIView()        // 밑줄
    let expandSubView = UIView()        // 확장하기 버튼을 누른경우 나타나는 뷰
    let expandLabel = UILabel()         // 확장하기에 해당되는 내용을 노출
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(data: Data) {
        titleLabel.do {
            $0.text = data.titleName
        }
        valueLabel.do {
            $0.text = data.value
        }
        arrowImageView.do {
            $0.isHidden = data.expandValue.isEmpty
        }
        expandLabel.do {
            $0.text = data.expandValue
        }
    }
    func attribute() {
        titleLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.textColor = .black
        }
        valueLabel.do {
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.textColor = UI.valueTitleColor
        }
        arrowImageView.do {
            $0.image = UIImage(named: "ico_arrow")
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }
        underlineView.do {
            $0.backgroundColor = UI.underLineColor
        }
        expandSubView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = UI.expandBgColor
        }
        expandLabel.do {
            $0.font = .systemFont(ofSize: 13, weight: .regular)
            $0.textColor = UIColor.gray
            $0.numberOfLines = 0
            $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(arrowImageView)
        addSubview(underlineView)
        addSubview(expandSubView)
        expandSubView.addSubview(expandLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().inset(20)
        }
        valueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(titleLabel.snp.right).offset(10)
        }
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.left.equalTo(valueLabel.snp.right).offset(5)
            $0.right.equalToSuperview().inset(20)
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        expandSubView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom).inset(1)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
        expandLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10).priority(500)
            $0.left.right.equalToSuperview().inset(30)
        }
    }
    
    func animExpand() {
        guard (expandLabel.text ?? "").isEmpty == false else { return }
        if expandSubView.bounds.height == 0 {
            // Expand Animation 실행
            expandSubView.snp.remakeConstraints {
                $0.top.equalTo(underlineView.snp.bottom).inset(1)
                $0.left.right.bottom.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.2) {
                self.arrowImageView.transform = UI.expandDegree
            }
            
        }else{
            // Collaspe Animaion 실행
            expandSubView.snp.remakeConstraints {
                $0.top.equalTo(underlineView.snp.bottom).inset(1)
                $0.left.right.bottom.equalToSuperview()
                $0.height.equalTo(0)
            }
            UIView.animate(withDuration: 0.2) {
                self.arrowImageView.transform = UI.collaspeDegree
            }
           
        }
        
       
    }
}
