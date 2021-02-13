//
//  CategoryList.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

struct CategoryList: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @StateObject var dataSource = FeedDataSource(.categorical)
    @State var presentingSafariView = false
    @State var currentURL = "https://bing.com"
    
    var category: String
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.items, id: \.self) { item in
                    BasicNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories, dataSource: dataSource).onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: item, user: viewModel.user, category: category)
                    }.onTapGesture {
                        self.currentURL = item.article
                        viewModel.currentURL = item.article
                        print(self.currentURL)
                        self.presentingSafariView = true
                    }
                }
                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }
        }.sheet(isPresented: $presentingSafariView){
            WebView(viewModel: ViewModel())
        }
    }
    
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(category: "one")
    }
}
