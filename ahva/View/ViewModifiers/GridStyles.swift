import SwiftUI

struct GridStyles: View {
   
    @Binding var valueSelect: String
    private let columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    private var values: [String]
    private var style: String
    private var key: String
    private var nameSeed: String
    
    init(valueSelect: Binding<String>, values: [String], style: String, key: String?, nameSeed: String) {
        self._valueSelect = valueSelect
        self.values = values
        self.style = style
        self.key = key ?? "erro"
        self.nameSeed = nameSeed
    }
    
    var body: some View{
        ScrollView(.vertical){
            CustomGrid(values.sorted(by: {$0 < $1}), numberOfColumns: 3) { value in
                Button {
                    valueSelect = value
                } label: {
                    StyleCell(title: value, imageURL: "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)&\(key)=\(value)", text: false)
                }
                .foregroundColor(Color(uiColor: .init(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)))
            }
        }
        
    }
}
