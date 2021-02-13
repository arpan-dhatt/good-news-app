//
//  ShareSheet.swift
//  good-news-app
//
//  Created by Arpan Dhatt on 2/13/21.
//

import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {

    @EnvironmentObject var viewModel: ViewModel
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheetView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [NSURL(string: viewModel.sharingURL)!] as [Any],
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ShareSheetView>) {

    }
}
