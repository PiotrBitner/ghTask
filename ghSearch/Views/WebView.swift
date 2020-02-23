//
//  WebView.swift
//  ghSearch
//
//  Created by Piotr Bitner on 21/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//
//  based on Copyright © 2019 Brad Hilton.

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}


