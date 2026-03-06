//
//  ViewController.swift
//  TestNatife
//
//  Created by Nazar on 05.03.2026.
//

import SwiftUI
import UIKit

struct HomeVCPreview: UIViewControllerRepresentable {}

final class HomeVC: UIViewController {
    private let reuseIdentifier = "reuseIdentifier"
    private var collectionView: UICollectionView!
    private var diffableDataSource: UICollectionViewDiffableDataSource<Int,String>!
    private var expandedItems: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: -> Setup View
private extension HomeVC {
    func setup() {
        setupCollectionView()
        setupView()
        setupNavigationBar()
        setupLayout()
        configureDataSource()
        applySnapshot()
    }
    
    func setupView() {
        view.addSubviews(collectionView)
    }
    
    func setupNavigationBar() {
        title = "Title"
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .separator
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}


//MARK: -> Setup CollectionViewLayout
private extension HomeVC {
    func createLayout() -> UICollectionViewLayout {
        
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(150)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(150)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 30
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

//MARK: -> Setup Layout
private extension HomeVC {
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



//MARK: -> UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

//MARK: -> UICollectionViewDiffableDataSource
private extension HomeVC {
    func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: self.reuseIdentifier,
                    for: indexPath) as? PostCell else {
                    return UICollectionViewCell()
                }
                        let isExpanded = self.expandedItems.contains(itemIdentifier)
                        cell.configure(isExpanded: isExpanded)
                        
                cell.buttonTapped = { [weak self] in
                    guard let self else { return }

                    if self.expandedItems.contains(itemIdentifier) {
                        self.expandedItems.remove(itemIdentifier)
                    } else {
                        self.expandedItems.insert(itemIdentifier)
                    }

                    let isExpanded = self.expandedItems.contains(itemIdentifier)
                    cell.configure(isExpanded: isExpanded)

                    self.collectionView.collectionViewLayout.invalidateLayout()
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent) {
                        self.collectionView.layoutIfNeeded()
                    }
                }
                
                return cell
            }
        )
    }
    
    func applySnapshot() {
            var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
            snapshot.appendSections([0])
            snapshot.appendItems(["p1", "p2", "p3"])
            diffableDataSource.apply(snapshot)
        }
}

//MARK: -> Preview
extension HomeVCPreview {
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: HomeVC())
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
    

#Preview {
    HomeVCPreview().ignoresSafeArea()
}

