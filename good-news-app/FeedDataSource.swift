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

enum OrderType {
    case feed
    case categorical
}

class FeedDataSource: ObservableObject {
    
    @Published var items = [Article]()
    @Published var imageDict = [String: UIImage]()
    @Published var isLoadingPage = false
    
    @Published var isBig = [Bool]()
    
    private var currentPage = 0
    private var canLoadMorePages = true
    private var orderType: OrderType;
    
    init(_ type: OrderType, category: String = "") {
        orderType = type
        loadMoreContent(user: ViewModel().user, category: category)
    }
    
    func loadMoreContentIfNeeded(currentItem item: Article?, user: InfoModel.User, category: String = "") {
        guard let item = item else {
            loadMoreContent(user: user, category: category)
            return
        }

        let thresholdIndex = items.index(items.endIndex, offsetBy: -1)
        if items.firstIndex(where: { $0.uuid == item.uuid }) == thresholdIndex {
            loadMoreContent(user: user)
        }
    }
    
    private func addImageToDict(_ url_string: String) {
        let url = URL(string: url_string)
        
        if let urlu = url {
            if !imageDict.keys.contains(url_string) {
                let task = URLSession.shared.dataTask(with: urlu) { data, response, error in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.imageDict[url_string] = UIImage(data: data)
                    }
                }
                task.resume()
            }
        }
    }
    
    private func loadMoreContent(user: InfoModel.User, category: String = "") {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }

        isLoadingPage = true
        var url_obj: URL? = nil;
        if orderType == OrderType.feed {
            url_obj = URL(string: "http://66.169.166.210:8080/recommendations?sources=\(user.sources.joined(separator: ",").filter {c in c != " "})&categories=\(user.categories.joined(separator: ",").filter {c in c != " "})&suggested=\(user.suggestions.joined(separator: ",").filter {c in c != " "})&page=\(currentPage)")
//            print("http://66.169.166.210:8080/recommendations?sources=\(user.sources.joined(separator: ",").filter {c in c != " "})&categories=\(user.categories.joined(separator: ",").filter {c in c != " "})&suggested=\(user.suggestions.joined(separator: ",").filter {c in c != " "})&page=\(currentPage)")
//            url_obj = URL(string: "http://66.169.166.210:8080/categorical?sources=n,n&category=n,n&page=\(currentPage)")
        }
        else {
            url_obj = URL(string: "http://66.169.166.210:8080/categorical?sources=\(user.sources.joined(separator: ",").filter {c in c != " "})&category=\(user.categories.joined(separator: ",").filter {c in c != " "})&page=\(currentPage)")
            print(url_obj?.absoluteURL)
//            url_obj = URL(string: "http://66.169.166.210:8080/categorical?sources=n,n&category=n,n&page=\(currentPage)")
        }
        guard let url = url_obj else { return }
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
                self.isBig.append(Int.random(in: 0...100) > 60)
            }
          })
          .map({ response in
            return self.items + response.items
          })
          .catch({ _ in Just(self.items) })
            .assign(to: &$items)
    }
}
