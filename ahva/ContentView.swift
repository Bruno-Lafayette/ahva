//
//  ContentView.swift
//  ahva
//
//  Created by Bruno Lafayette on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack {
            
            
            Button("Enviar") {
                
                let avatar = Avatar(name: "Bruno", style: "big-smile")
                avatar.fetch()
                
                print("funciona")
            }
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
