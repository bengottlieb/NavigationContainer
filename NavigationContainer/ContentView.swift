//
//  ContentView.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
		NavigationContainer() {
			ImageListView(title: "Symbols", symbols: model, background: .purple)
		}
		.imageScale(.large)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
