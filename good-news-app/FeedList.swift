//
//  FeedList.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct FeedList: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @StateObject var dataSource = FeedDataSource(.feed)
    @State var presentingSafariView = false
    @State var currentURL = "https://bing.com"
    
    @State var presentingShareView = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.items, id: \.self) { item in
                    BasicNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories, dataSource: dataSource, presentingShareView: $presentingShareView).onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: item, user: viewModel.user)
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
        }.sheet(isPresented: $presentingShareView, content: {
            ShareSheetView(applicationActivities: nil)
        })
    }
    
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList().environmentObject(ViewModel())
    }
}
