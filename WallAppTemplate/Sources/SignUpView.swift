//
//  SignUp.swift
//  CalAI
//
//  Created by Henry Langmack on 3/3/24.
//

import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject var auth: AuthModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Button(action: {
                auth.googleSignIn(onDone: {_ in})
            }) {
                HStack(spacing: 20) {
                    Text("Sign in with Google")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.main)
                .cornerRadius(40)
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(.black, lineWidth: 2))
            }.padding()
            
            Spacer()
        }
    }
}
