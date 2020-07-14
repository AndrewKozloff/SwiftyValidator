//
//  Validator.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 07.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import Foundation

protocol ValidatedField {
	var validatedText: String { get }
}

protocol ObservedField: ValidatedField {
	var notificationDidChangeText: Notification.Name { get }
	var notificationDidEndEditing: Notification.Name { get }
}

