//
//  ConsDetailTableViewCell.swift
//  ConstellationPro
//
//  Created by Xiaoqiang Zhang on 16/1/25.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import Cartography


class ConsDetailTableViewCell: UITableViewCell {

  var consL: UILabel!
  var dateL: UILabel!
  var allL: UILabel!
  var colorL: UILabel!
  var numL: UILabel!
  var fitL: UILabel!
  var healL: UILabel!
  var workL: UILabel!
  var loveL: UILabel!
  var moneyL: UILabel!
  var summL: UILabel!

  // 通常这两个Model都是一起出现，计算属性和变量属性搭配使用
  var _Model: ConsModel!
  var Model: ConsModel! {
    get {
      return self._Model
    }
    
    set {
      
      self._Model = newValue
      consL.text = self._Model.name
      dateL.text = self._Model.datetime
      allL.text  = self._Model.all
      colorL.text = self._Model.color
      numL.text = self._Model.number
      fitL.text = self._Model.QFriend
      healL.text = self._Model.health
      workL.text = self._Model.work
      loveL.text = self._Model.love
      moneyL.text = self._Model.money
      summL.text = self._Model.summary
      // 计算出自适应高度，修改summL.height
      let size: CGSize = self.sizeOfRow(text: self._Model.summary!, font: 12)
      summL.frame.size.height = size.height
      summL.numberOfLines = 0
    }
  }
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // 初始化控件
  func initSubviews() {
    let cons = UILabel.init(frame: CGRectMake(8, 5, 40, 30))
    cons.text = "星座:"
    cons.font = UIFont.systemFontOfSize(12)
    self.addSubview(cons)

    self.consL = UILabel.init()
    consL.font = UIFont.systemFontOfSize(12)
    self.addSubview(consL)
    
    
    
    let date = UILabel.init()
    date.text = "日期:"
    date.font = UIFont.systemFontOfSize(12)
    self.addSubview(date)
    
    self.dateL = UILabel.init()
    dateL.font = UIFont.systemFontOfSize(12)
    self.addSubview(dateL)
    
    
    
    let color = UILabel.init()
    color.text = "幸运色:"
    color.font = UIFont.systemFontOfSize(12)
    self.addSubview(color)
    
    self.colorL = UILabel.init()
    colorL.font = UIFont.systemFontOfSize(12)
    self.addSubview(colorL)
    
    
    
    let num = UILabel.init()
    num.text = "幸运数:"
    num.font = UIFont.systemFontOfSize(12)
    self.addSubview(num)
    
    self.numL = UILabel.init()
    numL.font = UIFont.systemFontOfSize(12)
    self.addSubview(numL)
    
    
    
    constrain(cons, date, color, num) { (view1, view2, view3, view4) -> () in
      view1.top == (view1.superview?.top)! + 5
      view1.left == (view1.superview?.left)! + 8
      view1.width == 40
      view2.width == 40
      view3.width == 50
      view4.width == 50
      
      view1.centerY == view2.centerY
      view2.centerY == view3.centerY
      view3.bottom == view4.top - 5
      
      view1.right == view2.left - 50
      view2.right == view3.left - 110
      view3.left == view4.left
    }
    
    constrain(cons, consL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.width == 40
    }
    constrain(date, dateL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.width == 110
    }
    constrain(color, colorL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left + 5
      
      view2.width == 40
    }
    constrain(num, numL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left + 5
      
      view2.right == (view2.superview?.right)!
    }
    
    let fit = UILabel.init()
    fit.text = "速配星座:"
    fit.font = UIFont.systemFontOfSize(12)
    self.addSubview(fit)
    
    self.fitL = UILabel.init()
    fitL.font = UIFont.systemFontOfSize(12)
    self.addSubview(fitL)
    
    let all = UILabel.init()
    all.text = "综合:"
    all.font = UIFont.systemFontOfSize(12)
    self.addSubview(all)
    
    self.allL = UILabel.init()
    allL.font = UIFont.systemFontOfSize(12)
    self.addSubview(allL)
    
    let heal = UILabel.init()
    heal.text = "健康:"
    heal.font = UIFont.systemFontOfSize(12)
    self.addSubview(heal)
    
    self.healL = UILabel.init()
    healL.font = UIFont.systemFontOfSize(12)
    self.addSubview(healL)
    
    let work = UILabel.init()
    work.text = "工作:"
    work.font = UIFont.systemFontOfSize(12)
    self.addSubview(work)
    
    self.workL = UILabel.init()
    workL.font = UIFont.systemFontOfSize(12)
    self.addSubview(workL)
    
    let love = UILabel.init()
    love.text = "感情:"
    love.font = UIFont.systemFontOfSize(12)
    self.addSubview(love)
    
    self.loveL = UILabel.init()
    loveL.font = UIFont.systemFontOfSize(12)
    self.addSubview(loveL)
    
    let fortun = UILabel.init()
    fortun.text = "财运:"
    fortun.font = UIFont.systemFontOfSize(12)
    self.addSubview(fortun)
    
    self.moneyL = UILabel.init()
    moneyL.font = UIFont.systemFontOfSize(12)
    self.addSubview(moneyL)
    
    let summ = UILabel.init()
    summ.text = "总结:"
    summ.font = UIFont.systemFontOfSize(12)
    self.addSubview(summ)
    
    self.summL = UILabel.init()
    summL.font = UIFont.systemFontOfSize(12)
    self.addSubview(summL)
    
    constrain(fit, all, heal, work, cons) { (view1, view2, view3, view4, view5) -> () in
      view1.width  == 60
      view2.width  == 40
      view3.width  == 40
      view4.width  == 40
      
      view5.left == view1.left
      view1.left == view2.left
      view2.left == view3.left
      view3.left == view4.left
      
      view5.bottom == view1.top - 5
      view1.bottom == view2.top - 5
      view2.bottom == view3.top - 5
      view3.bottom == view4.top - 5
      
    }
    
    constrain(love, fortun, summ, work) { (view1, view2, view3, view4) -> () in
      view1.width  == 40
      view2.width  == 40
      view3.width  == 40
      
      view4.left == view1.left
      view1.left == view2.left
      view2.left == view3.left
      
      view4.bottom == view1.top - 5
      view1.bottom == view2.top - 5
      view2.bottom == view3.top - 5
      
    }
    
    constrain(fit, fitL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
  
      view2.right == (view2.superview?.right)! - 8
    }
    constrain(all, allL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.right == (view2.superview?.right)! - 8
    }
    constrain(heal, healL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.right == (view2.superview?.right)! - 8
    }
    constrain(work, workL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.right == (view2.superview?.right)! - 8
    }
    constrain(love, loveL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.right == (view2.superview?.right)! - 8
    }
    constrain(fortun, moneyL) { (view1, view2) -> () in
      view1.centerY == view2.centerY
      view1.right == view2.left
      
      view2.right == (view2.superview?.right)! - 8
    }
    constrain(summ, summL) { (view1, view2) -> () in
      view1.top == view2.top
      view1.right == view2.left
      
      view2.right == (view2.superview?.right)! - 8
    }
    
  }
  
  // 计算summary文字高度
  func sizeOfRow(text text: String, font: CGFloat) -> CGSize {
    let tex: NSString = NSString(CString: text.cStringUsingEncoding(NSUTF8StringEncoding)!,
      encoding: NSUTF8StringEncoding)!
    let wSize: CGSize = tex.boundingRectWithSize(CGSizeMake(self.frame.width - 56, CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(font)], context: nil).size

    return wSize
  }

  func getHeight() -> CGFloat {
    return 145 + summL.frame.size.height
  }

}
