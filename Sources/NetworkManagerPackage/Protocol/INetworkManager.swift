//
//  File.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

import Foundation


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

   func headerGenerator(request: inout URLRequest)
   func bodyGenerator(request: inout URLRequest, body: [String: Any?]?, bodyType:  BodyType)
   func queryGenerator(requestURL: inout URL, queryParameters: [String: String?]?)
   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?)
   func decodeData<T: Codable>(data: Data, parseModel: T.Type) -> T?
}

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
