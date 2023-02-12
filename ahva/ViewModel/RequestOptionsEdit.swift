import Foundation
import SwiftUI

//struct Avatar: Hashable{
//    var name: String
//    var style: String
//
//    init(name: String, style: String) {
//        self.name = name
//        self.style = style
//    }
//
//    func fetch(){
//        guard let url = URL(string: "https://api.dicebear.com/5.x/\(style)/png?seed=\(name)") else {return}
//        let task = URLSession.shared.dataTask(with: url){data,response,error in
//            guard let responseData = data else {return}
//            print(responseData)
//            if let responseString = String(data: responseData, encoding: .utf8){
//                print(responseString)
//            }
//        }
//        task.resume()
//    }
//}

class RequestOptionsAvatar {
    
    @State private var styles: [String:Any] = [:]
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    
    func createOptions(_ type: String) async -> [String:Any]?{
        do {
            let request = try HTTPRequestFactory(path: "https://databaseavatar.vercel.app/api/character/\(type)", method: .GET).createRequest()
            let (data, _) = try await request.send()
            
            if let data, let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
               return json
            }
            
        } catch URLError.badURL {
            self.invalidUrlError = true
        } catch {
            self.unkownError = true
        }
        
        return nil
        
    }
    
}



