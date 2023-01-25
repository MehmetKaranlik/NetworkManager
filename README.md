# NetworkManagerPackage

Easy to use and integrate Swift 5 networking package 






```swift 

 struct Service {
   var manager : NetworkManager = NetworkManager(
      options: NetworkingOption(
         baseUrl: "https://reqres.in",
         onRefresh: {}, onRefreshFail: {},
         enableLogger: true
         )
   )

public func exampleGet() async {
    let response = await manager.send(
         "/api/users/2",
         parseModel: GetModel.self,
         requestType: .GET,
         body: nil
      )

   }


// Supports passing custom type to body as long as it conforms Encodable

   public func examplePost() async {
      let response = await manager.send(
         "/api/users",
           parseModel: PostModel.self,
         requestType: .POST,
         body: PostRequestModel(name: "morpheus", job: "leader")

      )

   }

  

   public func examplePut() async {
      let response = await manager.send(
         "/api/users/2",
         parseModel: PutModel.self,
         requestType: .PUT,
         body: [
            "name": "morpheus",
            "job": "zion resident"
         ]
      )

   }

   public func exampleDelete() async {
      let response = await manager.send(
         "/api/users/2",
         parseModel: PutModel.self,
         requestType: .DELETE,
         body: nil
      )
 
   }
}

```
