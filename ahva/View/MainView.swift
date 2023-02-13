import SwiftUI

struct MainView: View {
    @State private var styles: [String] = []
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    private let seedDefault = "manhattan"
    private let key = "seed"
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(styles, id: \.self) { style in
                        NavigationLink {
                            AvatarView(style, seedDefault)
                        } label: {
                            StyleCell(title: style, imageURL: "https://api.dicebear.com/5.x/\(style)/png?\(key)=\(seedDefault)")
                        }
                        .foregroundColor(.white)
                        
                    }
                }
                .task {
                    do {
                        //dentro da vm
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
            .background(.orange)
        }
    }
}
