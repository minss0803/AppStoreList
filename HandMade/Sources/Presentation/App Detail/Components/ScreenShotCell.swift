//
//  ScreenShotCell.swift
//  HandMade
//
//  Created by 민쓰 on 04/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class ScreenShotCell: UICollectionViewCell {
    private struct UI {
        static let borderColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
    }
    typealias Data = (String)
    
    let imageView = UIImageView()  // 스크린샷 파일
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: Data) {
        imageView.do {
            $0.kf.setImage(with: URL(string: data))
        }
    }
    
    func attribute() {
        imageView.do {
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UI.borderColor.cgColor
            $0.layer.cornerRadius = 20
            $0.contentMode = .scaleAspectFill
        }
    }
    
    func layout() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
