//
//  ContentTypeAlternative.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


let CONTENT_TYPE = "Content-Type"
let ACCEPT = "Accept"


public enum ContentTypeAlternative : String {
   case json = "application/json"
   case multiform = "multipart/form-data"
}

public enum AcceptTypeAlternative : String {
   case wildcard = "*"
   case json = "application/json"
   case octetStram = "application/octet-stream"
}

public extension ContentTypeAlternative {
   func toContentType() -> (String, String) {
      return (CONTENT_TYPE,self.rawValue)
   }
}


public extension AcceptTypeAlternative {
   func toAcceptType() -> (String,String) {
      return (ACCEPT , self.rawValue)
   }
}


