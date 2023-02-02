//
//  ContentView.swift
//  ahva
//
//  Created by Bruno Lafayette on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var name: String
    @State var style: String = ""
    @State var im: String = ""
    
    var body: some View {
        VStack {
            TextField("Digite o nome do seu avatar", text: $name)
            
//            Button("Enviar") {
//                let avatar = Avatar(name: "Well", style: "pixel-art")
//                avatar.fetch()
//
//                print("funciona")
//
//
//            }
            
            AsyncImage(url: URL(string: im))
            
        
            Button {
                self.im = imagem(name: name, style: "pixel-art")
                print("funciona")
            } label: {
                Text("Enviar")
            }

            
        }
    }
    
    func imagem(name: String, style: String) -> String{
        return "https://api.dicebear.com/5.x/\(style)/png?seed=\(name)"
//        AsyncImage(url: URL(string: "https://api.dicebear.com/5.x/\(style)/png?seed=\(name)"))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

