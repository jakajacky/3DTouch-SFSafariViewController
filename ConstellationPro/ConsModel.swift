//
//  ConsModel.swift
//  ConstellationPro
//
//  Created by Xiaoqiang Zhang on 16/1/25.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class ConsModel: NSObject {

  var name: String?
  var datetime: String?
  var color: String?
  var number: String?
  var QFriend: String?
  var all: String?
  var health: String?
  var work: String?
  var love: String?
  var money: String?
  var summary: String?
  
  
  override init() {
    super.init()
  }
  
  func initWithDictionary(dictionary: [String: AnyObject]) -> ConsModel{
    self.setValuesForKeysWithDictionary(dictionary)
    
    return self
  }

  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 165
  }
  
  override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    print(key)
  }
}
