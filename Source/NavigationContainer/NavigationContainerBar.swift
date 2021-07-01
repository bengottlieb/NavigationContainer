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
	var leading: AnyView?
	var trailing: AnyView?
	var showBackButton: Bool { coordinator.canGoBack }
	
	var body: some View {
		ZStack() {
			HStack() {
				if showBackButton {
					Button(action: { coordinator.pop() }) {
						Image(systemName: "chevron.left")
							.padding()
					}
				}
				if let leading = leading { leading.padding(showBackButton ? [] : [.horizontal]) }
				Spacer()
				if let trailing = trailing { trailing.padding(.horizontal) }
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
