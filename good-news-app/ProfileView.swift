//
//  ProfileView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ViewModel
    let yellow = UIColor(red: 254,green: 188,blue: 47, alpha: 1)
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack{
                        HStack{
                            Text("Name:").font(.title2).bold()
                            Spacer()
                            Image(systemName: "pencil.circle.fill").font(.title)
                        }.padding([.top,.leading, .trailing])
                        Divider()
                        TextField("", text: $viewModel.user.name).padding([.bottom,.leading, .trailing])
                        
                    }.background(Color.blue).cornerRadius(10.0).foregroundColor(.white).padding()
                    VStack{
                    HStack{
                        Text("Selected Categories").font(.title2).bold().padding()
                        Spacer()
                    }
                        Divider()
                    StringListModifierView(choices: ["World","Business","SciTech", "Sports"], choice: .categories)
                    }.font(.headline).background(Color("purple1")).cornerRadius(10.0).foregroundColor(.white).padding()
                    
                    VStack{
                    HStack{
                        Text("Selected Sources").font(.title2).bold().padding()
                        Spacer()
                    }
                        Divider()
                    StringListModifierView(choices: ["Default", "NY Times", "BBC", "Washington Post", "Time", "Aljazeera", "NPR", "LA Times"], choice: .sources)
                    }.font(.headline).background(Color.purple).cornerRadius(10.0).foregroundColor(.white).padding()
                }
            }.navigationBarTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ViewModel())
    }
}
