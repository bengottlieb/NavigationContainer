//
//  NavigationContainerPage.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct NavigationContainerPage: View {
	@EnvironmentObject var coordinator: NavigationContainerCoordinator

	let content: NavigationContainerCoordinator.ViewPackage
	@State var navigationBarHidden = false
	@State var navigationBarTitle: String?
	@State var navigationBarLeadingItems: NavigationContainterViewWrapper?
	@State var navigationBarTrailingItems: NavigationContainterViewWrapper?
	@State var navigationContainerBarColor: Color?
	@State var backGestureOffset: CGFloat = 0

	#if targetEnvironment(simulator)
		let swipeGestureLeftMargin: CGFloat = 40
	#else
		let swipeGestureLeftMargin: CGFloat = 10
	#endif

	var isRoot: Bool { !coordinator.canGoBack(from: content) }

	var body: some View {
		VStack(spacing: 0) {
			if !navigationBarHidden {
				NavigationContainerBar(viewPackage: content, title: navigationBarTitle, leading: navigationBarLeadingItems?.view, trailing: navigationBarTrailingItems?.view, color: navigationContainerBarColor)
			}
			content.view
				.frame(maxHeight: .infinity)
				.frame(maxWidth: .infinity)
		}
		.id(content.id)
		.onPreferenceChange(NavigationContainerBarHiddenKey.self) { hidden in
			navigationBarHidden = hidden
		}
		.onPreferenceChange(NavigationContainerTitleKey.self) { title in
			navigationBarTitle = title
		}
		.onPreferenceChange(NavigationContainerBarItemsLeadingKey.self) { items in
			navigationBarLeadingItems = items
		}
		.onPreferenceChange(NavigationContainerBarItemsTrailingKey.self) { items in
			navigationBarTrailingItems = items
		}
		.onPreferenceChange(NavigationContainerBarColorKey.self) { color in
			navigationContainerBarColor = color
		}
		.offset(x: backGestureOffset)
		.gesture(isRoot ? nil : backPanGesture)
	}

	var backPanGesture: some Gesture {
		DragGesture()
			.onChanged { value in
				if isRoot || value.startLocation.x > swipeGestureLeftMargin { return }
				backGestureOffset = value.location.x
			}
			.onEnded { value in
				if isRoot || value.startLocation.x > swipeGestureLeftMargin { return }
				if value.predictedEndLocation.x > UIScreen.main.bounds.width / 2 {
					let duration: TimeInterval = 0.2
					withAnimation(.linear(duration: duration)) {
						backGestureOffset = UIScreen.main.bounds.width
					}
					DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
						withAnimation(nil) {
							coordinator.pop(animated: false)
							backGestureOffset = 0
						}
					}
				} else {
					withAnimation() {
						backGestureOffset = 0
					}
				}
			}
	}

}

