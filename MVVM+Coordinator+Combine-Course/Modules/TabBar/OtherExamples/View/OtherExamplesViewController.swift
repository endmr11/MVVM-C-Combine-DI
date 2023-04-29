//
//  SettingsViewController.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 9.04.2023.
//

import UIKit


protocol IHomeView: AnyObject {
    func setUpUI()
}


private enum OtherExampleConstant {
    static let cellReuseIdentifier = "OtherExampleTableViewCell"
    static let fontSize = 20.0
}

class OtherExamplesViewController: UIViewController {
    var didSelectRowAt: (_ index:Int) -> () = { _ in }
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(OtherExamplesTableViewCell.self, forCellReuseIdentifier: OtherExampleConstant.cellReuseIdentifier)
        return tableView
    }()
    
    var otherExampleList:[String] = ["Simple Example","Submit Example","SignUp Example"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
    }
}

extension OtherExamplesViewController:IHomeView {
    func setUpUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.centerYAnchor.constraint(equalTo:view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            tableView.heightAnchor.constraint(equalTo:view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo:view.widthAnchor),
            
        ])
    }
}

//MARK: - TableView DataSource
extension OtherExamplesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        otherExampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherExampleConstant.cellReuseIdentifier,for: indexPath) as? OtherExamplesTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(title: otherExampleList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - TableView Delegate
extension OtherExamplesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRowAt(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
