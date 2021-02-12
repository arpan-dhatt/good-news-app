//
//  FeedList.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct FeedList: View {
    @StateObject var dataSource = FeedDataSource()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }
        }
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList()
    }
}
