//
//  ImageDetailsView.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct ImageDetailsView: View {
	@EnvironmentObject var coordinator: NavigationContainerCoordinator
	let symbol: Symbol
	
	var body: some View {
		ZStack() {
			Color.red
				.edgesIgnoringSafeArea(.all)
			VStack() {
				HStack() {
					Spacer()
					Button(action: { coordinator.pop() }) {
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
}
