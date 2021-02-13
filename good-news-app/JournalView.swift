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
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    ScrollView{
                    ForEach(entries) { entry in
                        if let title = entry.title, let text = entry.text, let image = entry.image, let timestamp = entry.timestamp {
                            EntryView(title: title, text: text, image: UIImage(data: image) ?? UIImage(named: "Donlad")!, date: timestamp)
                        }
                    }
                    }.navigationBarTitle("My Journal").navigationBarItems(trailing: Button(action: {
                        showNewSheet = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                    })
                }.background(Image((colorScheme == .light) ? "day-mountains" : "night-forest").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
            }.sheet(isPresented: $showNewSheet, content: {
                OrderSheet()
            })
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
            //RoundedRectangle(cornerRadius: 10).foregroundColor(.purple).shadow(radius: 10)//
            VisualEffectView(effect: UIBlurEffect(style: .regular)).cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
                    Spacer()
                Image(uiImage: image).resizable().scaledToFill().cornerRadius(10.0)
                
            }
        }.padding()
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
