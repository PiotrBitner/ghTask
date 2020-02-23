//
//  MasterView.swift
//  ghSearch
//
//  Created by Piotr Bitner on 19/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

import SwiftUI
import Combine

struct MasterView: View {
    
    @ObservedObject var viewModel: MasterViewModel
    
    init(viewModel: MasterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                self.searchField
                if self.viewModel.isSearching {
                    VStack {
                        Text("Searching...")
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                }
                
                if self.viewModel.dataSource.isEmpty {
                    self.emptySection
                } else {
                    self.resultsSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("🌐 Repository")
            .navigationViewStyle(StackNavigationViewStyle())
        }
        //.navigationViewStyle(StackNavigationViewStyle())
       
    }
}

private extension MasterView {
    
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("text to search", text: $viewModel.textToSearch)
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
    
    var resultsSection: some View {
        Section {
            ForEach(viewModel.dataSource) { detailViewModel in
                NavigationLink( destination: DetailView(viewModel: detailViewModel)){
                    RepositoryRowView.init(viewModel: detailViewModel)
                }
            }
        }
    }
}

struct MasterView_Previews: PreviewProvider {
    static let fakeViewModel: FakeMasterViewModel = FakeMasterViewModel()
    static var previews: some View {
        MasterView(viewModel: fakeViewModel)
    }
}

