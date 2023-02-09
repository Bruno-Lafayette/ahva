//
//  OptionEditAvatar.swift
//  ahva
//
//  Created by Bruno Lafayette on 09/02/23.
//

import SwiftUI

struct OptionEditAvatar: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(0..<10) {option in
                    
                    Button {
                        print("funciono \(option)")
                    } label: {
                        ButtonStyle(text: "Item \(option)")
                    }
                }
            }
        }
    }
}


struct ButtonStyle: View{
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View{
        Text(text)
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(.red)
    }
}


//
//struct OptionEditAvatar_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionEditAvatar()
//    }
//}
