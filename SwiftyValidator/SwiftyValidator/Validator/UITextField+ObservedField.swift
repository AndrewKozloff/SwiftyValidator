//
//  UITextField+ObservedField.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 08.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import UIKit

extension UITextField: ObservedField {
	
	var validatedText: String {
		text ?? ""
	}
	
	var notificationDidChangeText: Notification.Name {
		UITextField.textDidChangeNotification
	}
	
	var notificationDidEndEditing: Notification.Name {
		UITextField.textDidEndEditingNotification
	}
}
