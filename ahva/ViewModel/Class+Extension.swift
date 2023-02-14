import Foundation

extension Array {
    func getElementAt(index: Int) -> Element? {
        return (index < self.endIndex) ? self[index] : nil
    }
}

class Avatar{
    
    private var urlAvatar = "https://api.dicebear.com/5.x/"
    private var dictionary: [String:Any] = [:]
    
    func requestImage (request: toGenerate,_ seedName: String,_ style: String,_ key: String ,_ value: String) -> String{
        switch request {
        case .new:
            return createAvatar(style, seedName)
        case .customize:
            if key != "nil"{
                return createCustomAvatar(style, seedName, (key, value))
            }
            return urlAvatar
        case .lastRequest:
            return URLDefault(style: style, seedName: seedName, key: key, value: value)

        }
    }
    
    private func createAvatar(_ style: String,_ value: String) -> String{
        self.urlAvatar = "https://api.dicebear.com/5.x/\(style)/png?seed=\(value)"
        return urlAvatar
    }
    
    private func createCustomAvatar(_ style: String,_ nameSeed: String,_ keyValue: (String, String)) -> String{
        self.urlAvatar = "https://api.dicebear.com/5.x/\(style)/png?seed=\(nameSeed)"
        dictionary.updateValue(keyValue.1, forKey: keyValue.0)
        
        for indice in dictionary{
            if indice.key != "nil" && indice.value as! String != ""{
                self.urlAvatar += "&\(indice.key)=\(indice.value)"
            }
        }
        print(urlAvatar)
        return urlAvatar
    }
    
    
    private func URLDefault(style: String, seedName: String, key: String, value: String) -> String{
        let lastRequest = createCustomAvatar(style, seedName, (key,value))
        self.urlAvatar = "https://api.dicebear.com/5.x/"
        self.dictionary = [:]
        return lastRequest
    }
    
    
}


enum toGenerate {
    case new, customize, lastRequest
}

//class CreateAvatarViewModel: ObservableObject {
//
//    enum AvatarStyle: String {
//        case style1 = "/asdasdasd"
//    }
//
//    private let BASE_PATH = "https://..."
//    
//    
//    
//    @Published var url: String = ""
//    @Published var values: [String:String] = [:]
////    private var selectedStyle: AvatarStyle
//    
//    func buildURL() -> URL?  {
//        return URL(string: "\(BASE_PATH)/\(selectedStyle)")
//    }
//    
//    
//}
