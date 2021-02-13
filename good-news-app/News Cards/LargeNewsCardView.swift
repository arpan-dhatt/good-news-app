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
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    
    @ObservedObject var dataSource: FeedDataSource
    
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack {
            Image(uiImage: dataSource.imageDict[thumbnail] ?? UIImage(named: "Donlad")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:UIScreen.main.bounds.width-30, height:UIScreen.main.bounds.width-30)
            
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline)
                Text(date).font(.footnote).foregroundColor(.gray)
            }
            
        }.frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.width+70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(colorScheme == .light ? Color.white : Color.black).contextMenu {
            Button(action: {
                    print("do something")
            }) {
                Label("Bookmark", systemImage: "bookmark")
            }
            Button(action: {
                viewModel.sharingURL = article
                activeSheet = .share
            }, label: {
                Label("Share", systemImage: "square.and.arrow.up")
            })
        }.cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct LargeNewsCard_Previews: PreviewProvider {
    static var previews: some View {
        LargeNewsCard(title: "Just in, a title found a title in a tree", subtitle: "A subtitle didn't want to help the subtitle stuck in a subtitle", article: "https://google.com", date: "Feb 12, 2021", description: "Terrible news about the atrocious crimes against the cat in the tree", thumbnail: "https://rustacean.net/assets/cuddlyferris.png", categories: ["one","two","three"], dataSource: FeedDataSource(.feed), activeSheet: .constant(nil))
    }
}
