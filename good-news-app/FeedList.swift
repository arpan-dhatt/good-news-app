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
                ForEach(dataSource.items, id: \.self) { item in
                    BasicNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories).onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: item)
                    }
                }
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
