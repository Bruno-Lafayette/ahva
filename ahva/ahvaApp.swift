import SwiftUI

@main
struct ahvaApp: App {
    var body: some Scene {
        WindowGroup {
            EditAvatarView(style: "adventurer", seedDefault: "Felix", option: "seed")
        }
    }
}
