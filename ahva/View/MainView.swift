import SwiftUI

struct MainView: View {

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var styles: [String] = []
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    private let seedDefault = "manhattan"
    private let key = "seed"
    private var url = ""
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(styles, id: \.self) { style in
                        NavigationLink {
                            AvatarView(style, seedDefault,url: "https://api.dicebear.com/5.x/\(style)/png?\(key)=\(seedDefault)")
                        } label: {
                            
                            StyleCell(title: style, imageURL: "https://api.dicebear.com/5.x/\(style)/png?\(key)=\(seedDefault)", text: true)
                            
                        }
                        .foregroundColor(Color(uiColor: .init(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
                    }
                }
                .task {
                    do {
                        let request = try HTTPRequestFactory(path: "https://databaseavatar.vercel.app/api/style", method: .GET).createRequest()
                        let (data, _) = try await request.send()
                        
                        if let data, let json = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                            let styles: [String] = json["styles"] as? [String] {
                            self.styles = styles
                        }
                        
                    } catch URLError.badURL {
                        self.invalidUrlError = true
                    } catch {
                        print(error)
                        print(error.localizedDescription)
                        self.unkownError = true
                    }
                }
                .alert("URL Inválido", isPresented: $invalidUrlError) {
                    Button(role: .cancel, action: {}, label: {Text("Ok")})
                }
                .alert("Erro desconhecido :(", isPresented: $unkownError) {
                    Button(role: .cancel, action: {}, label: {Text("Ok")})
                }
            }
            .navigationTitle("Estilos")
        }
    }
}
