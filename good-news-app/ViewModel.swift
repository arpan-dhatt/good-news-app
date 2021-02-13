//
//  ViewModel.swift
//  good-news-app
//
//  Created by user175571 on 2/12/21.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var model = InfoModel();
    
    //Transition Variables
    @Published var onboarding: Bool {
        didSet {
            UserDefaults.standard.set(onboarding, forKey: "onboarding")
        }
    }
    @Published var onboardingPage: String = "1"
    @Published var user: InfoModel.User
    @Published var sharingURL: String
    
    //User Defaults
    init() {
        self.sharingURL = "https://bing.com"
        
        self.onboarding = UserDefaults.standard.bool(forKey: "onboarding")
        //self.user = UserDefaults.standard.object(forKey: "user") as? InfoModel.User ??
        self.user = InfoModel.User(name: "Arpan", sources: ["yes"], categories: ["one", "two"], suggestions: ["three", "four"])
        self.user.name = UserDefaults.standard.string(forKey: "name") ?? "Arpan"
        self.user.sources = (UserDefaults.standard.array(forKey: "sources") as? [String]) ?? []
        self.user.categories = (UserDefaults.standard.array(forKey: "categories") as? [String]) ?? []
        self.user.suggestions = (UserDefaults.standard.array(forKey: "suggestions") as? [String]) ?? []
        
        
    }
    
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showWebTitle = PassthroughSubject<String, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
    var currentMapCords = " "
    var currentURL = "https://google.com"
}

enum WebViewNavigation {
    case backward, forward, reload
}

// For identifying what type of url should load into WebView
enum WebUrlType {
    case localUrl, publicUrl
}

