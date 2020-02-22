//
//  RepositoryRowViewModel.swift
//  ghSearch
//
//  Created by Piotr Bitner on 19/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

import Foundation

class DetailsViewModel: ObservableObject, Identifiable {
    
    @Published var dataSource: Item
    
    init(dataSource: Item) {
       self.dataSource = dataSource
     }
    
}
