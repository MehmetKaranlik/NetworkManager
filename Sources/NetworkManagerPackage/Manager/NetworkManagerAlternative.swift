//
//  NetworkManagerAlternative.swift
//  snacks-demo
//
//  Created by mehmet karanlık on 19.01.2023.
//

import Foundation

// TODO: Hata constantları yazılır yönetilecek.
struct NetworkManagerAlternative: INetworkManagerAlternative {
   var options: NetworkingOptionAlternative

   func send<T>(
      _ path: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String: String]? = nil,
      bodyType: BodyType = .JSON,
      queryParameters: [String: String]? = nil
   ) async -> BaseNetworkResponse<T> where T: Decodable, T: Encodable {
      guard var url = URL(string: options.baseUrl + path) else { return BaseNetworkResponse<T>(response: nil, data: nil) }

      var request = URLRequest(url: url)

      request.httpMethod = requestType.rawValue

      queryGenerator(requestURL: &url, queryParameters: queryParameters)

      headerGenerator(request: &request)

      bodyGenerator(request: &request, body: body, bodyType: bodyType)

      let (data, response): (Data?, URLResponse?) = await handleRequest(request: request)

      guard let data else { print("Result : Data bos"); return BaseNetworkResponse<T>(response: nil, data: nil) }

      let decodedData = decodeData(data: data, parseModel: parseModel.self)

      return BaseNetworkResponse<T>(response: response, data: decodedData)
   }
}
