//
//  BasicNewsCard.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct BasicNewsCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    
    var title: String
    var subtitle: String
    var article: String
    var date: String
    var description: String
    var thumbnail: String
    var categories: [String]
    
    @ObservedObject var dataSource: FeedDataSource
    
    var allColors = [
        "sports": Color("blue1"),
        "world": Color("purple1"),
        "business": Color("orange1"),
        "scitech": Color("red1")
    ]
    
    @Binding var activeSheet: ActiveSheet?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.headline).foregroundColor(allColors[categories[0].lowercased()] ?? .black)
                Text(date).font(.footnote).foregroundColor(.gray)
            }
            Spacer()
            Image(uiImage: dataSource.imageDict[thumbnail] ?? UIImage(named: "Donlad")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:180, height:180).clipped().cornerRadius(10)
        }.frame(width: UIScreen.main.bounds.width-30, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct BasicNewsCard_Previews: PreviewProvider {
    static var previews: some View {
        BasicNewsCard(title: "Just in, a title found a title in a tree", subtitle: "A subtitle didn't want to help the subtitle stuck in a subtitle", article: "https://google.com", date: "Feb 12, 2021", description: "Terrible news about the atrocious crimes against the cat in the tree", thumbnail: "https://rustacean.net/assets/cuddlyferris.png", categories: ["one","two","three"], dataSource: FeedDataSource(.feed), activeSheet: .constant(.none))
    }
}
