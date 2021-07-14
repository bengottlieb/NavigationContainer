//
//  NavigationContainerBackButton.swift
//  
//
//  Created by Ben Gottlieb on 7/14/21.
//

import SwiftUI

public struct NavigationContainerBackButton<Content: View>: View {
	@EnvironmentObject var coordinator: NavigationContainerCoordinator

	let content: () -> Content
	
	public init(content: @escaping () -> Content) {
		self.content = content
	}
	
	public var body: some View {
		if coordinator.canGoBack {
			Button(action: { coordinator.pop(animated: true) }) {
				content()
			}
		}
	}
}

struct NavigationContainerBackButton_Previews: PreviewProvider {
	static var previews: some View {
		NavigationContainerBackButton() { Text("Back") }
	}
}
