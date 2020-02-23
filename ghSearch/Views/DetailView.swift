//
//  DetailView.swift
//  ghSearch
//
//  Created by Piotr Bitner on 23/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let viewModel: DetailsViewModel
    var body: some View {
        WebView(request: URLRequest(url: URL(string:viewModel.dataSource.htmlURL)!))
            .navigationBarTitle(viewModel.dataSource.name)
    }
}
