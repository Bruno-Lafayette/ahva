import SwiftUI

struct OptionEditAvatar: View {
    
    private let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    private var styles: [String:Any]?
    @Binding private var values: [String]
    @Binding private var key: String?
    
    init(_ styles: [String : Any]? = nil,_ values: Binding<[String]>,_ key: Binding<String?>) {
        self.styles = styles
        self._values = values
        self._key = key
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Array(styles ?? [:]), id: \.key) { style in
                    Button {
                        self.values = style.value as! [String]
                        self.key = style.key
                    } label: {
                        ButtonStyle(text: style.key)
                    }
                }
                .cornerRadius(50)
            }
        }
    }
}

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
