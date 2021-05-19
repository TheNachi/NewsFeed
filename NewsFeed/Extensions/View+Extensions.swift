//
//  View+Extensions.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
            setNeedsLayout()
        }
    }

    @IBInspectable var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
            setNeedsLayout()
        }

        get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
            setNeedsLayout()
        }

        get {
            return layer.borderWidth
        }
    }
}
