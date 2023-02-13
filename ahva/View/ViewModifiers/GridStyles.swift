//
//  GridStyles.swift
//  ahva
//
//  Created by Bruno Lafayette on 10/02/23.
//

import SwiftUI

struct GridStyles: View {
    @Binding var valueSelect: String
    private let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    private var values: [String]
    private var style: String
    private var key: String
    private var nameSeed: String
    
    init(valueSelect: Binding<String>, values: [String], style: String, key: String?, nameSeed: String) {
        self._valueSelect = valueSelect
        self.values = values
        self.style = style
        self.key = key ?? "erro"
        self.nameSeed = nameSeed
    }
    var body: some View {
        if key != "erro"{
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(values, id: \.self) { value in
                        Button {
                            valueSelect = value
                        } label: {
                            StyleCell(title: value, imageURL: "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)&\(key)=\(value)")
                            
                        }
                        
                    }
                }
            }
        }
    }
}
