//
//  InfoModel.swift
//  good-news-app
//
//  Created by user175571 on 2/12/21.
//

import Foundation

struct InfoModel {
    
    struct User {
        var name: String {
            didSet {
                UserDefaults.standard.set(name, forKey: "name")
            }
        }
        var sources: [String] {
            didSet {
                UserDefaults.standard.set(sources, forKey: "sources")
            }
        }
        var categories: [String] {
            didSet {
                UserDefaults.standard.set(categories, forKey: "categories")
            }
        }
        var suggestions: [String] {
            didSet {
                UserDefaults.standard.set(suggestions, forKey: "suggestions")
            }
        }
    }
    
}
