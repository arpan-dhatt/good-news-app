//
//  FeedDataSource.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI
import Combine

struct Article: Decodable, Hashable {
    var title: String
    var subtitle: String
    var article: String
    var date: String
    var description: String
    var thumbnail: String
    var categories: [String]
    var uuid: Int64
}

struct ArticleResponse: Decodable {
    var item_count: Int32
    var items: [Article]
}

class FeedDataSource: ObservableObject {
    @Published var items = [Article]()
    @Published var imageDict = [String: UIImage]()
    @Published var isLoadingPage = false
    private var currentPage = 0
    private var canLoadMorePages = true

    init() {
        loadMoreContent()
    }

    func loadMoreContentIfNeeded(currentItem item: Article?) {
        guard let item = item else {
            loadMoreContent()
            return
        }

        let thresholdIndex = items.index(items.endIndex, offsetBy: -1)
        if items.firstIndex(where: { $0.uuid == item.uuid }) == thresholdIndex {
          loadMoreContent()
        }
    }
    
    private func addImageToDict(_ url_string: String) {
        let url = URL(string: url_string)
        
        if let urlu = url {
            if let data = try? Data(contentsOf: urlu) {
                if !imageDict.keys.contains(url_string) {
                    imageDict[url_string] = UIImage(data: data)
                }
            }
        }
    }
    
    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }

        isLoadingPage = true

        let url = URL(string: "http://66.169.166.210:8080/recommendations?sources=nytimes&categories=one,two&suggested=three,four&page=\(currentPage)")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
          .decode(type: ArticleResponse.self, decoder: JSONDecoder())
          .receive(on: DispatchQueue.main)
          .handleEvents(receiveOutput: { response in
            self.canLoadMorePages = response.item_count == 10
            self.isLoadingPage = false
            self.currentPage += 1
            for item in response.items {
                self.addImageToDict(item.thumbnail)
            }
          })
          .map({ response in
            return self.items + response.items
          })
          .catch({ _ in Just(self.items) })
            .assign(to: &$items)
    }
}
