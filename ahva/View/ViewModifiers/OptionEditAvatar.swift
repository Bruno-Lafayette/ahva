import SwiftUI

struct OptionEditAvatar: View {
    private var styles: [String:Any]?
    private let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @State private var values: [String] = []
    @State private var key: String = "hair"
    @State private var value: String = ""
    @State private var keyAvatar: String = ""
    private var nameSeed: String
    private var style: String
    
    init(styles: [String : Any]? = nil,  nameSeed: String, style: String) {
        self.styles = styles
        self.nameSeed = nameSeed
        self.style = style
    }
    
    
    var body: some View {
        
        AvatarGenerator(typeRequest: .customize, styles, style, keyAvatar, value, nameSeed)
                
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Array(styles ?? [:]), id: \.key) { style in
                    Button {
                        values = style.value as! [String]
                        self.key = style.key
                    } label: {
                        ButtonStyle(text: style.key)
                    }
                }
                .cornerRadius(50)
            }
        }
        
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(values, id: \.self) { value in
                    
                    Button {
                        keyAvatar = key
                        self.value = value
                    } label: {
                        StyleCell(title: value, imageURL: "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)&\(key)=\(value)")

                    }

                }
            }
        }
        
        
        
        
//        GridStyles(style, nameSeed ?? "" ,key, values)
    }
    
}


//extension OptionEditAvatar{
//    func createOptions(_ type: String) async {
//        do {
//            let request = try HTTPRequestFactory(path: "https://databaseavatar.vercel.app/api/character/\(type)", method: .GET).createRequest()
//            let (data, _) = try await request.send()
//
//            if let data, let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
//               self.styles = json
//            }
//
//        } catch URLError.badURL {
//            self.invalidUrlError = true
//        } catch {
//            self.unkownError = true
//        }
//    }
//}


struct ButtonStyle: View{
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View{
        Text(text)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(.red)
    }
}
