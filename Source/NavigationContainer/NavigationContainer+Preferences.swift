//
//  NavigationContainer+Preferences.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

struct NavigationContainterViewWrapper: Equatable {
	var view: AnyView?
	var id: String?
	static func ==(lhs: NavigationContainterViewWrapper, rhs: NavigationContainterViewWrapper) -> Bool {
		lhs.id == rhs.id
	}
	
	init<Content: View>(_ view: Content) {
		self.view = AnyView(view)
		self.id = "\(view)"
	}
}

struct NavigationContainerTitleKey: PreferenceKey {
	static var defaultValue: String? = nil
	static func reduce(value: inout String?, nextValue: () -> String?) { value = value ?? nextValue() }
}

struct NavigationContainerBarHiddenKey: PreferenceKey {
	static var defaultValue: Bool = false
	static func reduce(value: inout Bool, nextValue: () -> Bool) { value = value || nextValue() }
}

struct NavigationContainerBarItemsLeadingKey: PreferenceKey {
	static var defaultValue: NavigationContainterViewWrapper?
	static func reduce(value: inout NavigationContainterViewWrapper?, nextValue: () -> NavigationContainterViewWrapper?) { value = value ?? nextValue() }
}

struct NavigationContainerBarItemsTrailingKey: PreferenceKey {
	static var defaultValue: NavigationContainterViewWrapper?
	static func reduce(value: inout NavigationContainterViewWrapper?, nextValue: () -> NavigationContainterViewWrapper?) { value = value ?? nextValue() }
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
	
	func navigationContainerBarItems<Items: View>(leading: Items) -> some View {
		self
			.preference(key: NavigationContainerBarItemsLeadingKey.self, value: NavigationContainterViewWrapper(leading))
	}
	
	func navigationContainerBarItems<Items: View>(trailing: Items) -> some View {
		self
			.preference(key: NavigationContainerBarItemsTrailingKey.self, value: NavigationContainterViewWrapper(trailing))
	}
	
	func navigationContainerBarItems<Leading: View, Trailing: View>(leading: Leading, trailing: Trailing) -> some View {
		self
			.preference(key: NavigationContainerBarItemsLeadingKey.self, value: NavigationContainterViewWrapper(leading))
			.preference(key: NavigationContainerBarItemsTrailingKey.self, value: NavigationContainterViewWrapper(trailing))
	}

}
