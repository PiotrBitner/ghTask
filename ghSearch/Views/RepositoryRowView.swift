//
//  RepositoryRowView.swift
//  ghSearch
//
//  Created by Piotr Bitner on 19/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

import SwiftUI

struct RepositoryRowView: View {
    
    var viewModel: DetailsViewModel?

    init(viewModel: DetailsViewModel?) {
      self.viewModel = viewModel
    }

    var body: some View {
        HStack {
        Text(viewModel?.dataSource.name ?? "name")
            Spacer()
            Text(String(viewModel?.dataSource.stargazersCount ?? 0))
        }
        .padding()
    }
}

struct RepositoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryRowView(viewModel: nil)
    }
}

