import SwiftUI

struct ExemploManhattan: View {
    @State private var styles: [String] = []
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    private let seedDefault = "manhattan"
    private let option = "seed"
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(styles, id: \.self) { style in
                        NavigationLink {
                            EditAvatarView(style: style, seedDefault: seedDefault, option: option)
                        } label: {
                            StyleCell(title: style, imageURL: "https://api.dicebear.com/5.x/\(style)/png?\(option)=\(seedDefault)")
                        }
                        .foregroundColor(.white)
                        
                    }
                }
                .task {
                    do {
                        //dentro da vm
                        let request = try HTTPRequestFactory(path: "https://databaseavatar.vercel.app/api/style", method: .GET).createRequest()
                        let (data, response) = try await request.send()
                        
                        print(response.statusCode)
                        
                        if let data, let json = try JSONSerialization.jsonObject(with: data) as? [String:Any], let styles: [String] = json["styles"] as? [String] {
                            
                            self.styles = styles
                        }
                        //
                        
                        // deixar parte da trataiva aqui mesmo
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

struct StyleCell: View {
    private var title: String
    private var imageURL: String
    
    init(title: String, imageURL: String) {
        self.title = title
        self.imageURL = imageURL
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Circle()
                .overlay(alignment: .bottom) {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
            .clipShape(Circle())
            Text(title)
        }
    }
}
