import UIKit

class ImageModel{
    static func download(_ urlRequest: String) async throws -> UIImage? {
        var image: UIImage?
        if let url = URL(string: urlRequest){
            let postRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: postRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil
            }
            
            image = UIImage(data: data)
        }
        return image
    }
    
}
