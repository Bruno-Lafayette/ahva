import SwiftUI

struct OptionEditAvatar: View {
    private var styles: [String:Any]?
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    @State private var values: [String] = []
    @State private var key: String = ""
    private var nameSeed: String?
    private var style: String
    
    init(type: String, nameSeed: String?, styles: [String:Any]?) {
        self.nameSeed = nameSeed
        self.style = type
        self.styles = styles
    }
    
    
    var body: some View {
                
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Array(styles ?? [:]), id: \.key) { style in
                    Button {
                        values = style.value as! [String]
                        key = style.key
                    } label: {
                        ButtonStyle(text: style.key)
                    }
                }
                .cornerRadius(50)
                
            }
//
//            .task {
//                await createOptions(style)
//            }
        }
        GridStyles(style, nameSeed ?? "" ,key, values)
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
