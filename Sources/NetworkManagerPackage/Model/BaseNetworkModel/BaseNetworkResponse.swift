//
//  BaseNetworkResponse.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation


@available(iOS 14.0,*)
/// Base Structre Carries Response and Decoded Data
public struct BaseNetworkResponse<T: Codable, Z: Codable> {
   public let response: URLResponse?
   public let data: T?
   public let error : Z?
}
