//
//  HomeVC.swift
//  NetflixStyleSampleApp
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit
import SwiftUI

class HomeVC: UICollectionViewController {
    
    var contents: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        self.contents = getContents()
        configureCollectionCell()
    }
    
    private func configureCollectionCell() {
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: "ContentCell")
        collectionView.register(ContentRankCell.self, forCellWithReuseIdentifier: "ContentRankCell")
        
        // Header 설정
        collectionView.register(ContentHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentHeader")
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func configureNavigationBar() {
        // 네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true // 스크롤 시 navigationBar 숨기기
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "netflix_icon"), style: .plain, target: nil, action: nil)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return [] }
        return list
    }
    
    private func layout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionNum, env -> NSCollectionLayoutSection? in
            switch self.contents[sectionNum].sectionType {
            case .basic:
                return self.createBasicTypeSeciton()

            case .large:
                return self.createLargeTypeSection()
                
            case .rank:
                return self.createRankTypeSection()
                
            default: return nil
            }
        }
    }
    
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)

        // 헤더 설정
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)

        // 헤더 설정
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    private func createBasicTypeSeciton() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)

        // 헤더 설정
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}

extension HomeVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if contents[section].sectionType == .basic || contents[section].sectionType == .large || contents[section].sectionType == .rank {
            switch section {
            case 0:
                return 1
            default:
                return contents[section].contentItem.count
            }
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as? ContentCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
            
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentRankCell", for: indexPath) as? ContentRankCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            cell.rankLabel.text = "\(indexPath.item + 1)"
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("Test: \(sectionName)섹션, \(indexPath.item)번 콘텐츠")
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentHeader", for: indexPath) as? ContentHeader else { fatalError("Could not dequeue Header") }
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}

// SwiftUI를 활용한 미리보기
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewFlowLayout()
            let homeViewController = HomeVC(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
        typealias UIViewControllerType = UIViewController
    }
}