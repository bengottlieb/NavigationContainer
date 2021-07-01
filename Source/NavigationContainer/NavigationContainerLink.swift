//
//  NavigationContainerLink.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

public struct NavigationContainerLink<Label: View, Destination: View>: View {
	@EnvironmentObject var coordinator: NavigationContainerCoordinator
	let label: () -> Label
	let destination: () -> Destination
	
	public init(destination: @escaping () -> Destination, label: @escaping () -> Label) {
		self.label = label
		self.destination = destination
	}

	public init(destination: Destination, label: @escaping () -> Label) {
		self.label = label
		self.destination = { destination }
	}

	func goToDestination() {
		coordinator.push(to: destination)
	}
	
	public var body: some View {
		Button(action: goToDestination) {
			label()
		}
	}
}

