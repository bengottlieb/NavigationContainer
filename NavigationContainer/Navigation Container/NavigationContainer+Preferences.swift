//
//  NavigationContainer+Preferences.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct NavigationContainerTitleKey: PreferenceKey {
	static var defaultValue: String? = nil
	
	static func reduce(value: inout String?, nextValue: () -> String?) {
		value = value ?? nextValue()
	}
}

struct NavigationContainerBarHiddenKey: PreferenceKey {
	static var defaultValue: Bool = false
	
	static func reduce(value: inout Bool, nextValue: () -> Bool) {
		value = value || nextValue()
	}
}

public extension View {
	func navigationContainerTitle(_ title: String?) -> some View {
		self
			.preference(key: NavigationContainerTitleKey.self, value: title)
	}

	func navigationContainerBarHidden(_ hidden: Bool) -> some View {
		self
			.preference(key: NavigationContainerBarHiddenKey.self, value: hidden)
	}
}
