//
//  AvatarCustomizer.swift
//  ahva
//
//  Created by Bruno Lafayette on 11/02/23.
//
//
//import SwiftUI
//
//struct AvatarCustomizer: View {
//
//    private var dictionaryStyles: [String:Any]
//
//    private var style: String
//    private var seed: String
//    private var nameSeed: String
//
//    init(dictionaryStyles: [String : Any],_ style: String,_ seed: String,_ nameSeed: String) {
//        self.dictionaryStyles = dictionaryStyles
//        self.style = style
//        self.seed = seed
//        self.nameSeed = nameSeed
//    }
//
//    var body: some View {
//        HStack{
//            AsyncImage(url: URL(string: editAvatar(dictionaryStyles, style, seed, nameSeed)))
//                .padding()
//        }
//    }
//}
//
//extension AvatarCustomizer{
//
//
//
//    func editAvatar(_ dictionaryStyles: [String:Any],_ style: String,_ seed: String,_ nameSeed: String) -> String{
//        var url = "https://api.dicebear.com/5.x/\(style)/png?\(seed)=\(nameSeed)"
//        for _ in dictionaryStyles{
//
//        }
//        return url
//    }
//}
