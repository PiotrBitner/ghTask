//
//  MasterViewModel.swift
//  ghSearch
//
//  Created by Piotr Bitner on 19/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

// based on https://www.raywenderlich.com/4161005-mvvm-with-combine-tutorial-for-ios

import SwiftUI
import Combine

class MasterViewModel: ObservableObject, Identifiable  {
    
      @Published var textToSearch: String = "Tetris"
      @Published var dataSource: [DetailsViewModel] = []
      @Published var isSearching: Bool = false
      
      private var disposables = Set<AnyCancellable>()
      private var scheduler: DispatchQueue!
      private var fetcher: Fetcher?
    

    init(fetcher: Fetcher?,
         scheduler: DispatchQueue = DispatchQueue(label: "MasterViewModel")
    ) {
        self.fetcher = fetcher
        
        _ = $textToSearch
        //.dropFirst(1)
        .debounce(for: .seconds(0.85), scheduler: scheduler)
        .sink(receiveValue: fetchRepository(searchTerm: ))
        .store(in: &disposables)
       }
        
    func fetchRepository(searchTerm: String){
        DispatchQueue.main.async {
            self.isSearching = true
            self.dataSource = []
        }
        
       fetcher?.fetchRepository(searchTerm: searchTerm)
       .receive(on: DispatchQueue.main)
       .sink(
         receiveCompletion: { [weak self] value in
           guard let self = self else { return }
           switch value {
           case .failure(let error):
            print(error)
            self.dataSource = []
           case .finished:
             break
           }
            self.isSearching = false
         },
         receiveValue: { [weak self] repository in
           guard let self = self else { return }
            self.isSearching = false
           self.dataSource = repository.items!.map({ (item) -> DetailsViewModel in
               return DetailsViewModel(dataSource: item)
           })
       })
       .store(in: &disposables)
    }
}

class FakeMasterViewModel: MasterViewModel{
    
    init(){
        super.init(fetcher: nil)
        
        textToSearch = "Tetris"
        dataSource = []
        isSearching = false
        
    }
}
