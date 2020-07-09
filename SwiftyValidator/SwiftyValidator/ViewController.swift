//
//  ViewController.swift
//  SwiftyValidator
//
//  Created by Андрей Козлов on 07.07.2020.
//  Copyright © 2020 Андрей Козлов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			validateButton, phoneTextField, phoneErrorLabel, nameTextField, nameErrorLabel, passwordTextField, passwordErrorLabel
		])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 20
		return stack
	}()
	
	@Validated([.required, .phone])
	private var phoneTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Номер телефона"
		textField.backgroundColor = .white
		textField.layer.borderColor = UIColor.red.cgColor
		return textField
	}()
	
	private lazy var phoneErrorLabel: UILabel = {
		let label = UILabel()
		label.textColor = .red
		label.isHidden = true
		return label
	}()
	
	@Validated([.custom(RequiredRule())])
	private var nameTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Имя"
		textField.backgroundColor = .white
		textField.layer.borderColor = UIColor.red.cgColor
		return textField
	}()
	
	private lazy var nameErrorLabel: UILabel = {
		let label = UILabel()
		label.textColor = .red
		label.isHidden = true
		return label
	}()
	
	@Validated([.required])
	private var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Пароль"
		textField.backgroundColor = .white
		textField.layer.borderColor = UIColor.red.cgColor
		return textField
	}()
	
	private lazy var passwordErrorLabel: UILabel = {
		let label = UILabel()
		label.textColor = .red
		label.isHidden = true
		return label
	}()
	
	private lazy var validateButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .black
		button.addTarget(self, action: #selector(onValidateButtonTap), for: .touchUpInside)
		button.setTitle("VALIDATE", for: .normal)
		return button
	}()
		
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemGray
		
		view.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			
			phoneTextField.heightAnchor.constraint(equalToConstant: 50),
			nameTextField.heightAnchor.constraint(equalToConstant: 50),
			passwordTextField.heightAnchor.constraint(equalToConstant: 50),
			validateButton.heightAnchor.constraint(equalToConstant: 50)
		])
		
		$phoneTextField.onValidate = { rule in
			guard let rule = rule else {
				self.phoneErrorLabel.isHidden = true
				self.phoneTextField.layer.borderWidth = 0
				return
			}
			switch rule {
			case .required:
				self.phoneErrorLabel.text = "Обязательное поле"
			case .phone:
				self.phoneErrorLabel.text = "Номер должен состоять только из цифр"
			default:
				break
			}
			self.phoneErrorLabel.isHidden = false
			self.phoneTextField.layer.borderWidth = 1
		}
		
		$nameTextField.onValidate = { rule in
			guard let rule = rule else {
				self.nameErrorLabel.isHidden = true
				self.nameTextField.layer.borderWidth = 0
				return
			}
			switch rule {
			case .custom(let customRule) where customRule is RequiredRule:
				self.nameErrorLabel.text = "Обязательное поле (CustomRule)"
			default:
				break
			}
			self.nameErrorLabel.isHidden = false
			self.nameTextField.layer.borderWidth = 1
		}
		
		$passwordTextField.onValidate = { rule in
			guard let rule = rule else {
				self.passwordErrorLabel.isHidden = true
				self.nameTextField.layer.borderWidth = 0
				return
			}
			switch rule {
			case .required:
				self.passwordErrorLabel.text = "Обязательное поле"
			case .password:
				self.passwordErrorLabel.text = "Требуется не менее 8 символов"
			default:
				break
			}
			self.passwordErrorLabel.isHidden = false
			self.nameTextField.layer.borderWidth = 1
		}
	}

	@objc
	private func onValidateButtonTap(sender: UIButton) {
		if let phoneRule = $phoneTextField.validate() {
			switch phoneRule {
			case .required:
				phoneErrorLabel.text = "Обязательное поле"
			case .phone:
				phoneErrorLabel.text = "Номер должен состоять только из цифр"
			default:
				break
			}
			phoneErrorLabel.isHidden = false
			return
		}
		phoneErrorLabel.isHidden = true
		
		if let nameRule = $nameTextField.validate() {
			switch nameRule {
			case .custom(let rule) where rule is RequiredRule:
				nameErrorLabel.text = "Обязательное поле (CustomRule)"
			default:
				break
			}
			nameErrorLabel.isHidden = false
			return
		}
		nameErrorLabel.isHidden = true
		
		if let passwordRule = $passwordTextField.validate() {
			switch passwordRule {
			case .required:
				passwordErrorLabel.text = "Обязательное поле"
//			case .password:
//				passwordErrorLabel.text = "Требуется не менее 8 символов"
			default:
				break
			}
			passwordErrorLabel.isHidden = false
			return
		}
		passwordErrorLabel.isHidden = true

	}
}

