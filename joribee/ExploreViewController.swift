//
//  ExploreViewController.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 탐색 탭 - 인기 견적 및 목적별 베스트 빌드를 카드형 피드로 보여주는 화면
class ExploreViewController: UIViewController {

    // 전체 견적 데이터 원본 배열
    private var allBuilds: [Build] = []
    // 필터 적용 후 표시할 견적 배열
    private var filteredBuilds: [Build] = []
    // 카테고리 필터 목록 ("전체" 포함)
    private let categories: [String] = ["전체", "가성비 게이밍", "고사양 게이밍", "4K 영상 편집", "사무용", "디자인/3D", "스트리밍", "화이트 감성"]
    // 현재 선택된 카테고리 인덱스
    private var selectedCategoryIndex: Int = 0

    // 상단 카테고리 필터용 컬렉션뷰
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        return collectionView
    }()

    // 빌드 카드 피드용 컬렉션뷰
    private lazy var buildCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 20, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BuildCardCell.self, forCellWithReuseIdentifier: BuildCardCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "탐색"
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        loadSampleData()
    }

    // 서브뷰를 화면에 추가하는 함수
    private func setupSubviews() {
        view.addSubview(categoryCollectionView)
        view.addSubview(buildCollectionView)
    }

    // 오토레이아웃 제약 조건을 설정하는 함수
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // 카테고리 컬렉션뷰 (상단 고정, 높이 50)
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 50),

            // 빌드 컬렉션뷰 (카테고리 아래 ~ 하단)
            buildCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            buildCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buildCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buildCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // 샘플 데이터를 로드하고 컬렉션뷰에 반영하는 함수
    private func loadSampleData() {
        allBuilds = SampleData.createSampleBuilds()
        filteredBuilds = allBuilds
        buildCollectionView.reloadData()
    }

    // 선택된 카테고리에 따라 견적 목록을 필터링하는 함수
    private func filterBuilds(by categoryIndex: Int) {
        selectedCategoryIndex = categoryIndex

        if categoryIndex == 0 {
            filteredBuilds = allBuilds
        } else {
            let selectedCategory = categories[categoryIndex]
            filteredBuilds = allBuilds.filter { $0.category.rawValue == selectedCategory }
        }

        buildCollectionView.reloadData()
        categoryCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {

    // 컬렉션뷰별 셀 개수를 반환하는 함수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        }
        return filteredBuilds.count
    }

    // 컬렉션뷰별 셀을 구성하여 반환하는 함수
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            let isSelected = indexPath.item == selectedCategoryIndex
            cell.configure(with: categories[indexPath.item], isSelected: isSelected)
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuildCardCell.identifier, for: indexPath) as! BuildCardCell
        cell.configure(with: filteredBuilds[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {

    // 셀 탭 이벤트를 처리하는 함수
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            filterBuilds(by: indexPath.item)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {

    // 컬렉션뷰별 셀 크기를 반환하는 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 0, height: 34)
        }

        let width = collectionView.bounds.width - 32
        let imageHeight = width * 0.55
        let infoHeight: CGFloat = 140
        return CGSize(width: width, height: imageHeight + infoHeight)
    }
}
