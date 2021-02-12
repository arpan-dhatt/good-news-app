//
//  ViewModel.swift
//  good-news-app
//
//  Created by user175571 on 2/12/21.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var model: InfoModel = InfoModel();
    
    //Transition Variables
    @Published var onboarding: Bool
    @Published var user: InfoModel.User {
        didSet{
            UserDefaults.standard.set(user, forKey: "user")
        }
    }
    
    //User Defaults
    init() {
        self.onboarding = false
        self.user = UserDefaults.standard.object(forKey: "user") as? InfoModel.User ?? InfoModel.User(name: "Arpan", sources: ["yes"], categories: ["one", "two"], suggestions: ["three", "four"])
    }
}
