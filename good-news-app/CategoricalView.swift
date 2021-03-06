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
    
    var allColors = [Color("red1"), Color("blue1"), Color("purple1"), Color("orange1"), Color.blue, Color.red, Color.black, Color.green, Color.purple, Color.orange, Color.pink, Color.blue, Color.red, Color.black]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.user.categories.enumerated()).map({$0}), id: \.element) {index, category in
                    NavigationLink(destination: CategoryList(category: category).navigationBarTitle(category)) {
                        VStack{
                            Text("\(category)").font(.title).bold().padding()
                        }.font(.headline).background(allColors[index]).cornerRadius(10.0).foregroundColor(.white).padding()
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
