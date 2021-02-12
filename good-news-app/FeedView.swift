//
//  FeedView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct FeedView: View {
    @State private var showProfileView = false
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).navigationBarTitle("Feed").navigationBarItems(trailing: Button(action: {
                showProfileView.toggle()
            }) {
                Label("Profile", systemImage: "person.circle.fill")
            })
        }.sheet(isPresented: $showProfileView) {
            ProfileView()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
