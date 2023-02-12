import SwiftUI

struct EditAvatarView: View {
    
    @State var nameSeed: String?
    private var dictionaryStyle: [String:Any]?
    private var key: String
    private var style: String
    private var seedDefault: String
  
    init(key: String, style: String, seedDefault: String, nameSeed: String? = nil, image: UIImage? = nil, dictionaryStyle: [String:Any]? ) {
        self.nameSeed = nameSeed
        self.key = key
        self.style = style
        self.seedDefault = seedDefault
        self.dictionaryStyle = dictionaryStyle
    }
    
    var body: some View {
        
        
        OptionEditAvatar(styles: dictionaryStyle, nameSeed: nameSeed ?? seedDefault, style: style)
        
        
//        VStack {
//
//
//
//
//
////            GridStyles(values: <#T##[String]#>, style: <#T##String#>, key: <#T##String#>, nameSeed: <#T##String#>, seedDefault: <#T##String#>, dictionaryStyle: <#T##[String : Any]#>)
//
//
////            AvatarGenerator(typeRequest: .customize, dictionary: dictionaryStyle, style: style, key: key, value: nil, seedName: nameSeed ?? seedDefault)
////            OptionEditAvatar(type: style, nameSeed: nameSeed ?? seedDefault, styles: dictionaryStyle ?? [:])
//            Spacer()
//
//        }
    }
    
    
//    func editar(dictionario: [String: Any])->[String:Any]{
//        print("AGORA ESTOU AQUIIIIII",dictionario)
//        return dictionario
//    }
    
    
}

