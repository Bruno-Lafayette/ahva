import SwiftUI

struct EditView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @Environment(\.dismiss) var dismiss
    private let avatar: Avatar
    @Binding var urlOption: String
    @State var url: String = ""
    @State var nameSeed: String?
    @State var values: [String] = []
    @State var value: String = ""
    @State private var key: String?
    private var dictionaryStyle: [String:Any]?
    private var style: String
    private var seedDefault: String
    private var error = "nil"
    
    init(urlOption: Binding<String>, key: String? = nil, style: String, seedDefault: String, nameSeed: String? = nil, dictionaryStyle: [String:Any]?, avatar: Avatar ) {
        self._nameSeed = State(initialValue: nameSeed)
        self._key = State(initialValue: key)
        self.style = style
        self.seedDefault = seedDefault
        self.dictionaryStyle = dictionaryStyle
        self.avatar = avatar
        self._urlOption = urlOption
    }
    
    var body: some View {
        
        if networkMonitor.isConnected {
            
            AvatarGenerator(url: addUrl())
            OptionEditAvatar(dictionaryStyle, $values, $key, $value)
            GridStyles(valueSelect: $value, values: values, style: style, key: key, nameSeed: nameSeed ?? seedDefault)
            Spacer()
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button() {
                            urlOption = addUrl()
                            dismiss()
                        }label: {
                            Text("Ok")
                        }
                    }
                }
            
        } else {
            
            Alert(imageText: "icloud.slash", title: "Ops!", text: "Houve algum problema com a conexão")
            
        }
        
    }               
    private func addUrl() -> String{
        self.urlOption = avatar.requestImage(request: .customize, nameSeed ?? seedDefault, style, key ?? error, value)
        return self.urlOption
    }
    
}

