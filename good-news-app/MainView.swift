//
//  MainView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.onboarding == true {
            OnboardingView()
        } else {
            TabView {
                FeedView()
                    .tabItem {
                        Label("Feed", systemImage: "newspaper")
                    }
                JournalView()
                    .tabItem {
                        Label("Journal", systemImage: "pencil")
                    }
                CategoricalView()
                    .tabItem {
                        Label("Categories", systemImage: "folder")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewModel())
    }
}
