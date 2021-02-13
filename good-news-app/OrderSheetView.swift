//
//  OrderSheetView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

struct OrderSheet: View {
    @State var showImagePicker = false
    @State var pickedImage: UIImage? = nil
    
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
                    Section(header: Text("Select Image")){
                        Button(action: {self.showImagePicker.toggle()}, label: {
                            HStack{
                                Spacer()
                                Text("Pick Image")
                                Spacer()
                            }
                        })
                    }
                    
                    if pickedImage != nil {
                        Image(uiImage: pickedImage!).resizable().scaledToFill().padding()
                    }
                    
                    Button(action:{
                        let newEntry = JournalPage(context: viewContext)
                        newEntry.title = self.entryTitle
                        newEntry.text = self.entryText
                        if pickedImage != nil {
                            newEntry.image = pickedImage?.jpegData(compressionQuality: 1.0)
                        }
                        else{
                            newEntry.image = UIImage(named: "Donlad")?.jpegData(compressionQuality: 1.0)
                        }
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
                }.navigationBarTitle("Add Entry").sheet(isPresented: $showImagePicker, onDismiss: {self.showImagePicker = false}, content: {
                    ImagePicker(image: $pickedImage, isShown: $showImagePicker)
                })
            }
        }
    }
}

struct OrderSheet_Previews: PreviewProvider {
    static var previews: some View {
        OrderSheet()
    }
}
