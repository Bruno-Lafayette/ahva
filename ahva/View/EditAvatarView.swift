import SwiftUI

struct EditAvatarView: View {
    
    @State var name: String?
    @State var image: UIImage?
    private var option: String
    private var style: String
    private var seedDefault: String
  
    init(name: String? = nil, image: UIImage? = nil, option: String, style: String, seedDefault: String) {
        self.name = name
        self.image = image
        self.option = option
        self.style = style
        self.seedDefault = seedDefault
    }
    
    var body: some View {
        VStack {
            AvatarGenerator(style, option, name ?? seedDefault)
            Spacer()
            OptionEditAvatar(type: style)
            Spacer()
            
        }
    }
}
