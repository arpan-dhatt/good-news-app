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
                
                VStack{
                    List{
                        ForEach(entries) { entry in
                            Text("hello" + entry.text!)
                            Image(uiImage: UIImage(data: entry.image!)!)
                        }
                    }.navigationTitle("My Entries")
                    
                    Button(action: {
                        showNewSheet = true
                    }, label: {
                        Text("Add Entry")
                    })
                }
            }.sheet(isPresented: $showNewSheet, content: {
                OrderSheet()
            })
        }
    }
}

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
                    
                    Button(action:{
                        let newEntry = JournalPage(context: viewContext)
                        newEntry.title = self.entryTitle
                        newEntry.text = self.entryText
                        newEntry.image = UIImage(named: "Donlad")?.jpegData(compressionQuality: 1.0)
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

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var image: UIImage?
  @Binding var isShown: Bool
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<ImagePicker>) {
    
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    
    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
      _isShown = isShown
      _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      isShown.toggle()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      isShown.toggle()
    }
  }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
