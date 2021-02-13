//
//  BasicNewsCard.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct BasicNewsCard: View {
    var title: String
    var subtitle: String
    var article: String
    var date: String
    var description: String
    var thumbnail: String
    var categories: [String]
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline)
                Text(date).font(.footnote).foregroundColor(.gray)
            }
            Spacer()
            ImageView(withURL: thumbnail).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }.frame(width: UIScreen.main.bounds.width-30, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct BasicNewsCard_Previews: PreviewProvider {
    static var previews: some View {
        BasicNewsCard(title: "Just in, a title found a title in a tree", subtitle: "A subtitle didn't want to help the subtitle stuck in a subtitle", article: "https://google.com", date: "Feb 12, 2021", description: "Terrible news about the atrocious crimes against the cat in the tree", thumbnail: "https://rustacean.net/assets/cuddlyferris.png", categories: ["one","two","three"])
    }
}
