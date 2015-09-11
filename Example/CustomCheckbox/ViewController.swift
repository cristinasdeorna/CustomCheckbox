//
//  ViewController.swift
//  CustomCheckbox
//
//  Created by Miguel Saiz on 09/11/2015.
//  Copyright (c) 2015 Miguel Saiz. All rights reserved.
//

import UIKit
import CustomCheckbox

class ViewController: UIViewController {
  var currentlyChecked = 0
  var maxChecked = 2
  @IBOutlet weak var cb1: Checkbox!
  @IBOutlet weak var cb2: Checkbox!
  @IBOutlet weak var cb3: Checkbox!

    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      cb1.delegate = self
      cb1.setCheckedImage(UIImage(named: "checked")!)
      cb1.setUncheckedImage(UIImage(named: "unchecked")!)
      
      cb2.delegate = self
      cb2.setCheckedImage(UIImage(named: "checked")!)
      cb2.setUncheckedImage(UIImage(named: "unchecked")!)
      
      cb3.delegate = self
      cb3.setCheckedImage(UIImage(named: "checked")!)
      cb3.setUncheckedImage(UIImage(named: "unchecked")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CheckboxDelegate {
  
  func canCheck()->Bool {
    return currentlyChecked < maxChecked
  }
  
  func checked(state: Bool, checkbox: Checkbox) {
    currentlyChecked += state ? 1 : -1
    print("\(currentlyChecked) checkboxes are checked")
  }
}

