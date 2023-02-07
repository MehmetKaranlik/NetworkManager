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
   associatedtype Z: Codable
   /// Networking options variable that holds configuration for defined network manager
   var options: NetworkingOption<Z> { get set }

   /// Main networking feature
   /// - Parameters:
   ///   - path: target endpoing that will be append to baseURL defined in NetworkingOption
   ///   - parseModel: target model that responses data would be converted, must conform to Codable
   ///   - requestType: HTTP Method of request
   ///   - body: data that will convertod to type based bodyType that defined, if requestType is RequestType.Get its ignored.
   ///   - bodyType: Body type that defines how body should be processed defaults to JSON
   ///   - queryParameters: A dictionary that represents query items of url, recommended to use this
   /// - Returns: BaseNetworkType with configured error and request model **ONLY ONE OF THEM CAN BE NON-NIL AT SINGLE MOMENT**
   func send<T: Codable>(
      _ path: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: (any Encodable)?,
      bodyType: BodyType,
      queryParameters: [String: String]?
   ) async -> BaseNetworkResponse<T, Z>
   /// Creates request headers from options if not provided it uses default headers
   func headerGenerator(request: inout URLRequest)
   /// Json parses the body if provided if not it returns in the first line
   func bodyGenerator(request: inout URLRequest, body: (any Encodable)?, bodyType: BodyType)
   /// Appends query to URL if provided. If its nil it returns in the first line
   func queryGenerator(requestURL: inout URL, queryParameters: [String: String?]?)
   ///  Manages actual network call on internet returns Data and URLResponse
   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?)
   ///  Handles decoding data returned handleRequest function
   func decodeData<T: Codable, Z: Codable>(
      data: Data, parseModel: T.Type, errorModel: Z.Type, isError: Bool
   ) -> (T?, Z?)
}

// Overriding implementations
extension INetworkManager {
   func headerGenerator(request: inout URLRequest) {
      request.allHTTPHeaderFields = options.headers
   }

   func bodyGenerator(request: inout URLRequest, body: (any Encodable)?, bodyType: BodyType) {
      guard body != nil else { return }
      if bodyType == .JSON {
         let data = parseJsonBody(body: body)
         request.httpBody = data
      }
   }

   func queryGenerator(requestURL: inout URL, queryParameters: [String: String?]?) {
      guard queryParameters != nil else { return }
      queryParameters!.forEach {
         requestURL.appendQueryItem(
            name: $0, value: $1?.description
         )
      }
   }

   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?) {
      do {
         let (data, response) = try await URLSession.shared.data(for: request)
         return (data, response)
      } catch let e {
         print("⚠️", "Something went wrong data fetching : \(e)")
         return (nil, nil)
      }
   }

   func decodeData<T: Codable, Z: Codable>(
      data: Data, parseModel: T.Type,
      errorModel: Z.Type, isError: Bool = false
   ) -> (T?, Z?) {

      var error: Z?; var resultData: T?

      do {

         if isError {
            error = try JSONDecoder().decode(errorModel.self, from: data)
         } else {
            resultData = try JSONDecoder().decode(parseModel.self, from: data)
         }

         return (resultData, error)
      } catch let e {
         print("⚠️", "Something went wrong with JSON Parsing : \(e)")
         return (resultData, error)
      }
   }

   private func parseJsonBody(body: (any Encodable)?) -> Data? {
      guard let body else { return nil }
      let jsonData = converEncodableToJson(body)
      return jsonData
   }

   private func converEncodableToJson(_ encodable: Encodable) -> Data? {
      do {
         let json = try JSONEncoder().encode(encodable)
         return json
      } catch let e {
         print("⚠️", "Something went wrong with converting body to json : \(e)")
         return nil
      }
   }
}
