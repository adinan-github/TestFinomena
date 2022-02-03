//
//  RoundedCornerButton.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import UIKit

@IBDesignable
class RoundedCornerButton: UIButton {
  
  // if cornerRadius variable is set/changed, change the corner radius of the UIView
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
