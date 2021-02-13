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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalPage.timestamp, ascending: true)],
        animation: .default)
    private var entries: FetchedResults<JournalPage>
    
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    ForEach(entries) { entry in
                        Text("hello" + entry.text!)
                    }
                }.navigationTitle("My Entries").navigationBarItems(trailing: Button(action: {
                    showNewSheet = true
                }, label: {
                    Image(systemName: "plus.circle").imageScale(.large)
                })).sheet(isPresented: $showNewSheet, content: {
                    OrderSheet()
                })
            }
        }
    }
}

struct OrderSheet: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var entryText = ""
    @State var entryTitle = ""
    @State var entryImage = ""
    
    var body: some View {
        ZStack{
            NavigationView{
                Form{
                    Section(header: Text("Title")){
                        TextField("Title", text: $entryTitle)
                    }
                    Section(header: Text("Content")){
                        TextField("Content", text: $entryText)
                    }
                    
                    Button(action:{
                        let newEntry = JournalPage(context: viewContext)
                        newEntry.title = self.entryTitle
                        newEntry.text = self.entryText
                        newEntry.image = UIImage(named: "donlad")?.jpegData(compressionQuality: 1.0)
                        newEntry.timestamp = Date()
                        newEntry.id = UUID()
                        
                        do{
                            try viewContext.save()
                            print("added success")
                            presentationMode.wrappedValue.dismiss()
                        }
                        catch{
                            print(error.localizedDescription)
                        }
                    }){
                        Text("Add Entry")
                    }
                }.navigationBarTitle("Add Entry")
            }
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
