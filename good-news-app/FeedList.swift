//
//  FeedList.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI
import SafariServices

struct FeedList: View {
    @StateObject var dataSource = FeedDataSource()
    @State var presentingSafariView = false
    @State var currentURL = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.items, id: \.self) { item in
                    BasicNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories).onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: item)
                    }.onTapGesture {
                        self.presentingSafariView = true
                        self.currentURL = item.article
                    }
                }.sheet(isPresented: $presentingSafariView){
                    SafariView(url: URL(string: currentURL)!)
                }
                if dataSource.isLoadingPage {
                    ProgressView()
                }
            }
        }
    }
    
}
    
    struct SafariView: UIViewControllerRepresentable{
        var url: URL
        func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
            let safariView = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            return safariView
        }
        func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        }
        
    }

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList()
    }
}
