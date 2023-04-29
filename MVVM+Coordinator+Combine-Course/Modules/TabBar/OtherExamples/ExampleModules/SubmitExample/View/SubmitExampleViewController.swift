//
//  SubmitExampleViewController.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import UIKit
import Combine

class SubmitExampleViewController: UIViewController {

    let acceptedSwitch : UISwitch = {
        let switchA = UISwitch()
        switchA.translatesAutoresizingMaskIntoConstraints = false
        return switchA
    }()


    let privacySwitch : UISwitch = {
        let switchP = UISwitch()
        switchP.translatesAutoresizingMaskIntoConstraints = false
        return switchP
    }()
    
    let nameField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let submitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.isEnabled = false
        return button
    }()
    
    @Published private var acceptedTerms = false
    @Published private var acceptedPrivacy = false
    @Published private var name = ""
    
    private var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
            .map { terms, privacy, name in
                return terms && privacy && !name.isEmpty
            }.eraseToAnyPublisher()
    }

    private var buttonSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        nameField.delegate = self
        buttonSubscriber = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: submitButton)
    }
    
    @objc func acceptTerms(_ sender: UISwitch) {
        acceptedTerms = sender.isOn
    }
    
    @objc func acceptPrivacy(_ sender: UISwitch) {
        acceptedPrivacy = sender.isOn
    }
    
    @objc func nameChanged(_ sender: UITextField) {
        name = sender.text ?? ""
    }
    
    @objc func didTapButton() {
        print("sa")
    }
    
    func setupUI(){
        view.addSubview(acceptedSwitch)
        view.addSubview(privacySwitch)
        view.addSubview(nameField)
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        nameField.addTarget(self, action: #selector(nameChanged(_:)), for: .editingChanged)
        privacySwitch.addTarget(self, action: #selector(acceptPrivacy), for: .valueChanged)
        acceptedSwitch.addTarget(self, action: #selector(acceptTerms), for: .valueChanged)
        NSLayoutConstraint.activate([
            acceptedSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            acceptedSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            privacySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacySwitch.topAnchor.constraint(equalTo: acceptedSwitch.bottomAnchor, constant: 20),
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: privacySwitch.bottomAnchor, constant: 20),
            nameField.widthAnchor.constraint(equalToConstant: 200),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
extension SubmitExampleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
