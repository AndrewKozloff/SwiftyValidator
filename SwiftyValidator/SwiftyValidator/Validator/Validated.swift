//
//  Validated.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 09.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import Foundation

@propertyWrapper
class Validated<Value: ObservedField> {

    var wrappedValue: Value
	
    var projectedValue: Validated<Value> {
        self
    }
	
	private var observers: [NSObjectProtocol] = []

    private var rules: [ValidationRules]

    init(wrappedValue value: Value, _ rules: [ValidationRules]) {
        wrappedValue = value
        self.rules = rules
    }
	
	deinit {
		observers.forEach(NotificationCenter.default.removeObserver)
	}
	
	var onChangeText: ((ValidationRules?) -> Void)? {
		didSet {
			guard let onChangeText = onChangeText else { return }
			let observer = NotificationCenter.default.addObserver(
				forName: wrappedValue.notificationDidChangeText,
				object: wrappedValue,
				queue: nil,
				using: { [weak self] _ in
					guard let self = self else { return }
					let rule = self.validate()
					onChangeText(rule)
			})
			observers.append(observer)
		}
	}
	
	var onEndEditing: ((ValidationRules?) -> Void)? {
		didSet {
			guard let onEndEditing = onEndEditing else { return }
			let observer = NotificationCenter.default.addObserver(
				forName: wrappedValue.notificationDidEndEditing,
				object: wrappedValue,
				queue: nil,
				using: { [weak self] _ in
					guard let self = self else { return }
					let rule = self.validate()
					onEndEditing(rule)
			})
			observers.append(observer)
		}
	}
	
	func validate() -> ValidationRules? {
		rules.first(where: { !$0.validate(field: wrappedValue) })
	}
}
