//
//  SFViewController.swift
//  ConstellationPro
//
//  Created by Xiaoqiang Zhang on 16/2/24.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import SafariServices


class SFViewController: SFSafariViewController {

    var constellEN : String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  // Preview action items.
  // 计算属性？？
  lazy var previewActions: [UIPreviewActionItem] = {
    
    // 制造UIPreViewAction的函数
    func previewActionForTitle(title: String, style: UIPreviewActionStyle = .Default) -> UIPreviewAction {
      
      let action = UIPreviewAction(title: title, style: style) { previewAction, viewController in
        // previewAction 是被点击的Action； viewController 就是预览的VC
        // 这个闭包内，可以写点击Action的响应事件
        guard let detailViewController = viewController as? SFViewController,
          item = detailViewController.constellEN else { return }
        
        if previewAction.title == "复制链接" {
          // 访问剪切板
          let pasteB = UIPasteboard.generalPasteboard()
          pasteB.string = item
        }
      }
      
      return action
      
    }
    
    // 制作了几个action
    let action  = previewActionForTitle("分享")
    let action1 = previewActionForTitle("复制链接")
    let action2 = previewActionForTitle("Destructive Action", style: .Destructive)
    
    let subAction1 = previewActionForTitle("Sub Action 1")
    let subAction2 = previewActionForTitle("Sub Action 2")
    let groupedActions = UIPreviewActionGroup(title: "Sub Actions…", style: .Default, actions: [subAction1, subAction2] )
    
    return [action, action1, action2, groupedActions]
  }()
  
  // MARK: Preview actions
  
  override func previewActionItems() -> [UIPreviewActionItem] {
    return previewActions
  }

}
