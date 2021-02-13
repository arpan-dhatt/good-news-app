//
//  JournalView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct JournalView: View {
    @State var showNewSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalPage.timestamp, ascending: false)],
        animation: .default)
    private var entries: FetchedResults<JournalPage>
    
    var allColors = [Color.black, Color.gray, Color.purple, Color.orange, Color.pink, Color.blue]
    
    var body: some View {
        ZStack{
            
            
            NavigationView{
                VStack{
                    ScrollView{
                    ForEach(entries) { entry in
                        if let title = entry.title, let text = entry.text, let image = entry.image, let timestamp = entry.timestamp {
                            EntryView(title: title, text: text, image: UIImage(data: image) ?? UIImage(named: "Donlad")!, date: timestamp, color: allColors[Int.random(in: 0..<6)]).contextMenu {
                                Button(action: {
                                    viewContext.delete(entry)
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

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct EntryView: View {
    var title: String
    var text: String
    var image: UIImage
    var date: Date
    var color: Color
    
    static let DateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    static let DateFormat2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .short
        return formatter2
    }()
    
    var body: some View {
   
        ZStack{
            RoundedRectangle(cornerRadius: 10).foregroundColor(color).shadow(radius: 10)
            VStack(alignment: .center){
                
                    VStack{
                        VStack{
                            HStack{
                                Text(title).font(.title).bold()
                                Spacer()
                            }
                            HStack{
                                Text("\(date, formatter: Self.DateFormat), \(date, formatter: Self.DateFormat2)").font(.caption)
                                Spacer()
                            }
                        }.padding(.bottom)
                        HStack{
                            Text(text).font(.subheadline)
                            Spacer()
                        }
                        
                    }.padding()
                    
                Image(uiImage: image).resizable().aspectRatio(contentMode: .fill).cornerRadius(10.0).padding()
                
            }.foregroundColor(.white)
        }.padding()
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
