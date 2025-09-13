import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color(red: 0.08, green: 0.08, blue: 0.10))
            .ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
}
