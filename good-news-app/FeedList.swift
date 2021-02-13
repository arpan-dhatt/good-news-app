//
//  FeedList.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case share, web
    
    var id: Int {
        hashValue
    }
}

struct FeedList: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @StateObject var dataSource = FeedDataSource(.feed)
    @State var presentingSafariView = false
    @State var currentURL = "https://bing.com"
    
    @State var presentingShareView = false
    @State var activeSheet: ActiveSheet? = nil
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.items, id: \.self) { item in
                    if true {
                        BasicNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories, dataSource: dataSource, activeSheet: $activeSheet).onAppear {
                            dataSource.loadMoreContentIfNeeded(currentItem: item, user: viewModel.user)
                        }.onTapGesture {
                            self.currentURL = item.article
                            print(item.article)
                            viewModel.currentURL = item.article
                            print(self.currentURL)
                            self.activeSheet = .web
                        }
                    } else {
                        LargeNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories, dataSource: dataSource, activeSheet: $activeSheet).onAppear {
                            dataSource.loadMoreContentIfNeeded(currentItem: item, user: viewModel.user)
                        }.onTapGesture {
                            self.currentURL = item.article
                            viewModel.currentURL = item.article
                            print(self.currentURL)
                            self.activeSheet = .web
                        }
                    }
                }
                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }.sheet(isPresented: $presentingShareView, content: {
                ShareSheetView(applicationActivities: nil)
            })
        }.sheet(item: $activeSheet){ item in
            if activeSheet == .share {
                ShareSheetView(applicationActivities: nil)
            }
            if activeSheet == .web {
                WebView(viewModel: ViewModel())
            }
        }
    }
    
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList().environmentObject(ViewModel())
    }
}
