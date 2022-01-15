//
//  UIView+Extensions.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 15/01/22.
//

import UIKit

extension UIView {
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}
