//
//  UITextView+ObservedField.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 09.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import UIKit

extension UITextView: ObservedField {
	
	var validatedText: String {
		text ?? ""
	}
	
	var notificationName: Notification.Name {
		UITextView.textDidChangeNotification
	}
}
