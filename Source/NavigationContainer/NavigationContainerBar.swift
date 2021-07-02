//
//  NavigationContainerBar.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct NavigationContainerBar: View {
	@EnvironmentObject var coordinator: NavigationContainerCoordinator
	
	let viewPackage: NavigationContainerCoordinator.ViewPackage
	let title: String?
	var leading: AnyView?
	var trailing: AnyView?
	var color: Color?
	var showBackButton: Bool { coordinator.canGoBack(from: viewPackage) }
	
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
		.background(color)
	}
}
