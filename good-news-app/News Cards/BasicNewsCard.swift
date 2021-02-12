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
    var date: String
    var description: String
    var thumbnail: String
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BasicNewsCard_Previews: PreviewProvider {
    static var previews: some View {
        BasicNewsCard()
    }
}
