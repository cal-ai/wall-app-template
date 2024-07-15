import Foundation
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import SwiftUI

class SignInError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}

class AuthModel: NSObject, ObservableObject {
    typealias Callback = ((Result<User, SignInError>) -> ())
    
    @Published var user: User?
    
    var isLoggedIn: Bool {
        user != nil
    }
    
    private var onDone: Callback?
    private var currentNonce: String?
    
    override init() {
        super.init()
        checkAuth()
    }
    
    func checkAuth() {
        let user = Auth.auth().currentUser
        self.user = user
    }
    
    func googleSignIn(onDone: Callback?) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // As you’re not using view controllers to retrieve the presentingViewController, access it through
        // the shared instance of the UIApplication
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { user, error in
            if let error = error {
                onDone?(.failure(SignInError(message: "Error doing Google Sign-In, \(error)")))
                return
            }
            
            guard
                let idToken = user?.user.idToken,
                let accessToken = user?.user.accessToken
            else {
                onDone?(.failure(SignInError(message: "Error during Google Sign-In authentication, \(String(describing: error))")))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            // Authenticate with Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                
                if let authResult = authResult {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.user = authResult.user
                        }
                        onDone?(.success(authResult.user))
                        self.objectWillChange.send()
                        print("Signed in with Google")
                    }
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            withAnimation {
                self.user = nil
            }
        } catch {
            print("error logging out \(error.localizedDescription)")
        }
    }
}
