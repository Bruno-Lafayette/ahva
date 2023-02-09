import SwiftUI

struct ExemploManhattan: View {
    @State private var styles: [String] = []
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    
    var body: some View {
        
        NavigationView{
            List(styles, id: \.self) { style in
                NavigationLink {
                    CreateAvatarView(styleName: style)
                } label: {
                    Text(style)
                    
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
    }
}
