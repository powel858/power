import SwiftUI

@main
struct _23App: App {
    @AppStorage("hasProfile") private var hasProfile: Bool = false
    
    init() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "resetProfileOnNextLaunch") {
            defaults.removeObject(forKey: "hasProfile")
            defaults.removeObject(forKey: "resetProfileOnNextLaunch")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasProfile {
                    ContentView2()
                } else {
                    ContentView()
                }
            }
        }
    }
}
