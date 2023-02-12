import SwiftUI

struct AvatarView: View {
    
    @State var nameSeed: String?
    @State var image: UIImage?
    @State private var showSavedAlert: Bool = false
    @State private var dictionaryStyle: [String:Any]? = [:]
    private var key: String
    private var style: String
    private var seedDefault: String
    
    
    init(_ style: String,_ key: String, _ seedDefault: String) {
        self.style = style
        self.seedDefault = seedDefault
        self.key = key
    }
    
    var body: some View {
        VStack{
            AvatarGenerator(typeRequest: .new, style: style, seedName: nameSeed ?? seedDefault)
            
            TextField("Digite o nome do avatar", text: $nameSeed.bound)
                .padding()
        
            NavigationLink {
                EditAvatarView(key: key, style: style, seedDefault: nameSeed ?? seedDefault, dictionaryStyle: editar(dictionario: dictionaryStyle ?? [:]))
            } label: {
                Text("Editar")
            }
            
            .task {
                dictionaryStyle = await RequestOptionsAvatar().createOptions(style)
            }

            Spacer()
            Button {
                Task{
                    self.image = try await ImageModel.download("https://api.dicebear.com/5.x/\(style)/png?\(key)=\(nameSeed ?? seedDefault)")
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
    
    func editar(dictionario: [String: Any])->[String:Any]{
        print("entrei aqui GAROTOOO",dictionario)
        return dictionario
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
