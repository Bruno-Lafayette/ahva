import SwiftUI

struct AvatarView: View {
    
    @State var name: String?
    @State var image: UIImage?
    @State private var showSavedAlert: Bool = false
    private var option: String
    private var style: String
    private var seedDefault: String
    
    
    init(style: String, seedDefault: String, option: String) {
        self.style = style
        self.seedDefault = seedDefault
        self.option = option
    }
    
    var body: some View {
        VStack{
            AvatarGenerator(style, option, name ?? seedDefault)
            
            TextField("Digite o nome do avatar", text: $name.bound)
                .padding()
            OptionEditAvatar(type: style)
            
            NavigationLink {
                EditAvatarView()
            } label: {
                Text("Editar")
            }


            
            Spacer()
            Button {
                Task{
                    self.image = try await ImageModel.download("https://api.dicebear.com/5.x/\(style)/png?\(option)=\(name ?? seedDefault)")
                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    withAnimation(.easeIn) {
                        self.showSavedAlert = true
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                            self.showSavedAlert = false
                        }
                    }
                }
            } label: {
                Text("Exportar")
            }
            
            Spacer()
            
        }
        .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .overlay(alignment: .center) {
                        Text("Imagem salva na galeria.")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 40)
                    .opacity(showSavedAlert ? 1 : 0)
        }
        .navigationTitle("Edit screen")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
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
