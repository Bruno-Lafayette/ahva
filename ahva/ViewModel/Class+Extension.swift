//
//  Class+Extension.swift
//  ahva
//
//  Created by Bruno Lafayette on 10/02/23.
//

import Foundation

extension Array{
    func getElementAtIndex(_ index: Int)-> Element?{
        if index < self.endIndex{
            return self[index]
        }
        return nil
    }
}

class Avatar{
    
    private var urlAvatar = "https://api.dicebear.com/5.x/"
    private var dictionary: [String:Any] = [:]
    
    func requestImage (request: toGenerate,_ seedName: String,_ style: String,_ key: String ,_ value: String) -> String{
        switch request {
        case .new:
            return createAvatar(style, seedName)
        case .customize:
            if key != "nil" || value != ""{
                return createCustomAvatar(style, seedName, key, value)
            }
            print("ENTREI AQUI")
            return "https://api.dicebear.com/5.x/\(style)/png?seed=\(seedName)"
        }
    }
    
    private func createAvatar(_ style: String,_ value: String) -> String{
        urlAvatar = "https://api.dicebear.com/5.x/\(style)/png?seed=\(value)"
        return urlAvatar
    }
    
    func createCustomAvatar(_ style: String,_ nameSeed: String,_ key: String,_ value: String) -> String{
        urlAvatar = "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)"
        dictionary.updateValue(value, forKey: key)
        if value != "" {
            for indice in dictionary{
                urlAvatar += "&\(indice.key)=\(indice.value)"
            }
        }
        print(urlAvatar)
        return urlAvatar
    }
    
}


enum toGenerate {
    case new, customize
}

