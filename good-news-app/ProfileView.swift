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
                    Text("\(viewModel.user.name)").font(.title)
                    Divider()
                    Text("Visible Categories").font(.headline)
                    StringListModifierView(choices: ["Business","Sports","Weather"], choice: .categories)
                    Divider()
                    Text("Visible Sources").font(.headline)
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
