//
//  Model.swift
//  NavigationContainer
//
//  Created by Ben Gottlieb on 6/27/21.
//

import SwiftUI

extension Color {
	static func random() -> Color {
		[.red, .gray, .green, .yellow, .orange].randomElement()!
	}
}

struct Symbol: Identifiable {
	let name: String
	var id: String { name }
	var subs: [Symbol] = []
	var color: Color = .random()
	
	var image: Image {
		guard let first = subs.first else { return Image(systemName: name) }
		return first.image
	}
}

let model = [
	Symbol(name: "Arrows", subs: [
		Symbol(name: "Plain", subs: [
			Symbol(name: "arrow.up"), Symbol(name: "arrow.left"), Symbol(name: "arrow.right"), Symbol(name: "arrow.down"),
		]),
		Symbol(name: "Circled", subs: [
			Symbol(name: "arrow.up.circle"), Symbol(name: "arrow.left.circle"), Symbol(name: "arrow.right.circle"), Symbol(name: "arrow.down.circle"),
		])

	])
]
