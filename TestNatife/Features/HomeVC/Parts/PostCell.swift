//
//  PostCell.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import UIKit

final class PostCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let likeLabel = UILabel()
    private let dateLabel = UILabel()
    private let buttonCell = UIButton()
    
    var buttonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post, isExpanded: Bool) {
        let postDate = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        dateLabel.text = formatter.string(from: postDate)
        
        titleLabel.text = post.title
        likeLabel.text = "❤️\(post.likesCount)"
        
        textLabel.text = post.previewText
        textLabel.numberOfLines = isExpanded ? 0 : 2
        buttonCell.setTitle(isExpanded ? "Collapse" : "Expand", for: .normal)
        buttonCell.isHidden = post.previewText.count < 100
    }
}

//MARK: -> Setup View
private extension PostCell {
    func setup() {
        setupView()
        setupLabel()
        setupButton()
        setupLayout()
    }
    
    func setupView() {
        contentView.addSubviews(
            titleLabel,
            textLabel,
            likeLabel,
            dateLabel,
            buttonCell
        )
    }
    
    func setupLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = .max
        
        textLabel.textColor = .gray
        textLabel.clipsToBounds = true
        textLabel.contentMode = .top
        
        likeLabel.font = .systemFont(ofSize: 13)
        likeLabel.textColor = .gray
        
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .gray
    }
    
    func setupButton() {
        buttonCell.backgroundColor = .darkGray
        buttonCell.layer.cornerRadius = 10
        buttonCell.setTitle("Expand", for: .normal)
        buttonCell.addTarget(self, action: #selector(expandTapped), for: .touchUpInside)
    }
    
    @objc func expandTapped() {
        buttonTapped?()
    }
}

//MARK: -> Setup Layout
private extension PostCell {
    func setupLayout() {
        disableAutoresizing(
            titleLabel,
            textLabel,
            likeLabel,
            dateLabel,
            buttonCell
        )
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            likeLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            buttonCell.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 20),
            buttonCell.heightAnchor.constraint(equalToConstant: 45),
            buttonCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buttonCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buttonCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
