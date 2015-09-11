//
//  Checkbox.swift
//  Pods
//
//  Created by Miguel Saiz on 9/11/15.
//
//

import UIKit

public protocol CheckboxDelegate {
  func canCheck(enabled: Bool)
  func checked(checkbox: Checkbox)
  func unchecked(checkbox: Checkbox)
}


public class Checkbox: UIControl {
  
  internal var checkedImageView = UIImageView()
  internal var uncheckedImageView = UIImageView()
  public var scaleFactor: CGFloat = 1.2
  public var animationDuration: NSTimeInterval = 0.1
  public var delegate: CheckboxDelegate?

  init() {
    super.init(frame: CGRectZero)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func setCheckedImage(image: UIImage) {
    checkedImageView.image = image
    checkedImageView.alpha = 0
    addSubview(checkedImageView)
  }
  
  public func setUncheckedImage(image: UIImage) {
    uncheckedImageView.image = image
    addSubview(uncheckedImageView)
  }
  
  override public func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    
    transform = CGAffineTransformIdentity
    UIView.animateWithDuration(animationDuration) { () -> Void in
      self.transform = CGAffineTransformMakeScale(self.scaleFactor, self.scaleFactor)
    }
    
    return true
  }
  
  public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
    
    if let point = touch?.locationInView(self) where pointInside(point, withEvent: nil) {
      selected = !selected
      
      delegate?.checked(self)
      UIView.animateWithDuration(animationDuration) { () -> Void in
        self.transform = CGAffineTransformIdentity
        self.checkedImageView.alpha = self.selected ? 1 : 0
        self.uncheckedImageView.alpha = self.selected ? 0 : 1
      }
      
    } else {
      delegate?.unchecked(self)
      UIView.animateWithDuration(animationDuration) { () -> Void in
        self.transform = CGAffineTransformIdentity
      }
    }
  }
  
  override public func layoutSubviews() {
    checkedImageView.frame = bounds
    uncheckedImageView.frame = bounds
  }

}
