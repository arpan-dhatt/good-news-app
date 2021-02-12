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
    @Published var onboarding: Bool {
        didSet {
            UserDefaults.standard.set(onboarding, forKey: "onboarding")
        }
    }
    @Published var user: InfoModel.User
    
    //User Defaults
    init() {
        self.onboarding = UserDefaults.standard.bool(forKey: "onboarding")
        //self.user = UserDefaults.standard.object(forKey: "user") as? InfoModel.User ??
        self.user = InfoModel.User(name: "Arpan", sources: ["yes"], categories: ["one", "two"], suggestions: ["three", "four"])
        self.user.name = UserDefaults.standard.string(forKey: "name") ?? "Arpan"
        self.user.sources = (UserDefaults.standard.array(forKey: "sources") as? [String]) ?? []
        self.user.categories = (UserDefaults.standard.array(forKey: "categories") as? [String]) ?? []
        self.user.suggestions = (UserDefaults.standard.array(forKey: "suggestions") as? [String]) ?? []
    }
}
