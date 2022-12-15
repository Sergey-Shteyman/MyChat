//
//  CodeView.swift
//  MyChat
//
//  Created by Сергей Штейман on 15.12.2022.
//

import UIKit

// MARK: - CodeViewDelegate
protocol CodeViewDelegate: AnyObject {
    func didChange(_ code: String)
}

// MARK: - CodeView
final class CodeView: UIView {
    
    weak var delegate: CodeViewDelegate?
    
    private let robotoFont = RobotoFont.self

    private var textFields: [UITextField] = []

    private let stackView = make(UIStackView()) { myStackView in
        myStackView.axis = .horizontal
        myStackView.spacing = 5
        myStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private var code: String = "" {
        didSet {
            delegate?.didChange(code)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTextFields(count: Int) {
        var tags: [Int] = []

        for i in 1...count {
            tags.append(i)
        }

        textFields = tags.map { tag in
            self.makeTextField(tag: tag)
        }

        textFields.forEach {
            $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 43).isActive = true
        }

        stackView.addArrangedSubviews(textFields)

        let firstTag = 1
        textFields.first(where: { $0.tag == firstTag })?.becomeFirstResponder()
        enableTextField(tag: firstTag)
    }

    private func makeTextField(tag: Int) -> UITextField {
        make(UITextField()) { myTextField in
            myTextField.tag = tag
            myTextField.delegate = self
            myTextField.layer.borderColor = UIColor.black.cgColor
            myTextField.layer.borderWidth = 1
            myTextField.layer.cornerRadius = 8
            myTextField.keyboardType = .numberPad
            myTextField.font = UIFont(name: robotoFont.medium, size: 24)
            myTextField.textAlignment = .center
        }
    }

    private func enableTextField(tag: Int) {
        textFields.forEach {
            $0.isUserInteractionEnabled = $0.tag == tag
            
            $0.layer.borderColor = $0.tag == tag
            ? UIColor.systemBlue.cgColor
            : UIColor.gray.cgColor
        }
    }
    
    private func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate impl
extension CodeView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return false }

        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as? UITextField

        let previousTag = textField.tag - 1
        let previousResponder = textField.superview?.viewWithTag(previousTag) as? UITextField

        if text.isEmpty && !string.isEmpty {
            if textField.tag == 1 {
                code.removeAll()
            }
            if let nextResponder = nextResponder {
                enableTextField(tag: nextTag)
                nextResponder.becomeFirstResponder()
            }
            textField.text = string
            code += string

            return false
        } else if text.count >= 1 && string.isEmpty {
            if let previousResponder = previousResponder {
                enableTextField(tag: previousTag)
                previousResponder.becomeFirstResponder()
            }
            textField.text?.removeAll()
            code.removeLast()

            return false
        } else if text.count >= 1 {
            if let nextResponder = nextResponder {
                enableTextField(tag: nextTag)
                nextResponder.becomeFirstResponder()
                nextResponder.text = string
                code += string
            }
            return false
        } 
        return true
    }

}
