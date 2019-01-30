//
//  remainingCardsView.swift
//  slapJack
//
//  Created by Justin Snider on 1/29/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

@IBDesignable
class RemainingCardsView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
