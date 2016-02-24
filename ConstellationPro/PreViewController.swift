//
//  PreViewController.swift
//  ConstellationPro
//
//  Created by Xiaoqiang Zhang on 16/2/24.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class PreViewController: UIViewController {

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
        // viewController 就是预览的VC
      }
      
      return action
      
    }
    
    // 制作了几个action
    let action1 = previewActionForTitle("Default Action")
    let action2 = previewActionForTitle("Destructive Action", style: .Destructive)
    
    let subAction1 = previewActionForTitle("Sub Action 1")
    let subAction2 = previewActionForTitle("Sub Action 2")
    let groupedActions = UIPreviewActionGroup(title: "Sub Actions…", style: .Default, actions: [subAction1, subAction2] )
    
    return [action1, action2, groupedActions]
  }()

  // MARK: Preview actions
  
  override func previewActionItems() -> [UIPreviewActionItem] {
    return previewActions
  }
}
