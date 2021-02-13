//
//  LargeNewsCardView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

struct LargeNewsCard: View {
    var title: String
    var subtitle: String
    var article: String
    var date: String
    var description: String
    var thumbnail: String
    var categories: [String]
    
    @ObservedObject var dataSource: FeedDataSource
    
    var body: some View {
        VStack {
            Image(uiImage: dataSource.imageDict[thumbnail] ?? UIImage(named: "Donlad")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:UIScreen.main.bounds.width-30, height:UIScreen.main.bounds.width-30).cornerRadius(10.0)
                .padding(.vertical)
                .shadow(radius: 5.0)
            
            VStack(alignment: .leading) {
                Text(title).font(.headline).bold()
                Text(date).font(.footnote).font(.caption).foregroundColor(.gray)
                Text(subtitle).font(.subheadline).padding(.vertical)
                
            }
            
        }.frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.width+70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct LargeNewsCard_Previews: PreviewProvider {
    static var previews: some View {
        LargeNewsCard(title: "Just in, a title found a title in a tree", subtitle: "A subtitle didn't want to help the subtitle stuck in a subtitle", article: "https://google.com", date: "Feb 12, 2021", description: "Terrible news about the atrocious crimes against the cat in the tree", thumbnail: "https://rustacean.net/assets/cuddlyferris.png", categories: ["one","two","three"], dataSource: FeedDataSource(.feed))
    }
}
