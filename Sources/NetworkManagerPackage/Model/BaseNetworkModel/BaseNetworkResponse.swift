//
//  BaseNetworkResponse.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

struct BaseNetworkResponse<T: Codable> {
   let response: URLResponse?
   let data: T?
}
