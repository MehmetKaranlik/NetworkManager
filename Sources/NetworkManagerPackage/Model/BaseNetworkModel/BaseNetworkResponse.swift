//
//  BaseNetworkResponse.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

public struct BaseNetworkResponse<T: Codable> {
   public let response: URLResponse?
   public let data: T?
}
