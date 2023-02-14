import SwiftUI

struct StyleCell: View {
    private var title: String
    private var imageURL: String
    
    init(title: String, imageURL: String) {
        self.title = title
        self.imageURL = imageURL
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Circle()
                .overlay(alignment: .bottom) {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
//            Text(title)
        }
    }
}
