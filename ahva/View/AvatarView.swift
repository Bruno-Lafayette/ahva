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
        
            NavigationLink {
                EditAvatarView(style: style, seedDefault: nameSeed ?? seedDefault, dictionaryStyle: dictionaryStyle ?? [:], avatar: avatar)
            } label: {
                Text("Editar")
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
                        self.image = try await ImageModel.download("https://api.dicebear.com/5.x/\(style)/png?\(option)=\(name ?? seedDefault)")
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
        
        
//        .overlay(alignment: .center) {
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundColor(Color(uiColor: .systemGray))
//                .overlay(alignment: .center) {
//                    Text("Imagem salva na galeria.")
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                .fixedSize(horizontal: false, vertical: true)
//                .padding(.horizontal, 40)
//                .opacity(showSavedAlert ? 1 : 0)
//        }
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
