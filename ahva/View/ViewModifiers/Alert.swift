//
//  AlertConnection.swift
//  ahva
//
//  Created by Bruno Lafayette on 16/02/23.
//

import SwiftUI

struct Alert: View {
    
    var imageText: String
    var title: String
    var text: String
    
    init(imageText: String, title: String, text: String) {
        self.imageText = imageText
        self.title = title
        self.text = text
    }
    
    var body: some View {
        VStack{
            Image(systemName: imageText)
                .padding()
            Text(title)
                .padding()
            Text(text)
        }
    }
}
