//
//  NavigationContainer+Coordinator.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

public class NavigationContainerCoordinator: ObservableObject {
	var stack: [ViewPackage] = []
	var isPushing = false
	var isAnimating = false

	struct ViewPackage: Equatable {
		let view: AnyView
		let id: String
		let isRoot: Bool
		var animation: Animation? {
			if isRoot {
				return nil
			}
			return .easeIn
		}
		
		init<Content: View>(_ view: Content, id: String? = nil, isRoot: Bool = false) {
			self.view = AnyView(view)
			self.id = id ?? UUID().uuidString
			self.isRoot = isRoot
		}
		static func ==(lhs: ViewPackage, rhs: ViewPackage) -> Bool { lhs.id == rhs.id }
	}
	
	var top: ViewPackage? { stack.last }
	var behindTop: ViewPackage? { stack.count > 1 ? stack[stack.count - 2] : nil }
	func canGoBack(from view: ViewPackage) -> Bool {
		guard let index = stack.firstIndex(of: view) else { return false }
		return index > 0 
	}
	var canGoBack: Bool { stack.count > 1 }
	
	public func pop(animated: Bool = true) {
		isPushing = false
		isAnimating = animated
		if stack.count > 1 {
			if animated {
				withAnimation(.linear(duration: 1)) {
					stack.removeLast()
					self.objectWillChange.send()
				}
			} else {
				stack.removeLast()
				self.objectWillChange.send()
			}
		}
	}
	
	public func push<Destination: View>(animated: Bool = true, id: String? = nil, isRoot: Bool = false, to destination: @escaping () -> Destination) {
		let newView = ViewPackage(destination(), id: id, isRoot: isRoot)
		if stack.contains(newView) { return }
		isPushing = true
		isAnimating = animated
		
		withAnimation(.linear(duration: animated ? 1 : 0)) {
			stack.append(newView)
			self.objectWillChange.send()
		}
	}
}

extension NavigationContainerCoordinator {
	static let placeholder = NavigationContainerCoordinator()
}
