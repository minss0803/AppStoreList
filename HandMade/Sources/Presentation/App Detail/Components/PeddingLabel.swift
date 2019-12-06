//
//  PaddingLabel.swift
//  HandMade
//
//  Created by Adcapsule on 05/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import Foundation
import UIKit

class PeddingLabel: UILabel {
    var topInset: CGFloat = 20.0
    var bottomInset: CGFloat = 20.0
    var leftInset: CGFloat = 20.0
    var rightInset: CGFloat = 20.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset + 50)
    }
}
