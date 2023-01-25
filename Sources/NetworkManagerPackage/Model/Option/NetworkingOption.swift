//
//  NetworkingOption.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


/// Networking Options defines baseUrl and such constant values
public struct NetworkingOption {
   let baseUrl : String
   let headers : [String : String]? = NetworkAlternativeConstants.defaultHeader
   // Experimental
   var onRefresh : (() -> ())?=nil
   var onRefreshFail : (() -> ())?=nil
   var enableLogger : Bool


   public init(
      baseUrl: String, onRefresh: ( () -> Void)?,
      onRefreshFail: ( () -> Void)?,
      enableLogger : Bool = false
   ) {
      self.baseUrl = baseUrl
      self.onRefresh = onRefresh
      self.onRefreshFail = onRefreshFail
      self.enableLogger = enableLogger
   }
}
