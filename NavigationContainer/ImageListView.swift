//
//  ImageListView.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct ImageListView: View {
	let title: String
	let symbols: [Symbol]
	
	var body: some View {
		ZStack() {
			Color.yellow
				.edgesIgnoringSafeArea(.all)
			VStack() {
				ForEach(symbols) { symbol in
					if symbol.subs.isEmpty {
						NavigationContainerLink(destination: ImageDetailsView(symbol: symbol)) {
							VStack() {
								symbol.image
								Text(symbol.name)
							}
						}
					} else {
						NavigationContainerLink(destination: ImageListView(title: symbol.name, symbols: symbol.subs)) {
							HStack() {
								symbol.image
								Text(symbol.name)
							}
						}
					}
				}
			}
		}
		.navigationContainerTitle(title)
	}
}

struct ImageListView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListView(title: "Testing", symbols: model)
	}
}

