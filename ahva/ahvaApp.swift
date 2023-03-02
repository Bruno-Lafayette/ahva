import SwiftUI

@main
struct ahvaApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            
            SplashView()
                .environmentObject(networkMonitor)
            
        }
    }
}
