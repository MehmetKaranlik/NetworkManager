//
//  NetworkAlternativeConstants.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

@available(iOS 14.0,*)
struct NetworkManagerConstants {
   /// Default URLRequest Header that implements Content-Type : JSON and Accept : JSON
   static let defaultHeader : [String: String] =  [
      ContentTypeAlternative.json.toContentType().0 : ContentTypeAlternative.json.toContentType().1,
      AcceptTypeAlternative.json.toAcceptType().0 : AcceptTypeAlternative.json.toAcceptType().1
   ]

   static let timeoutDuration : Double = 15
   
}
