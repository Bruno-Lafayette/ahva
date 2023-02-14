import SwiftUI

struct AvatarView: View {
    
    let avatar = Avatar()
    @State var nameSeed: String?
    @State var image: UIImage?
    @State private var dictionaryStyle: [String:Any]? = [:]
    @State private var showSavedAlert = false
    @State private var showActionSheet = false
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
                .frame(width: 300, height: 49, alignment: .center)
                .background(Color(uiColor: .init(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                .cornerRadius(15)
        
            NavigationLink {
                EditAvatarView(style: style, seedDefault: nameSeed ?? seedDefault, dictionaryStyle: dictionaryStyle ?? [:], avatar: avatar)
            } label: {
                Text("Editar")
                    .padding()
                    .frame(width: 160, height: 48, alignment: .center)
                    .background(Color(uiColor: .init(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                    .cornerRadius(15)
            }
            Spacer()
            
            .task {
                dictionaryStyle = await RequestOptionsAvatar().createOptions(style)
            }

            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    self.showActionSheet = true
                    Task{
                        self.image = try await ImageModel.download("https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed ?? seedDefault)")
                        withAnimation(.easeIn) {
                            self.showSavedAlert = true
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                self.showSavedAlert = false
                            }
                        }
                    }
                }label: {
                    Text(Image(systemName: "square.and.arrow.up"))
                }
                
                .confirmationDialog("O que deseja?", isPresented: $showActionSheet) {
                    Button("Salvar em Fotos"){
                        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    }
                    Button("Copiar"){
                        let pastboard = UIPasteboard.general
                        pastboard.image = image
                    }
                }
            }
        }
        .navigationTitle(style)
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
