//
//  CategoricalView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/12/21.
//

import SwiftUI

struct CategoricalView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var showProfileView = false
    
    var allColors = [Color.black, Color.gray, Color.purple, Color.orange, Color.pink, Color.blue]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.user.categories, id: \.self) {category in
                    NavigationLink(destination: CategoryList(category: category).navigationBarTitle(category)) {
                        VStack{
                            Text("\(category)").font(.title).bold().padding()
                        }.font(.headline).background(Color.orange).cornerRadius(10.0).foregroundColor(.white).padding()
                    }
                }
            }.navigationBarTitle("Categories")
        }
    }
}

struct CategoricalView_Previews: PreviewProvider {
    static var previews: some View {
        CategoricalView().environmentObject(ViewModel())
    }
}
