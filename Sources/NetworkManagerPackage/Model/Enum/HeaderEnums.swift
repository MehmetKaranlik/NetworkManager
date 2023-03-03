//
//  ContentTypeAlternative.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


let CONTENT_TYPE = "Content-Type"
let ACCEPT = "Accept"

@available(iOS 14.0,*)
public enum ContentTypeAlternative : String {
   case json = "application/json"
   case multiform = "multipart/form-data"
}

@available(iOS 14.0,*)
public enum AcceptTypeAlternative : String {
   case wildcard = "*"
   case json = "application/json"
   case octetStram = "application/octet-stream"
}

@available(iOS 14.0,*)
public extension ContentTypeAlternative {
   func toContentType() -> (String, String) {
      return (CONTENT_TYPE,self.rawValue)
   }
}

@available(iOS 14.0,*)
public extension AcceptTypeAlternative {
   func toAcceptType() -> (String,String) {
      return (ACCEPT , self.rawValue)
   }
}


