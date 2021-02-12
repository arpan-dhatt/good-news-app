//
//  ViewModel.swift
//  good-news-app
//
//  Created by user175571 on 2/12/21.
//

import SwiftUI

class viewModel: ObservableObject {
    @Published var model: InfoModel = InfoModel();
    
    //Transition Variables
    @Published var page = "login"
    
}
