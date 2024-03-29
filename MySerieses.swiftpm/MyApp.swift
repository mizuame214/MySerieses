import SwiftUI

@main
struct MyApp: App
{
    var body: some Scene
    {
        WindowGroup
        {
            NavigationView
            {
                ContentView()
                    .preferredColorScheme(.light)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.teal)
        }
    }
}
