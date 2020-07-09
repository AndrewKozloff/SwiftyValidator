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
	
	private var observer: NSObjectProtocol?

    private var rules: [ValidationRules]

    init(wrappedValue value: Value, _ rules: [ValidationRules]) {
        wrappedValue = value
        self.rules = rules
    }
	
	deinit {
		guard let observer = observer else { return }
		NotificationCenter.default.removeObserver(observer)
	}
	
	var onValidate: ((ValidationRules?) -> Void)? {
		didSet {
			if let observer = observer {
				NotificationCenter.default.removeObserver(observer)
			}
			guard let onValidate = onValidate else { return }
			observer = NotificationCenter.default.addObserver(
				forName: wrappedValue.notificationName,
				object: wrappedValue,
				queue: nil,
				using: { [weak self] _ in
					guard let self = self else { return }
					let rule = self.validate()
					onValidate(rule)
			})
		}
	}
	
	func validate() -> ValidationRules? {
		rules.first(where: { !$0.validate(field: wrappedValue) })
	}
}
