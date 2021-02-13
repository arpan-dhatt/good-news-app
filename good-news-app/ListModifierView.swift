//
//  ListModifierView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

enum ModifierChoice {
    case categories
    case sources
}

struct StringListModifierView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    
    var choices: [String]
    
    var choice: ModifierChoice
    
    var body: some View {
        VStack(spacing: 10) {
                ForEach(choices, id: \.self) {item in
                    HStack {
                        Text(item)
                        Spacer()
                        if choice == .categories {
                            Image(systemName: viewModel.user.categories.contains(item) ? "minus.circle.fill" : "plus.circle.fill").foregroundColor(viewModel.user.categories.contains(item) ? Color.red : Color.green).transition(.scale)
                        } else {
                            Image(systemName: viewModel.user.sources.contains(item) ? "minus.circle.fill" : "plus.circle.fill").foregroundColor(viewModel.user.sources.contains(item) ? Color.red : Color.green).transition(.scale)
                        }
                        
                    }.padding().padding(.horizontal, 4)
                    .onTapGesture {
                        withAnimation(.interpolatingSpring(stiffness: 0.1, damping: 0.1)) {
                            if choice == .categories {
                                if viewModel.user.categories.contains(item) {
                                    viewModel.user.categories.remove(at: viewModel.user.categories.firstIndex(of: item)!)
                                } else {
                                    viewModel.user.categories.append(item)
                                }
                            } else {
                                if viewModel.user.sources.contains(item) {
                                    viewModel.user.sources.remove(at: viewModel.user.sources.firstIndex(of: item)!)
                                } else {
                                    viewModel.user.sources.append(item)
                                }
                            }
                            
                        }
                    }
                }
            }
    }
    
}

struct ListModifierView_Previews: PreviewProvider {
    static var previews: some View {
        StringListModifierView(choices: ["Business", "Science", "Sports"], choice: .categories).environmentObject(ViewModel())
    }
}
