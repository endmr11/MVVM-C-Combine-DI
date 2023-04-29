//
//  SimpleExampleViewController.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import UIKit
import Combine

extension Notification.Name {
    static let newBlogPost = Notification.Name("newPost")
}

struct BlogPost {
    let title: String
}


class SimpleExampleViewController: UIViewController {

    let blogTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()

    let publishButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Publish", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    let subscribedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You are subscribed!"
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    
    override func viewDidLoad(  ) {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .primaryActionTriggered)
        
        
        let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
         .map { (notification) -> String? in
             return (notification.object as? BlogPost)?.title ?? ""
         }
        
        let subscriber = Subscribers.Assign(object: subscribedLabel, keyPath: \.text)
        publisher.subscribe(subscriber)
        setupUI()
    }
    
    @objc func publishButtonTapped(_ sender: UIButton) {

        let title = blogTextField.text ?? "Coming soon"
        let blogPost = BlogPost(title: title)
        NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
    }
    
    func setupUI() {

        view.addSubview(blogTextField)
        view.addSubview(publishButton)
        view.addSubview(subscribedLabel)


        NSLayoutConstraint.activate([
            blogTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blogTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            blogTextField.widthAnchor.constraint(equalToConstant: 200),
            
            publishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            publishButton.topAnchor.constraint(equalTo: blogTextField.bottomAnchor, constant: 20),
            publishButton.widthAnchor.constraint(equalToConstant: 100),
            publishButton.heightAnchor.constraint(equalToConstant: 40),
            
            subscribedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subscribedLabel.topAnchor.constraint(equalTo: publishButton.bottomAnchor, constant: 20),
            subscribedLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}
