//
//  NetworkManagerAlternative.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

public struct NetworkManager<Z: Codable>: INetworkManager {
   var options: NetworkingOption<Z>

   public init(options: NetworkingOption<Z>) {
      self.options = options
   }

   public func send<T>(
      _ path: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: (any Encodable)? = nil,
      bodyType: BodyType = .JSON,
      queryParameters: [String: String]? = nil
   ) async -> BaseNetworkResponse<T, Z> where T: Codable, Z: Codable {
      guard var url = URL(string: options.baseUrl + path) else {
         return BaseNetworkResponse<T, Z>(response: nil, data: nil, error: nil)
      }

      var request = URLRequest(url: url)

      request.httpMethod = requestType.rawValue

      queryGenerator(requestURL: &url, queryParameters: queryParameters)

      headerGenerator(request: &request)

      bodyGenerator(request: &request, body: body, bodyType: bodyType)

      if options.enableLogger {
         Logger.shared.logRequest(request)
      }

      let (data, response): (Data?, URLResponse?) = await handleRequest(request: request)

      guard let data else { return BaseNetworkResponse<T, Z>(response: nil, data: nil, error: nil) }

      if options.enableLogger {
         Logger.shared.logResponse(data, response)
      }

      let decodedData = decodeData(data: data, parseModel: parseModel.self, errorModel: options.errorModel.self!)

      return BaseNetworkResponse<T, Z>(response: response, data: decodedData.0, error: decodedData.1)
   }
}
