//
//  CreateAvatar.swift
//  ahva
//
//  Created by Bruno Lafayette on 08/02/23.
//

import SwiftUI

struct AvatarGenerator: View {
    
    private var typeRequest: toGenerate
    @State private var dictionary: [String:Any]?
    @State private var style: String
    @State private var chave: String?
    private var value: String?
    private var seedName: String
    private var error = "nil"
    
    init(typeRequest: toGenerate,_ dictionary: [String : Any]? = nil,_ style: String,_ chave: String? = nil,_ value: String? = nil,_ seedName: String) {
        self.typeRequest = typeRequest
        self.dictionary = dictionary
        self.style = style
        self.chave = chave
        self.value = value
        self.seedName = seedName
    }
    
    var body: some View{
        HStack{
            
            AsyncImage(url: URL(string: requestImage(request: typeRequest, dictionary ?? [:], seedName, style, chave ?? error, value ?? error)))
                .padding()

        }
    }
    
}

extension AvatarGenerator{
    private func requestImage (request: toGenerate,_ dictionary: [String:Any],_ seedName: String,_ style: String,_ chave: String ,_ value: String) -> String{
        switch request {
        case .new:
            return createAvatar(style, seedName)
        case .customize:
            var auxDictionary = dictionary
            print("AGORA VAI?", chave)
            print("AGORA VAI?", value)
            return createCustomAvatar(&auxDictionary, style, seedName, chave, value)
        }
    }
    
    private func createAvatar(_ style: String,_ value: String) -> String{
        let urlRequest = "https://api.dicebear.com/5.x/\(style)/png?seed=\(value)"
        return urlRequest
    }
    
    func createCustomAvatar(_ dictionaryStyles: inout [String:Any],_ style: String,_ nameSeed: String,_ key: String?,_ value: String?) -> String{
        var url = "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)"
        if key != "nil" && value != "nil"{
            let updatedDictionary = createListEdit(&dictionaryStyles, key!, value!)
            for indice in updatedDictionary{
                
                url += "&\(indice.key)=\(indice.value)"
            }
        }
        print(url)
        return url
    }

    func createListEdit(_ dictionaryStyles: inout [String: Any],_ key: String, _ value: String) -> [String:Any]{
        for indice in dictionaryStyles{
            print(indice.key)
            if key == indice.key {
                dictionaryStyles[key] = value
            } else {
                dictionaryStyles = [key:value]
            }
        }
        return dictionaryStyles
    }
    
}


enum toGenerate {
    case new, customize
}
