//
//  SavedArticles.swift
//  good-news-app
//
//  Created by user175571 on 2/13/21.
//

import SwiftUI

struct SavedArticles: View {
    @State var showNewSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SavedArticles.article, ascending: false)],
        animation: .default)
    private var articles: FetchedResults<SavedArticles>
    
    var allColors = [Color.black, Color.gray, Color.purple, Color.orange, Color.pink, Color.blue]
    
    var body: some View {
        ZStack{
            
            
            NavigationView{
                VStack{
                    ScrollView{
                    ForEach(articles) { entry in
                        if let title = entry.title, let text = entry.text, let image = entry.image, let timestamp = entry.timestamp {
                            EntryView(title: title, text: text, image: UIImage(data: image) ?? UIImage(named: "Donlad")!, date: timestamp, color: allColors[Int.random(in: 0..<6)]).contextMenu {
                                Button(action: {
                                    viewContext.delete(entry)
                                    try? viewContext.save()
                                }) {
                                    Label("Delete", systemImage: "x.circle")
                                }
                        }
                    }
                    }.navigationBarTitle("My Journal")
                }
            }.sheet(isPresented: $showNewSheet, content: {
                OrderSheet()
            })
        }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        showNewSheet = true
                    }){
                        Image(systemName: "plus").font(.system(size:40, weight: .light))
                    }.padding().background(Color.green).foregroundColor(.white).cornerRadius(75.0).shadow(radius: 10.0)
                    
                }.padding()
            }
    }
}
}

struct SavedArticles_Previews: PreviewProvider {
    static var previews: some View {
        SavedArticles()
    }
}
