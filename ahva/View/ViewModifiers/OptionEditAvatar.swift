import SwiftUI

struct OptionEditAvatar: View {
    
    @Binding private var values: [String]
    @Binding private var key: String?
    @Binding private var valueSelectReset: String
    private var styles: [String:Any]?
    
    init(_ styles: [String : Any]? = nil,_ values: Binding<[String]>,_ key: Binding<String?>,_ resetValue: Binding<String>) {
        self.styles = styles
        self._values = values
        self._key = key
        self._valueSelectReset = resetValue
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Array(styles ?? [:]), id: \.key) { style in
                    Button {
                        self.valueSelectReset = ""
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
        Image(text)
            .foregroundColor(.black)
            .frame(width: 70, height: 70)
            .background(Color(uiColor: .init(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
    }
}
