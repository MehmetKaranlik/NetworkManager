//
//  ContentTypeAlternative.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


let CONTENT_TYPE = "Content-Type"
let ACCEPT = "Accept"


enum ContentTypeAlternative : String {
   case json = "application/json"
   case multiform = "multipart/form-data"
}

enum AcceptTypeAlternative : String {
   case wildcard = "*"
   case json = "application/json"
   case octetStram = "application/octet-stream"
}

extension ContentTypeAlternative {
   func toContentType() -> (String, String) {
      return (CONTENT_TYPE,self.rawValue)
   }
}


extension AcceptTypeAlternative {
   func toAcceptType() -> (String,String) {
      return (ACCEPT , self.rawValue)
   }
}


