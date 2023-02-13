import SwiftUI

struct AvatarView: View {
    
    let avatar = Avatar()
    @State var nameSeed: String?
    @State var image: UIImage?
    @State private var showSavedAlert: Bool = false
    @State private var dictionaryStyle: [String:Any]? = [:]
    private var style: String
    private var seedDefault: String
    private var error = "nil"
    
    
    init(_ style: String, _ seedDefault: String) {
        self.style = style
        self.seedDefault = seedDefault
    }
    
    var body: some View {
        VStack{

            
            AvatarGenerator(url: avatar.requestImage(request: .new, nameSeed ?? seedDefault, style, error, error))
            
            TextField("Digite o nome do avatar", text: $nameSeed.bound)
                .padding()
        
            NavigationLink {
                EditAvatarView(style: style, seedDefault: nameSeed ?? seedDefault, dictionaryStyle: dictionaryStyle ?? [:], avatar: avatar)
            } label: {
                Text("Editar")
            }
            
            .task {
                dictionaryStyle = await RequestOptionsAvatar().createOptions(style)
            }

            Spacer()
            Button {
                Task{
                    self.image = try await ImageModel.download("https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed ?? seedDefault)")
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
