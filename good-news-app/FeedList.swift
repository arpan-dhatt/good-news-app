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
    @State var currentURL = "https://google.com"
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dataSource.items, id: \.self) { item in
                    BasicNewsCard(title: item.title, subtitle: item.subtitle, article: item.article, date: item.date, description: item.description, thumbnail: item.thumbnail, categories: item.categories, dataSource: dataSource).onAppear {
                        dataSource.loadMoreContentIfNeeded(currentItem: item)
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
    
struct SafariView: UIViewControllerRepresentable{
    @Binding var url_string: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        config.barCollapsingEnabled = false
        let safariView = SFSafariViewController(url: URL(string: url_string) ?? URL(string: "https://google.com")!, configuration: config)
        return safariView
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList().environmentObject(ViewModel())
    }
}
