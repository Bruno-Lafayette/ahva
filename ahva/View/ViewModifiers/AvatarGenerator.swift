//
//  CreateAvatar.swift
//  ahva
//
//  Created by Bruno Lafayette on 08/02/23.
//

import SwiftUI

struct AvatarGenerator: View {
    
    private var url: String
    init(url: String) {
        self.url = url
    }
    
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: url))
                .padding()
            
        }
    }
}

