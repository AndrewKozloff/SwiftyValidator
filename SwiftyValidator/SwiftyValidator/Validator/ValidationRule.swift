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
	/// Should not be empty
	case required
	/// Only letters
	case letters
	/// Only letters and digits
	case alphanumeric
	/// Only letters, digits and whitespaces
	case alphanumericWhitespaces
	/// Only digits
	case digits
	/// Only digits and whitespaces
	case digitsWhitespaces
	/// Email regular expression
	case email
	/// Phone regular expression like mask +7 (###) ###-##-##
	case phone
	/// Password regular expression: no length, at least one uppercase, at least one lowercase, at least one number.
	case password
	/// Date regular expression like masks ##.##.## or ##-##-## or ##/##/##
	case birthday
	/// Snils regular expression like mask ###-###-### ##
	case snils
	/// Minimum lenght of text
	case minLenght(Int)
	/// Maximum lenght of text
	case maxLength(Int)
	/// Custom regular expression
	case regular(String)
	/// Custom validation rule
	case custom(ValidationRule)
	
	func validate(field: ValidatedField) -> Bool {
		switch self {
		case .required:
			return !field.validatedText.isEmpty
		case .letters:
			let validatedSet = CharacterSet(charactersIn: field.validatedText)
			return CharacterSet.letters.isSuperset(of: validatedSet)
		case .alphanumeric:
			let validatedSet = CharacterSet(charactersIn: field.validatedText)
			return CharacterSet.alphanumerics.isSuperset(of: validatedSet)
		case .alphanumericWhitespaces:
			let validatedSet = CharacterSet(charactersIn: field.validatedText)
			let alphanumericWhitespaces = CharacterSet.alphanumerics.union(CharacterSet.whitespaces)
			return alphanumericWhitespaces.isSuperset(of: validatedSet)
		case .digits:
			let validatedSet = CharacterSet(charactersIn: field.validatedText)
			return CharacterSet.decimalDigits.isSuperset(of: validatedSet)
		case .digitsWhitespaces:
			let validatedSet = CharacterSet(charactersIn: field.validatedText)
			let digitsWhitespaces = CharacterSet.decimalDigits.union(CharacterSet.whitespaces)
			return digitsWhitespaces.isSuperset(of: validatedSet)
		case .email:
			let regex = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{1,64}(\\.[a-zA-Z]{2,6})+"
			return field.validatedText.range(of: regex, options: .regularExpression) != nil
		case .phone:
			let regex = "^\\+7\\s*\\(\\d{3}\\)\\s*\\d{3}\\-\\d{2}\\-\\d{2}"
			return field.validatedText.range(of: regex, options: .regularExpression) != nil
		case .password:
			let regex = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
			return field.validatedText.range(of: regex, options: .regularExpression) != nil
		case .birthday:
			let regex = "^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\\d\\d$"
			return field.validatedText.range(of: regex, options: .regularExpression) != nil
		case .snils:
			let regex = "^\\d{3}\\-\\d{3}\\-\\d{3} \\d{2}"
			return field.validatedText.range(of: regex, options: .regularExpression) != nil
		case .minLenght(let min):
			return field.validatedText.count >= min
		case .maxLength(let max):
			return field.validatedText.count <= max
		case .regular(let regex):
			return field.validatedText.range(of: regex, options: .regularExpression) != nil
		case .custom(let rule):
			return rule.validate(field: field)
		}
	}
}
