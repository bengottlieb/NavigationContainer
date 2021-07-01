//
//  NavigationContainerPage.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct NavigationContainerPage: View {
	let content: NavigationContainerCoordinator.ViewPackage
	@State var navigationBarHidden = false
	@State var navigationBarTitle: String?
	
	var body: some View {
		VStack() {
			if !navigationBarHidden {
				NavigationContainerBar(title: navigationBarTitle)
			}
			content.view
				.frame(maxHeight: .infinity)
				.frame(maxWidth: .infinity)
				.background(Color.blue)
		}
		.background(Color.white)
		.id(content.id)
		.onPreferenceChange(NavigationContainerBarHiddenKey.self) { hidden in
			navigationBarHidden = hidden
		}
		.onPreferenceChange(NavigationContainerTitleKey.self) { title in
			navigationBarTitle = title
		}
	}
	
}

