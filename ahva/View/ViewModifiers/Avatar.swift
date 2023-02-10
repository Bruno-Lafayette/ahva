import Foundation
import SwiftUI

struct Avatar: Hashable{
    var name: String
    var style: String
    
    init(name: String, style: String) {
        self.name = name
        self.style = style
    }
    
    func fetch(){
        guard let url = URL(string: "https://api.dicebear.com/5.x/\(style)/png?seed=\(name)") else {return}
        let task = URLSession.shared.dataTask(with: url){data,response,error in
            guard let responseData = data else {return}
            print(responseData)
            if let responseString = String(data: responseData, encoding: .utf8){
                print(responseString)
            }
        }
        task.resume()
    }
}


