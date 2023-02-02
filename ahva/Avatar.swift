//
//  Request.swift
//  ahva
//
//  Created by Bruno Lafayette on 02/02/23.
//

import Foundation
import SwiftUI

class Avatar{
    var name: String
    var style: String
    
    init(name: String, style: String) {
        self.name = name
        self.style = style
    }
    
    func fetch(){
        guard let url = URL(string: "https://api.dicebear.com/5.x/\(style)/json?seed=\(name)") else {return}
        let task = URLSession.shared.dataTask(with: url){data,response,error in
            guard let responseData = data else {return}
            if let responseString = String(data: responseData, encoding: .utf8){
                print(responseString)
            }
            
        }
        print(task.resume())
        task.resume()
    }
}
