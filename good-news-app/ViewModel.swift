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
    @Published var user: InfoModel.User
    
    init() {
        // gets stuff from use defaults
        
        // if some property doesn't exist, initialize it with whatever would make sense as a default
    }
}
