import SwiftUI

struct CreateAvatarView: View {
    @State var avatarName = ""
    @State var urlImage = ""
    var styleName: String
    
    var body: some View {
        VStack {
            TextField("Escreva o nome do seu avatar", text: $avatarName)
            
            AsyncImage(url: URL(string: urlImage))
            
            Button {
                self.urlImage = imagem(name: avatarName, style: styleName)
                print("funciona")
            } label: {
                Text("Criar")
            }
            NavigationLink {
                CustomAvatar()
            } label: {
                Text("Customizar")
            }


        }
//        .task {
//            do {
//                //dentro da vm
//                let request = try HTTPRequestFactory(path: "https://api.dicebear.com/5.x/\(styleName)/png?seed=\(avatarName)", method: .GET).createRequest()
//                let (data, response) = try await request.send()
//
//
//
//                print(response.statusCode)
//            }
//        }
    }
    func imagem(name: String, style: String) -> String{
        return "https://api.dicebear.com/5.x/\(style)/png?seed=\(name)"
    }
}
