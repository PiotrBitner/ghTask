//
//  DateTool.swift
//  ghSearch
//
//  Created by Piotr Bitner on 20/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

import Foundation

//"2012-01-01T00:31:50Z" github data format
// it is required for githab response decodying
let githubFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
  return formatter
}()

// could be use in UI for more pleasent look
let simpleFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
  return formatter
}()

func dateString(date: Date) -> String {
        let formatter = githubFormatter
    return formatter.string(from: date)
}
