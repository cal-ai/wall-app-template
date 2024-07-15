//
//  ContentView.swift
//  WallAppTemplate
//
//  Created by Henry Langmack on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var auth = AuthModel()
    
    var body: some View {
        ContainerView()
            .environmentObject(auth)
    }
}

#Preview {
    ContentView()
}
