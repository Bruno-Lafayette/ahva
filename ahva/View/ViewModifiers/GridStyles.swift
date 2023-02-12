//
//  GridStyles.swift
//  ahva
//
//  Created by Bruno Lafayette on 10/02/23.
//

import SwiftUI

struct GridStyles: View {
    private let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    private var values: [String]
    private var style: String
    private var key: String
    private var nameSeed: String
    
    init(_ style: String,_ nameSeed: String,_ key: String,_ values: [String]) {
        self.values = values
        self.nameSeed = nameSeed
        self.style = style
        self.key = key
    }
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(values, id: \.self) { value in
                    
                    Button {
                        
                    } label: {
                        StyleCell(title: value, imageURL: "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)&\(key)=\(value)")

                    }

                }
            }
        }
    }
}
