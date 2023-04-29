//
//  OtherExampleTableViewCell.swift
//  MVVM+Coordinator+Combine-Course
//
//  Created by Eren Demir on 23.04.2023.
//

import UIKit

class OtherExamplesTableViewCell: UITableViewCell {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 25)
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

}

extension OtherExamplesTableViewCell {
    private func configureCell() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo:self.topAnchor,constant: 8),
            containerView.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -8),
            containerView.leftAnchor.constraint(equalTo:self.leftAnchor,constant: 8),
            containerView.rightAnchor.constraint(equalTo:self.rightAnchor,constant: -8),

            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

extension OtherExamplesTableViewCell {
    func setCell(title: String) {
        titleLabel.text = title.capitalized
    }
}
