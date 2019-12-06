//
//  AppGenreView.swift
//  HandMade
//
//  Created by 민쓰 on 06/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class AppGenreView: UIView {
    
    let scrollView = UIScrollView()
    let titleLabel = UILabel()
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(data: AppInfo) {
        data.genres?.forEach({ (keyword) in
            let view = UIView()
            view.do {
                $0.layer.cornerRadius = 5.0
                               $0.layer.borderColor = UIColor.gray.cgColor
                               $0.layer.borderWidth = 1.0
            }
            let label = UILabel()
            label.do {
                $0.text = keyword
                $0.font = .systemFont(ofSize: 10, weight: .bold)
                $0.textColor = .darkGray
                $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(10)
            }
            stackView.addArrangedSubview(view)
        })
    }
    func attribute() {
        titleLabel.do {
            $0.text = "카테고리"
            $0.font = .systemFont(ofSize: 15, weight: .bold)
            $0.textColor = .black
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(15)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(0)
            $0.left.right.equalToSuperview().offset(20)
            $0.width.equalTo(0).priority(251)
       }
    }
}
