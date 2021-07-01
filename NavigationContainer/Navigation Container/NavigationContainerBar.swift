//
//  NavigationContainerBar.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct NavigationContainerBar: View {
	@EnvironmentObject var coordinator: NavigationContainerCoordinator

	let title: String?
	
	var body: some View {
		ZStack() {
			if coordinator.canGoBack {
				HStack() {
					Button(action: { coordinator.pop() }) {
						Image(systemName: "chevron.left")
							.padding()
					}
					Spacer()
				}
			}
			HStack() {
				if let title = title {
					Text(title)
				}
			}
		}
		.frame(height: 44)
	}
}
