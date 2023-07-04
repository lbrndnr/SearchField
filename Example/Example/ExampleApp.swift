//
//  ExampleApp.swift
//  Example
//
//  Created by Laurin Brandner on 03.07.23.
//

import SwiftUI
import SearchField

@main
struct ExampleApp: App {
    
    @State private var query = ""
    
    var body: some Scene {
        WindowGroup {
            content()
        }
    }
    
    @ViewBuilder private func content() -> some View {
        var container = AttributeContainer()
        container.foregroundColor = .blue
        container.backgroundColor = .green
        
        return SearchField("􀊫 Search", text: $query)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 250)
            .qualifier("lang", attributes: container)
    }
    
}
