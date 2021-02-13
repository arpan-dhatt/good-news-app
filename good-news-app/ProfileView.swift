//
//  ProfileView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Divider()
                    Text("Visible Categories").font(.title)
                    StringListModifierView(choices: ["World","Business","SciTech", "Sports"], choice: .categories)
                    Divider()
                    Text("Visible Sources").font(.title)
                    StringListModifierView(choices: ["Good News Network", "New York Times"], choice: .sources)
                }
            }.navigationBarTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ViewModel())
    }
}
