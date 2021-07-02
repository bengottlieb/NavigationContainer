//
//  NavigationContainer.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

public struct NavigationContainer<Content: View>: View {
	@StateObject var coordinator = NavigationContainerCoordinator()
	let content: () -> Content
	
	init(content: @escaping () -> Content) {
		self.content = content
	}
	
	var currentTransition: AnyTransition {
		if coordinator.isPushing {
			return AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
		} else {
			return AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
		}
	}
	
	var currentAnimation: Animation? {
		if coordinator.top?.isRoot == false || (!coordinator.isPushing && coordinator.isAnimating) {
			return .easeIn(duration: 0.2)
		} else {
			return nil
		}
	}
	
	public var body: some View {
		ZStack() {
			Color.green
				.edgesIgnoringSafeArea(.all)
			
			if let behindTop = coordinator.behindTop {
				NavigationContainerPage(content: behindTop)
					.transition(.opacity)
					.zIndex(1)
			}
			
			if let top = coordinator.top {
				NavigationContainerPage(content: top)
					.animation(currentAnimation)
					.transition(currentTransition)
					.zIndex(2)
			}
		}
		.onAppear() {
			coordinator.push(animated: false, isRoot: true, to: content)
		}
		.environmentObject(coordinator)
    }
}

struct NavigationContainer_Previews: PreviewProvider {
    static var previews: some View {
		NavigationContainer() {
			Text("Hello")
		}
    }
}

