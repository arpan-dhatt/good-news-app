//
//  good_news_appApp.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

@main
struct good_news_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainView().environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(ViewModel())
        }
    }
}
