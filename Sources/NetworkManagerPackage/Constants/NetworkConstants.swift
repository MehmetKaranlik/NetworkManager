//
//  NetworkAlternativeConstants.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


struct NetworkAlternativeConstants {
   static let defaultHeader : [String: String] =  [
      ContentTypeAlternative.json.toContentType().0 : ContentTypeAlternative.json.toContentType().1,
      AcceptTypeAlternative.json.toAcceptType().0 : AcceptTypeAlternative.json.toAcceptType().1
   ]
   
}
