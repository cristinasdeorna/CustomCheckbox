//
//  CategoryListViewController.swift
//  ios-app
//
//  Created by Miguel Saiz on 9/9/15.
//  Copyright © 2015 Soluciones GBH. All rights reserved.
//

import UIKit
import CustomCheckbox

protocol CategoryListDelegate {
  /**
  Called when dismissing the CategoryList, will return a list of the chosen categories
  */
  func choseCategories(categories: [Category], index: [Int])
}

class CategoryListViewController: UIViewController {
  var listView = CategoryListView()
  var delegate: CategoryListDelegate?
  private var categories: [Category]?
  private var currentlyChecked = 0
  private let maxChecked = 3
  private var checkedCategories = [Int]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    listView.controller = self
    listView.tableView.delegate = self
    listView.tableView.dataSource = self
    listView.tableView.allowsSelection = false
    view = listView
    
    
    APIWrapper.sharedInstance.listCategories(CategoriesRequest(language: nil)) { (categories: [Category]?, error: NSError?) -> Void in
      if error == nil {
        self.categories = categories
        self.listView.tableView.reloadData()
      } else {
        print("An error has occurred")
      }
    }
  }
  
  func setChecked(indices: [Int]) {
    checkedCategories = indices
    currentlyChecked = indices.count
    listView.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillDisappear(animated: Bool) {
    var result = [Category]()
    
    for i in checkedCategories {
      result.append(categories![i])
    }
    
    delegate?.choseCategories(result, index: checkedCategories)
  }
}

extension CategoryListViewController: UITableViewDataSource, UITableViewDelegate {
  // MARK: - Table view data source
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories?.count ?? 0
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 52
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as? CategoryTableViewCell
    
    if cell == nil {
      cell = CategoryTableViewCell(withCheckbox: true)
      cell?.loadCategory(categories![indexPath.row])
      cell?.checkbox?.delegate = self
      cell?.checkbox?.identifier = indexPath.row
      
      if checkedCategories.contains(indexPath.row) {
        cell?.checkbox?.setChecked()
      }
      
      let button = UIButton(type: UIButtonType.Custom)
      button.setImage(UIImage(named: "checkbox_off"), forState: UIControlState.Normal)
      cell!.accessoryView = button
    }
    
    return cell!
  }
}

extension CategoryListViewController: CheckboxDelegate {
  
  /**
  Ask the delegate wther this checkbox can be selected, if NO is returned, it will remain unchecked
  */
  func canCheck()->Bool {
    return currentlyChecked < maxChecked
  }
  
  /**
  Tells the delegate when a particular checkbox has been checked
  */
  func checked(state: Bool, checkbox: Checkbox) {
    currentlyChecked += state ? 1 : -1
    
    if state {
      checkedCategories.append(checkbox.identifier)
    } else {
      checkedCategories = checkedCategories.filter( {$0 != checkbox.identifier})
    }
  }
}