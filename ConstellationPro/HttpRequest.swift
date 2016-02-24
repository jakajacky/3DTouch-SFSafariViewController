//
//  HttpRequest.swift
//  ConstellationPro
//
//  Created by Xiaoqiang Zhang on 16/1/21.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import Foundation
import SwiftHTTP

class HttpRequest: NSObject {
  override init() {
    super.init()
  }
  func requestGetHttpWithURL(url url: String, complete:(NSData)->Void) {
    do {
      let opt = try HTTP.GET(url)
      opt.start({ (response) -> Void in
        if let err = response.error {
          print("error:\(err.localizedDescription)")
          return
        }
        print("opt finished:\(response.description)")
        complete(response.data)
      })
    } catch let error {
      print("got an error creating the request:\(error)")
    }
  }
  
}