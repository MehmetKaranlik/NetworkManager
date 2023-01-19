//
//  NetworkingOption.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


struct NetworkingOptionAlternative {
   let baseUrl : String
   let headers : [String : String]? = NetworkAlternativeConstants.defaultHeader
   // Experimental
   let onRefresh : (() -> ())?
   let onRefreshFail : (() -> ())?
}
