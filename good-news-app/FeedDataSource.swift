//
//  FeedDataSource.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI
import Combine

struct Article: Decodable {
    var title: String
    var subtitle: String
    var date: String
    var description: String
    var thumbnail: String
    var categories: [String]
    var id: Int64
}

struct ArticleResponse: Decodable {
    var item_count: Int32
    var items: [Article]
}

class FeedDataSource: ObservableObject {
  @Published var items = [Article]()
  @Published var isLoadingPage = false
  private var currentPage = 1
  private var canLoadMorePages = true

  init() {
    loadMoreContent()
  }

  func loadMoreContentIfNeeded(currentItem item: Article?) {
    guard let item = item else {
      loadMoreContent()
      return
    }

    let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
    if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      loadMoreContent()
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
      })
      .map({ response in
        return self.items + response.items
      })
      .catch({ _ in Just(self.items) })
        .assign(to: &$items)
  }
}
