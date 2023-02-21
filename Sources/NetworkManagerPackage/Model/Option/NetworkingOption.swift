//
//  NetworkingOption.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


/// Networking Options defines baseUrl and such constant values
public struct NetworkingOption<T: Codable> {
   let baseUrl : String
   let headers : [String : String]? = NetworkManagerConstants.defaultHeader
   // Experimental
   var onRefresh : (() -> ())?=nil
   var onRefreshFail : (() -> ())?=nil
   var enableLogger : Bool
   let errorModel : T.Type?
   let timeoutDuration : Double?


   public init(
      baseUrl: String, onRefresh: ( () -> Void)?,
      onRefreshFail: ( () -> Void)?,
      enableLogger : Bool = false,
      errorModel : T.Type,
      timeoutDuration : Double?
   ) {
      self.baseUrl = baseUrl
      self.onRefresh = onRefresh
      self.onRefreshFail = onRefreshFail
      self.enableLogger = enableLogger
      self.errorModel = errorModel
      self.timeoutDuration = timeoutDuration ?? NetworkManagerConstants.timeoutDuration
   }

   public init(
      baseUrl: String, onRefresh: ( () -> Void)?,
      onRefreshFail: ( () -> Void)?,
      enableLogger : Bool = false,
      timeoutDuration : Double?
   ) {
      self.baseUrl = baseUrl
      self.onRefresh = onRefresh
      self.onRefreshFail = onRefreshFail
      self.enableLogger = enableLogger
      self.errorModel = nil
      self.timeoutDuration = timeoutDuration ?? NetworkManagerConstants.timeoutDuration
   }
}
