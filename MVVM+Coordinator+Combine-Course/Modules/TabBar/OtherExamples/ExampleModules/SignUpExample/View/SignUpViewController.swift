//
//  SignUpViewController.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let repeatTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // UI StackView'unun oluşturulması
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var username: String = ""
    
    var validatedUsername: AnyPublisher<String?, Never> {
            return $username
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .removeDuplicates()
                .flatMap { username in
                    return Future { promise in
                        self.usernameAvailable(username) { available in
                            promise(.success(available ? username : nil))
                        }
                    }
                }
                .eraseToAnyPublisher()
        }

        func usernameAvailable(_ username: String, completion: (Bool) -> Void) {
            completion(true) // Our fake asynchronous backend service
        }

        var validatedPassword: AnyPublisher<String?, Never> {
            return Publishers.CombineLatest($password, $passwordAgain)
                .map { password, passwordRepeat in
                    guard password == passwordRepeat, password.count > 0 else { return nil }
                    return password
                }
                .map {
                    ($0 ?? "") == "password1" ? nil : $0
                }
                .eraseToAnyPublisher()
        }
        
        var validatedCredentials: AnyPublisher<(String, String)?, Never> {
            return Publishers.CombineLatest(validatedUsername, validatedPassword)
                .receive(on: RunLoop.main)
                .map { username, password in
                    guard let uname = username, let pwd = password else { return nil }
                    return (uname, pwd)
                }
                .eraseToAnyPublisher()
        }
        
        var createButtonSubscriber: AnyCancellable?

        private func setupButton() {

            nameTextField.delegate = self
            passwordTextField.delegate = self
            repeatTextField.delegate = self

            createButton.addTarget(self, action: #selector(createButtonTapped(_:)), for: .primaryActionTriggered)

            createButtonSubscriber = validatedCredentials
                .map { $0 != nil }
                .receive(on: RunLoop.main)
                .assign(to: \.isEnabled, on: createButton)
            
        }
        
        @objc private func createButtonTapped(_ sender: UIButton) {
            print("createButtonTapped!")
        }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupUI()
        setupButton()
        super.viewDidLoad()
    }
    
    
    func setupUI(){
        view.addSubview(stackView)
        [nameTextField, passwordTextField, repeatTextField, createButton].forEach { view in
            stackView.addArrangedSubview(view)
        }
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
extension SignUpViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = textField.text ?? ""
        let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == nameTextField { username = text }
        if textField == passwordTextField { password = text }
        if textField == repeatTextField { passwordAgain = text }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
