//
//  PasswordTextField.swift
//  Password
//
//  Created by Candi Chiu on 20.04.23.
//

import Foundation
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}

class PasswordTextField: UIView {
    
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeHolderText: String
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorLabel = UILabel()
    
    var customValidation: CustomValidation?
    var text: String? {
        get {
             return textField.text
        }
        
        set {
            textField.text = newValue
        }
        
    }
    
    // weak var: to avoid retain cycle
    weak var delegate: PasswordTextFieldDelegate?
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}

extension PasswordTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
     //   backgroundColor = .systemOrange
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false
        textField.placeholder = placeHolderText
        textField.keyboardType = .asciiCapable // This is to prevent emoji, special chars
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        // extra interaction
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorLabel.textColor = .systemRed
        errorLabel.text = "Your password must meet the requirements below"
        errorLabel.isHidden = true
        
        // Adjust font size to fit width
//        errorLabel.adjustsFontSizeToFitWidth = true
//        errorLabel.minimumScaleFactor = 0.8 // Reduce up to 80% but no more
        
        // Going multiline
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        // lock
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
            
        ])
        
        // textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1)
            
        ])
        
        // eye
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
        
        // CHCR
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        // divider
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
        
        // error message label
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4)
            
        ])
        
    }
}

extension PasswordTextField {
    @objc func togglePasswordView() {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }
}

extension PasswordTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }
    
    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // resign first responder
        return true
    }
}

// typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
// MARK: Validation
extension PasswordTextField {
    
    func validate() -> Bool {
        if let customValidation = customValidation,
           let customValidationResult = customValidation(text ?? ""),
           customValidationResult.0 == false {
           showError(customValidationResult.1)
           return false
        }
        clearError()
        return true
    }
    
    func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
