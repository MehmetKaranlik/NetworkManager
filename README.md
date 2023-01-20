# NetworkManagerPackage

Easy to use and integrate Swift 5 networking package (EARLY IN DEVELOPMENT)






```swift 

 var manager : NetworkManager = NetworkManager(
      options: NetworkingOption(
         baseUrl: "https://reqres.in",
         onRefresh: {}, onRefreshFail: {})
)


public func exampleGet() async {
    let response = await manager.send(
         "/api/users/2",
         parseModel: GetModel.self,
         requestType: .GET
      )
   print(response)
   }

   public func examplePost() async {
      let response = await manager.send(
         "/api/users",
           parseModel: PostModel.self,
         requestType: .POST,
         body: [
            "name": "morpheus",
             "job": "leader"]
      )
      print(response)
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
      print(response)
   }

   public func exampleDelete() async {
      let response = await manager.send(
         "/api/users/2",
         parseModel: PutModel.self,
         requestType: .DELETE
      )
      print(response)
   }


```

**Remaining Features to Implement**

https://github.com/MehmetKaranlik/NetworkManager/issues
