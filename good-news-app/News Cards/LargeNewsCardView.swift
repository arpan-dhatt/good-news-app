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
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title).font(.title).fixedSize(horizontal: false, vertical: true)
                    Text(subtitle).font(.subheadline)
                    Text(date).font(.footnote).foregroundColor(.gray)
                }
                Spacer()
            }.padding(.horizontal)
            
        }.frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.width+70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).contextMenu {
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
        }
    }
}

struct LargeNewsCard_Previews: PreviewProvider {
    static var previews: some View {
        LargeNewsCard(title: "Just in, a ", subtitle: "A subtitle ", article: "https://google.com", date: "Feb 12, 2021", description: "Terrible news about the atrocious crimes against the cat in the tree", thumbnail: "https://rustacean.net/assets/cuddlyferris.png", categories: ["one","two","three"], dataSource: FeedDataSource(.feed), activeSheet: .constant(nil))
    }
}
