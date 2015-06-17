//
//  SHTableViewController.swift
//  ExpandableTableView
//
//  Created by PhoneScreen on 6/16/15.
//  Copyright (c) 2015 sheth. All rights reserved.
//

import UIKit

class SHTableViewController: UITableViewController {
  
  let colorFamilies = ["Reds","Yellows","Greens","Blues"]
  
  let redFamilies = [ UIColor(red: 150, green: 40, blue: 27 ),
    UIColor(red: 242, green: 38, blue: 19 ),
    UIColor(red: 231, green: 76, blue: 60 ),
    UIColor(red: 210, green: 77, blue: 87 )]
  
  let YellowFamilies = [UIColor(red: 244, green: 188, blue: 63 ),
    UIColor(red: 247, green: 202, blue: 24 ),
    UIColor(red: 245, green: 215, blue: 110 )
  ]
  
  let GreenFamilies = [UIColor(red: 30, green: 130, blue: 76 ),
    UIColor(red: 0, green: 177, blue: 106 ),
    UIColor(red: 63, green: 195, blue: 128 ),
    UIColor(red: 42, green: 187, blue: 155 ),
    UIColor(red: 54, green: 215, blue: 183 )]
  
  let BluesFamilies = [
    UIColor(red: 30, green: 139, blue: 195 ),
    UIColor(red: 52, green: 152, blue: 219 ),
    UIColor(red: 89, green: 171, blue: 227 ),
    UIColor(red: 107, green: 185, blue: 240 ),
    UIColor(red: 34, green: 187, blue: 240 )]
  
  var colorFamilyMaps = [String:[UIColor]]()
  
  var stateArray = [Bool]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    colorFamilyMaps = [colorFamilies[0]:redFamilies,colorFamilies[1]:YellowFamilies,colorFamilies[2]:GreenFamilies,colorFamilies[3]:BluesFamilies]
    for family in colorFamilies {
      stateArray.append(false)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return colorFamilies.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = colorFamilyMaps[colorFamilies[section]]?.count {
      return count
    } else {
      return 1
    }
  }
  
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 50))
    headerView.tag = section;
    switch (section) {
    case 0:
      headerView.backgroundColor = UIColor.redColor()
    case 1:
      headerView.backgroundColor = UIColor.yellowColor()
    case 2:
      headerView.backgroundColor = UIColor.greenColor()
    case 3:
      headerView.backgroundColor = UIColor.blueColor()
    default:
      headerView.backgroundColor = UIColor.clearColor()
    }
    
    var title = UILabel(frame: CGRectMake(10, 10, headerView.frame.width - 70, 30))
    title.text = colorFamilies[section]
    title.textAlignment = NSTextAlignment.Left
    title.textColor = UIColor.darkTextColor()
    headerView.addSubview(title)
    
    var headerGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("sectionHeaderTapped:"))
    
    headerView.addGestureRecognizer(headerGesture)
    return headerView;
    
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if stateArray[indexPath.section] {
      return 50
    }
    return 0
  }
  
  override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.01
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
    
    if let colorFamily = colorFamilyMaps[colorFamilies[indexPath.section]]  {
      cell.backgroundColor = colorFamily[indexPath.row] as UIColor!
    }
    return cell
  }
  
  func sectionHeaderTapped(gestureRecognizer:UITapGestureRecognizer){
    if let section = gestureRecognizer.view?.tag {
      stateArray[section] = !stateArray[section]
      self.tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
  }

}

extension UIColor
{
  convenience init(red: Int, green: Int, blue: Int)
  {
    let newRed = CGFloat(red)/255
    let newGreen = CGFloat(green)/255
    let newBlue = CGFloat(blue)/255
    
    self.init(red: newRed, green: newGreen, blue: newBlue,alpha: 1.0)
  }
}
