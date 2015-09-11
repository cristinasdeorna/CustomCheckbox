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
  @IBOutlet weak var checkbox: Checkbox!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
      checkbox.setCheckedImage(UIImage(named: "checked")!)
      checkbox.setUncheckedImage(UIImage(named: "unchecked")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func pressedCheckbox(sender: AnyObject) {
    print("pressed the checkbox")
  }
}



