import Foundation
import SwiftUI

struct ContainerView: View {
    @EnvironmentObject var auth: AuthModel
    
    var body: some View {
        Group {
            if !auth.isLoggedIn {
                SignUpView()
                    .transition(.opacity)
            } else {
                MainScreenView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            print("Logged in: \(auth.isLoggedIn)")
        }
        .onChange(of: auth) { value in
            print("Logged in: \(auth.isLoggedIn)")
        }
    }
}
