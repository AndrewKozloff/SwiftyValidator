//
//  ValidationRule.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 08.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import Foundation

protocol ValidationRule {
	func validate(field: ValidatedField) -> Bool
}

/**
	The possible validation rules.

	If you need to use a custom rule, you should
	create an object that implements the `ValidationRule` protocol
	and transfer it using `ValidationRules.custom()`.

    For example:
	~~~
	class RequiredRule: ValidationRule {
		func validate(field: ValidatedField) -> Bool {
			!field.validatedText.isEmpty
		}
	}
	~~~
*/
enum ValidationRules: ValidationRule {
	case required
	case email
	case phone
	case password
	case custom(ValidationRule)
	
	func validate(field: ValidatedField) -> Bool {
		switch self {
		case .required:
			return !field.validatedText.isEmpty
		case .email:
			let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
			return false
		case .phone:
			return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: field.validatedText))
		case .password:
			return field.validatedText.count >= 8
		case .custom(let rule):
			return rule.validate(field: field)
		}
	}
}
