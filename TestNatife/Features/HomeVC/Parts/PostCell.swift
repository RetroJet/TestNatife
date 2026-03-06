//
//  PostCell.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import UIKit

final class PostCell: UICollectionViewCell {
    private let title = UILabel()
    private let text = UILabel()
    private let like = UILabel()
    private let date = UILabel()
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
        date.text = formatter.string(from: postDate)
        
        title.text = post.title
        text.text = post.previewText
        like.text = "❤️\(post.likesCount)"
        text.numberOfLines = isExpanded ? 0 : 2
        buttonCell.setTitle(isExpanded ? "Collapse" : "Expand", for: .normal)
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
            title,
            text,
            like,
            date,
            buttonCell
        )
    }
    
    func setupLabel() {
        title.font = .boldSystemFont(ofSize: 20)
        title.numberOfLines = .max
    
        text.textColor = .gray
        text.clipsToBounds = true
        
        like.font = .systemFont(ofSize: 13)
        like.textColor = .gray
        text.contentMode = .top
        
        date.font = .systemFont(ofSize: 13)
        date.textColor = .gray
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
            title,
            text,
            like,
            date,
            buttonCell
        )
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            like.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            like.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            date.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            buttonCell.topAnchor.constraint(equalTo: like.bottomAnchor, constant: 20),
            buttonCell.heightAnchor.constraint(equalToConstant: 45),
            buttonCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buttonCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buttonCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
