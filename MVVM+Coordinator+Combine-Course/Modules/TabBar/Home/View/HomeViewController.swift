//
//  HomeViewController.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    var infoLabel: UILabel?
    var viewModel: HomeViewModel!
    var showDetailRequested: () -> () = { }
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupInfoLabel()
        setupDetailButton()
        container.resolve(TabBarManager.self)?.switchState.sink(receiveValue: { [ self] isOn in
            print(isOn)
            self.view.overrideUserInterfaceStyle = isOn ? .dark : .light
        }).store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupDetailButton() {
        let button = UIButton(frame: CGRect(x: 100,y: 500,width: 200,height: 60))
        button.setTitleColor(.systemBlue,for: .normal)
        button.setTitle("Go to edit",for: .normal)
        button.addTarget(self,action: #selector(buttonAction),for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func setupInfoLabel() {
        let infoLabel = UILabel(frame: CGRect(x: 100, y: 300, width: 300, height: 60))
        self.view.addSubview(infoLabel)
        self.infoLabel = infoLabel
        
        viewModel.$surname.combineLatest(viewModel.$name)
            .sink { [weak self] (surname, name) in
                if name.count + surname.count > 0 {
                    self?.infoLabel?.text = "\(name) \(surname)"
                } else {
                    self?.infoLabel?.text = ""
                }
            }
            .store(in: &subscriptions)
    }
    
    
    @objc
    func buttonAction() {
        showDetailRequested()
    }
}
