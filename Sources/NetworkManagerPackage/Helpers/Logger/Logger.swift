//
//  SwiftUIView.swift
//
//
//  Created by mehmet karanlık on 21.01.2023.
//

import Foundation

struct Logger {
   static let shared: Logger = .init()

   func logResponse(_ data: Data?, _ baseResponse: URLResponse?) {
      if !isDebug { return }
      guard let httpResponse = baseResponse as? HTTPURLResponse else { return }
      printSeparator(httpResponse.statusCode)
      var statusCode = httpResponse.statusCode.description
      var headers = httpResponse.allHeaderFields.description
      var mimeType = httpResponse.mimeType?.description
      var url = httpResponse.url?.absoluteString
      logKeyValue(key: LoggerTitles.url.rawValue, value: url == nil ? "nil" : url!.clear())
      logKeyValue(key: LoggerTitles.statusCode.rawValue, value: statusCode.clear())
      logKeyValue(key: LoggerTitles.headers.rawValue, value: headers.clear())
      logKeyValue(key: LoggerTitles.contentType.rawValue, value: mimeType?.clear() ?? "")
      logBody(data)
      printSeparator(httpResponse.statusCode)
   }

   private func logKeyValue(key: String, value: String) {
      print("\(key.uppercased()) : \(value) \n")
   }

   private func logBody(_ data: Data?) {
      if let data = data {
         logNSString(key: LoggerTitles.body.rawValue, value: data.prettyPrintedJSONString ?? "")
      }
   }

   func logNSString(key: String, value: NSString) {
      print("\(key.uppercased()) : \(value) \n")
   }

   let seperator: String = .init(repeating: "-", count: 20)

   func printSeparator(_ statusCode: Int) {
      if statusCode >= 200, statusCode < 300 {
         print("🍏" + seperator + "🍏")
      } else {
         print("🍎" + seperator + "🍎")
      }
   }

   var isDebug: Bool {
      #if DEBUG
      return true
      #else
      return false
      #endif
   }
}

private extension String {
   mutating func clear() -> String {
      var printable = self
      printable = printable.replacingOccurrences(of: "Optional", with: "")
      printable = printable.replacingOccurrences(of: "(", with: "")
      printable = printable.replacingOccurrences(of: ")", with: "")
      printable = printable.replacingOccurrences(of: "AnyHashable", with: "")
      return printable
   }
}

extension Data {
   var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
      guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

      return prettyPrintedString
   }
}

enum LoggerTitles: String {
   case url = "url"
   case statusCode = "status code"
   case headers = "headers"
   case contentType = "content-type"
   case body = "body"
}
