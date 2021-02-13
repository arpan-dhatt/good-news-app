//
//  ArticleView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

struct ArticleView: View {
    
    var title: String
    var date: String
    var summary: String
    var text: String
    var thumbnail: UIImage
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: thumbnail).resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                Text(title).font(.title).padding(.horizontal)
                Text(date).font(.caption).padding(.horizontal)
                Text(summary).font(.headline).padding(.horizontal)
                Text(text).font(.subheadline).padding()
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(title: "Title", date: "Feb 12, 2021", summary: "Summmary......", text: "helo", thumbnail: UIImage(named: "Donlad")!)
    }
}
