//
//  File.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

import Foundation

/// Single handed manager protocol for network requests 
protocol INetworkManager {
   var options: NetworkingOption { get set }
   
   func send<T: Codable>(
      _ path: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String: Any]?,
      bodyType: BodyType,
      queryParameters: [String: String]?
   ) async -> BaseNetworkResponse<T>
   /// Creates request headers from options if not provided it uses default headers
   func headerGenerator(request: inout URLRequest)
   /// Json parses the body if provided if not it returns in the first line
   func bodyGenerator(request: inout URLRequest, body: [String: Any?]?, bodyType:  BodyType)
   /// Appends query to URL if provided. If its nil it returns in the first line
   func queryGenerator(requestURL: inout URL, queryParameters: [String: String?]?)
   ///  Manages actual network call on internet returns Data and URLResponse
   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?)
   ///  Handles decoding data returned handleRequest function
   func decodeData<T: Codable>(data: Data, parseModel: T.Type) -> T?
}


// Overriding implementations
extension INetworkManager {

   func headerGenerator(request: inout URLRequest) {
      request.allHTTPHeaderFields = self.options.headers
   }

   func bodyGenerator(request: inout URLRequest, body: [String: Any?]?, bodyType:  BodyType) {
      guard body != nil else { return }
      if bodyType == .JSON {
         let data = parseJsonBody(body: body)
         request.httpBody = data
      }
   }

   func queryGenerator(requestURL: inout URL, queryParameters: [String: String?]?) {
      guard queryParameters != nil else { return }
      queryParameters!.forEach { requestURL.appendQueryItem(name: $0, value: $1.debugDescription)}

   }

   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?) {
      do {
         let (data, response) = try await URLSession.shared.data(for: request)
         return (data, response)
      } catch let e {
         print("⚠️", "Something went wrong data fetching : \(e)")
         return (nil,nil)
      }
   }

   func decodeData<T: Codable>(data: Data, parseModel: T.Type) -> T? {
      do {
         let data = try JSONDecoder().decode(T.self, from: data)
         return data
      } catch let e {
         print("⚠️", "Something went wrong with JSON Parsing : \(e)")
         return nil
      }
   }


   private func parseJsonBody( body: [String: Any?]?) -> Data? {
      guard let body else { return nil }
      do {
         let data =  try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        return data
      }catch let e {
         print("⚠️", "Something went wrong with JSON Parsing Body : \(e)")
         return nil
      }
   }
}
