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
    private var nameSeed: String?
    private var seedDefault: String
    private var dictionaryStyle: [String: Any]
    
    init(values: [String], style: String, key: String, nameSeed: String, seedDefault: String, dictionaryStyle: [String : Any]) {
        self.values = values
        self.style = style
        self.key = key
        self.nameSeed = nameSeed
        self.seedDefault = seedDefault
        self.dictionaryStyle = dictionaryStyle
    }
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(values, id: \.self) { value in
                    
                    Button {
                        
                    } label: {
                        StyleCell(title: value, imageURL: "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed ?? seedDefault)&\(key)=\(value)")

                    }

                }
            }
        }
    }
}
