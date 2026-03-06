//
//  DetailVC.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import SwiftUI
import UIKit

struct DetailVCPreview: UIViewControllerRepresentable {}

final class DetailVC: UIViewController {
    private let scrollView = UIScrollView()
    private let contentContainer = UIView()
    private let imageMain = UIImageView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let likeLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let postId: Int
    
    private let vm = DetailViewModel()
    
    init(postId: Int) {
        self.postId = postId
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: -> Setup View
private extension DetailVC {
    func setup(){
        setupView()
        setupImage()
        setupLabel()
        setupNavigationBar()
        setupLayout()
        bindViewModel()
        vm.fetchPost(id: postId)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentContainer)
        contentContainer.addSubviews(
            imageMain,
            titleLabel,
            textLabel,
            likeLabel,
            dateLabel
        )
    }
    
    func setupImage() {
        imageMain.image = .imageNotFound
        imageMain.contentMode = .scaleAspectFill
        imageMain.clipsToBounds = true
    }
    
    func setupLabel() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = .max
        
        textLabel.textColor = .gray
        textLabel.contentMode = .top
        textLabel.numberOfLines = .max
        
        likeLabel.font = .systemFont(ofSize: 13)
        likeLabel.textColor = .gray
        
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .gray
    }
    
    func setupNavigationBar() {
        title = "Title"
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .separator
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func updateUI(with post: PostDetail) {
        let postDate = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        dateLabel.text = formatter.string(from: postDate)
        
        imageMain.loadImage(url: post.postImage)
        titleLabel.text = post.title
        textLabel.text = post.text
        likeLabel.text = "❤️\(post.likesCount)"
    }
    
    func bindViewModel() {
        vm.onPostLoaded = { [weak self] post in
            self?.updateUI(with: post)
        }
    }
}

//MARK: -> Setup Layout
private extension DetailVC {
    func setupLayout() {
        view.disableAutoresizing(
            scrollView,
            contentContainer,
            imageMain,
            titleLabel,
            textLabel,
            likeLabel,
            dateLabel
        )
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageMain.topAnchor.constraint(equalTo: contentContainer.safeAreaLayoutGuide.topAnchor),
            imageMain.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            imageMain.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            imageMain.heightAnchor.constraint(equalToConstant: 350),
            
            titleLabel.topAnchor.constraint(equalTo: imageMain.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20),
            
            likeLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            likeLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 20),
            likeLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: -> Preview
extension DetailVCPreview {
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: DetailVC(postId: 118))
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}


#Preview {
    DetailVCPreview().ignoresSafeArea()
}
