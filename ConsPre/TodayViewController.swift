//
//  TodayViewController.swift
//  ConsPre
//
//  Created by Xiaoqiang Zhang on 16/1/25.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  
  var Model: ConsModel!
  
  var dicCons = [String: AnyObject]()
  var dic = [String: AnyObject]()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.rowHeight = 165
    
    
  }
  
  func refresh() {
    print("abc")
  }
  
//  override func viewDidAppear(animated: Bool) {
//    self.tableView.reloadData()
//  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
      // Perform any setup necessary in order to update the view.

      // If an error is encountered, use NCUpdateResult.Failed
      // If there's no update required, use NCUpdateResult.NoData
      // If there's an update, use NCUpdateResult.NewData

      completionHandler(NCUpdateResult.NewData)
  }
  
  func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0)
  }
  
  override func viewDidAppear(animated: Bool) {
    self.tableView.reloadData()
  }
  
  // UITableViewDelegate&DataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("ce") as? ConsDetailTableViewCell
    if cell == nil {
      cell = ConsDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ce")
    }
    
    let defaul = NSUserDefaults.init(suiteName: "group.ideabinder.SFAEssentials")
    let di = defaul!.objectForKey("consDic") as! NSDictionary
    for (key, value) in di {
      self.dic.updateValue(value, forKey: key as! String)
      print("\(key)+\(value)")
    }

//    self.dic.updateValue((self.dic["number"]?.stringValue)!, forKey: "number")
//    dic.setValue((dic["number"]?.stringValue)!, forKey: "number")
    
    print(self.dic)
    let cons = ConsModel.init().initWithDictionary(self.dic)
    cell!.Model = cons
    
    tableView.rowHeight = (cell?.getHeight())!
    
    return cell!
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let defaul = NSUserDefaults.init(suiteName: "group.ideabinder.SFAEssentials")
    let dic = defaul!.objectForKey("consDic") as? NSDictionary
    let name = dic!["name"]
    var string = "http://web.juhe.cn:8080/constellation/getAll?"
    string.appendContentsOf("consName=\(name!)&type=tomorrow&key=2bb1f3604d43616e6e063a53b1c48616")
    string = string.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
    let request = HttpRequest()
    request.requestGetHttpWithURL(url: string) { (data) -> Void in
      
      do {
        let dic = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        print(dic)
        for (key, value) in dic {
          self.dicCons.updateValue(value, forKey: key as! String)
        }
        self.dicCons.updateValue((self.dicCons["number"]?.stringValue)!, forKey: "number")
        
        // 与widget共享数据
        let defaul = NSUserDefaults.init(suiteName: "group.ideabinder.SFAEssentials")
        defaul!.setObject(self.dicCons, forKey: "consDic")
        
        // 回主线程刷新table
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.tableView .reloadData()
        })
      }
      catch {
        print(error)
      }
    }
  }
  
}
