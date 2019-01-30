//
//  systemButton.swift
//  slapJack
//
//  Created by Justin Snider on 1/29/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

@IBDesignable
class SystemButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
