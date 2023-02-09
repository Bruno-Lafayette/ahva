//
//  CreateAvatar.swift
//  ahva
//
//  Created by Bruno Lafayette on 08/02/23.
//

import SwiftUI

struct AvatarView: View {
    
    var style: String
    var seed: String
    var option: String
    
    init(_ style: String, _ option: String ,_ seed: String) {
        self.style = style
        self.seed = seed
        self.option = option
    }
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: createAvatar(style, option, seed)))
                .padding()
        }
        Spacer()
    }
    
}

extension AvatarView{
    private func createAvatar(_ style: String,_ option: String ,_ name: String) -> String{
        let urlRequest = "https://api.dicebear.com/5.x/\(style)/png?\(option)=\(name)"
        return urlRequest
    }
}
