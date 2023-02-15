import Foundation
import SwiftUI

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



