//
//  ViewController.swift
//  ConstellationPro
//
//  Created by Xiaoqiang Zhang on 16/1/21.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import Dropper
import Cartography
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet var openDroperButton: UIButton!

  @IBOutlet var consRangeButton: UIButton!
  
  @IBOutlet var tableView: UITableView!
  
  var button            = UIButton()// 3D Touch 按钮

  var button1           = UIButton()// SFSafariViewController的使用

  var constellEN:String = ""        // 记录星座的英文

  var dicCons           = [String: AnyObject]()
  
  let drop: Dropper = Dropper(width: 110,
                             height: UIScreen.mainScreen().bounds.height - 70)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.initSubViews()

    // 注册3D Touch
    self.registerForPreviewingWithDelegate(self, sourceView: self.view)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  /**
   初始化子控件
   */
  func initSubViews() {
    constrain(openDroperButton) { (button) -> () in
      button.top == (button.superview?.top)! + 100
      button.left == (button.superview?.left)! + 20
    }
    
    constrain(openDroperButton, consRangeButton) { (button1, button2) -> () in
      button1.centerY == button2.centerY
      button2.right == (button2.superview?.right)! - 20
    }
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    self.tableView.rowHeight = 165
    
    // 各个灰色按钮
    button.backgroundColor = UIColor.grayColor()
    button.clipsToBounds = true
    button.layer.cornerRadius = 5
    button.setTitle("Safari预览", forState: UIControlState.Normal)
    self.view.addSubview(button)
    constrain(button) { (button) -> () in
      button.bottom == (button.superview?.bottom)! - 10
      button.width  == (button.superview?.width)! - 10
      button.left   == (button.superview?.left)! + 5
      button.height == 50
    }
    
    button1.backgroundColor = UIColor.grayColor()
    button1.clipsToBounds = true
    button1.layer.cornerRadius = 5
    button1.setTitle("Safari打开", forState: UIControlState.Normal)
    button1.addTarget(self, action: "openWithSafari", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button1)
    constrain(button, button1) { (button, button1) -> () in
      button1.bottom == button.top - 10
      button1.width  == button.width
      button1.left   == button.left
      button1.height == 50
    }
    
  }
  
  /**
   选择星座
   :param: sender UIButton
   */
  @IBAction func openDroper(sender: AnyObject) {

    drop.frame = CGRectMake(drop.frame.origin.x, drop.frame.origin.y, 110, drop.frame.size.height)
    if drop.status == .Hidden {
      drop.items = ["白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座", "天蝎座", "射手座", "摩羯座", "水瓶座", "双鱼座"]
      drop.theme = Dropper.Themes.White
      drop.delegate = self
      drop.cornerRadius = 3
      drop.showWithAnimation(0.5, options: Dropper.Alignment.Left, button: openDroperButton)
    }
    else {
      drop.hideWithAnimation(0.3)
    }
  }
  
  /**
   选择日期
   :param: sender UIButton
   */
  @IBAction func chooseRange(sender: AnyObject) {
    drop.frame = CGRectMake(drop.frame.origin.x, drop.frame.origin.y, 62, drop.frame.size.height)
    if drop.status == .Hidden {
      drop.items = ["今天", "明天"]
      drop.theme = Dropper.Themes.White
      drop.delegate = self
      drop.cornerRadius = 3
      drop.showWithAnimation(0.5, options: Dropper.Alignment.Left, button: consRangeButton)
    }
    else {
      drop.hideWithAnimation(0.3)
    }
  }
  
  /**
   查询
   :param: sender UIButton
   */
  @IBAction func searchCons(sender: AnyObject) {
    let name: String = (openDroperButton.titleLabel?.text)!
    var range: String = (consRangeButton.titleLabel?.text)!
    switch range {
    case "今天":
      range = "today"
    case "明天":
      range = "tomorrow"
    case "本周":
      range = "week"
    case "下周":
      range = "nextweek"
    case "本月":
      range = "month"
    case "今年":
      range = "year"
    default: break
    }
    
    switch name {
      case "白羊座":
        constellEN = "Aries/"
      case "金牛座":
        constellEN = "Taurus/"
      case "双子座":
        constellEN = "Gemini/"
      case "巨蟹座":
        constellEN = "Cancer/"
      case "狮子座":
        constellEN = "Leo/"
      case "处女座":
        constellEN = "Virgo/"
      case "天秤座":
        constellEN = "Libra/"
      case "天蝎座":
        constellEN = "Scorpio/"
      case "射手座":
        constellEN = "Sagittarius/"
      case "摩羯座":
        constellEN = "Capricorn/"
      case "水瓶座":
        constellEN = "Aquarius/"
      case "双鱼座":
        constellEN = "Pisces/"
      default:
        constellEN = ""
    }
    
    var string = "http://web.juhe.cn:8080/constellation/getAll?"
    string.appendContentsOf("consName=\(name)&type=\(range)&key=2bb1f3604d43616e6e063a53b1c48616")
    string = string.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
    let request = HttpRequest()
    request.requestGetHttpWithURL(url: string) { (data) -> Void in
      
      do {
        let dic = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
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

  // button target
  func openWithSafari() {
    // SFSafariViewController展示url内容的预览VC
    let pre = SFSafariViewController(URL: NSURL(string:
      constellEN == "" ? "http://www.xzw.com/astro/" : "http://www.xzw.com/astro/".stringByAppendingFormat(constellEN))!)
    self .presentViewController(pre, animated: true) { () -> Void in
      
    }
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
    if cell != nil {
      
    }
    else {
      cell = ConsDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ce")
    }
    if (self.dicCons["name"] != nil) {
      let conM = ConsModel.init().initWithDictionary(self.dicCons)
      print(conM.datetime)
      cell!.Model = conM
      tableView.rowHeight = (cell?.getHeight())!
    }
    return cell!
  }
}

extension ViewController: DropperDelegate, UIViewControllerPreviewingDelegate, SFSafariViewControllerDelegate{
  
  /**
   DropperDelegate
   */
  func DropperSelectedRow(path: NSIndexPath, contents: String) {
    print(contents)
    
    if contents.characters.count == 2 {
      consRangeButton.titleLabel?.text = contents
    }
    else {
      openDroperButton.titleLabel?.text = contents
    }
  }
  
  /**
   UIViewControllerPreviewingDelegate  peek & pop
  */
  func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    
    // SFSafariViewController展示url内容的预览VC
    
    let pre = SFViewController(URL: NSURL(string:
      constellEN == "" ? "http://www.xzw.com/astro/" : "http://www.xzw.com/astro/".stringByAppendingFormat(constellEN))!,
      entersReaderIfAvailable: true)
    pre.constellEN = "http://www.xzw.com/astro/".stringByAppendingFormat(constellEN)
    
    /* // 普通自定义预览VC
    let mains = UIStoryboard(name: "Main", bundle: nil)
    let pre = mains.instantiateViewControllerWithIdentifier("preVC")
    */
    
    // 预览VC的大小
    pre.preferredContentSize = CGSizeMake(0, 670)
    
    // peek后的非模糊部分的frame
    let rect = CGRectMake(0, button.frame.origin.y, self.view.frame.size.width - 20, 50)
    previewingContext.sourceRect = rect
    
    return CGRectContainsPoint(button.frame, location) ? pre : nil
  }
  
  
  func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
    self.showViewController(viewControllerToCommit, sender: self)
  }
  
  /**
  *  SFSafariViewControllerDelegate  点击'Done' 关闭SFSafariViewController
  */
  func safariViewControllerDidFinish(controller: SFSafariViewController) {
    controller .dismissViewControllerAnimated(true) { () -> Void in
      
    }
  }
  
}
