//
//  RequestType.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

/// Recognized HTTP Request types if not Provided Default value is
@available(iOS 14.0,*)
public enum RequestType: String {
   case GET
   case POST
   case DELETE
   case PUT
}
