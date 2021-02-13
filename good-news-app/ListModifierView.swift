//
//  ListModifierView.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

struct StringListModifierView: View {
    @Binding var list: [String]
    
    var body: some View {
        VStack {
            List {
                ForEach(list, id: \.self) {item in
                    Text(item)
                }
            }
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        list.remove(atOffsets: offsets)
    }
    
    private func onAdd() {
        list.append("hello")
    }
    
}

struct ListModifierView_Previews: PreviewProvider {
    static var previews: some View {
        StringListModifierView(list: .constant(["one", "two", "three"]))
    }
}
