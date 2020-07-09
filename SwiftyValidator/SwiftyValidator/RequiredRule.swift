//
//  RequiredRule.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 08.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

class RequiredRule: ValidationRule {
	func validate(field: ValidatedField) -> Bool {
		!field.validatedText.isEmpty
	}
}
