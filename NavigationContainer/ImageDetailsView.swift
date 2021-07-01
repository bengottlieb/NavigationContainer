//
//  ImageDetailsView.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct ImageDetailsView: View {
	let symbol: Symbol
	var body: some View {
		VStack() {
			HStack() {
				Spacer()
				Button(action: {}) {
					Image(systemName: "xmark")
						.padding()
				}
			}
			symbol.image
				.font(.system(size: 100))
		}
		.background(Color.purple)
		.navigationContainerBarHidden(true)
		.navigationContainerTitle("Not Shown")
	}
}
