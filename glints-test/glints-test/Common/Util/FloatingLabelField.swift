//
//  FloatingLabelField.swift
//  glints-test
//
//  Created by Brilliann Nuswantara Bhagawanta on 04/01/22.
//

import UIKit

class FloatingLabelField: UITextField {
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero) // Label
    var floatingLabelHeight: CGFloat = 14 // Default height
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    @IBInspectable
    var _placeholder: String?
    
    @IBInspectable
    var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var activeBorderColor: UIColor = UIColor.blue
    
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder // Use our custom placeholder if none is set
        placeholder = self._placeholder // make sure the placeholder is shown
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @objc func addFloatingLabel() {
        if self.text == "" {
            self.floatingLabel.textColor = floatingLabelColor
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = self._placeholder
            self.floatingLabel.layer.backgroundColor = UIColor.white.cgColor
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true
            self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.floatingLabelHeight)
            
            self.layer.borderWidth = 1
            self.layer.borderColor = self.activeBorderColor.cgColor
            self.addSubview(self.floatingLabel)
            
            self.floatingLabel.bottomAnchor.constraint(equalTo:
                                                        self.topAnchor, constant: -10).isActive = true // Place our label 10pts above the text field
            // Remove the placeholder
            self.placeholder = ""
        }
        self.setNeedsDisplay()
    }
    
    @objc func removeFloatingLabel() {
        if self.text == "" {
            UIView.animate(withDuration: 0.13) {
                self.subviews.forEach{ $0.removeFromSuperview() }
                self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.layer.borderColor = UIColor.black.cgColor
    }
}
