//
//  EditAvatarView.swift
//  ahva
//
//  Created by Bruno Lafayette on 08/02/23.
//

import SwiftUI

struct EditAvatarView: View {
    
    @State var name: String?
    @State var image: UIImage?
    var option: String
    var style: String
    var seedDefault: String
    
    
    init(style: String, seedDefault: String, option: String) {
        self.style = style
        self.seedDefault = seedDefault
        self.option = option
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                AvatarView(style, option, name ?? seedDefault)
                
                TextField("Digite o nome do avatar", text: $name.bound)
                
                Spacer()
                    .toolbar {
                        Button {
                            Task{
                                self.image = try await ImageModel.download("https://api.dicebear.com/5.x/\(style)/png?\(option)=\(name ?? seedDefault)")
                                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)

                            }
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                    }
            }
        }
    }
}




extension Optional where Wrapped == String {
    var _bound: String?{
        get {
            return self
        }
        set{
            self = newValue
        }
    }
    public var bound: String{
        get {
            return _bound ?? ""
        }
        set{
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}



//struct EditAvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditAvatarView()
//    }
//}
