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
	let background: Color
	@EnvironmentObject var coordinator: NavigationContainerCoordinator

	func back() {
		coordinator.pop()
	}

	var body: some View {
		ZStack() {
			background
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
						NavigationContainerLink(destination: ImageListView(title: symbol.name, symbols: symbol.subs, background: symbol.color)) {
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
		.navigationContainerBarItems(leading: HStack() {
			if coordinator.canGoBack { Button(action: back) { Text("Back") } }
		})
		.navigationContainerBarColor(background.opacity(0.5))

	}
}

struct ImageListView_Previews: PreviewProvider {
	static var previews: some View {
		ImageListView(title: "Testing", symbols: model, background: .red)
	}
}

