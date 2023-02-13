import SwiftUI

struct EditAvatarView: View {
    
    @State var nameSeed: String?
    @State var values: [String] = []
    @State var value: String = ""
    @State private var key: String?
    let avatar: Avatar
    private var dictionaryStyle: [String:Any]?
    private var style: String
    private var seedDefault: String
    private var error = "nil"
  
    init(key: String? = nil, style: String, seedDefault: String, nameSeed: String? = nil, image: UIImage? = nil, dictionaryStyle: [String:Any]?, avatar: Avatar ) {
        self.nameSeed = nameSeed
        self.key = key
        self.style = style
        self.seedDefault = seedDefault
        self.dictionaryStyle = dictionaryStyle
        self.avatar = avatar
    }
    
    var body: some View {
        
        AvatarGenerator(url: avatar.requestImage(request: .customize, nameSeed ?? seedDefault, style, key ?? error, value))
        OptionEditAvatar(dictionaryStyle, $values, $key)
        GridStyles(valueSelect: $value, values: values, style: style, key: key, nameSeed: nameSeed ?? seedDefault)
        Spacer()
        

    }
    
    func printValue(value: String?) -> String?{
        print(value ?? "nao recebeu nenhum valor")
        return value
    }
    
    
    
}

