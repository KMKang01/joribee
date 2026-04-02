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

    // 상단 카테고리 필터용 컬렉션뷰 (Storyboard 연결)
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    // 빌드 카드 피드용 컬렉션뷰 (Storyboard 연결)
    @IBOutlet weak var buildCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        loadSampleData()
    }

    // 컬렉션뷰의 delegate, dataSource 및 셀 등록을 설정하는 함수
    private func setupCollectionViews() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.identifier
        )

        buildCollectionView.delegate = self
        buildCollectionView.dataSource = self
        buildCollectionView.register(
            BuildCardCell.self,
            forCellWithReuseIdentifier: BuildCardCell.identifier
        )

        // 카테고리 셀 자동 크기 조정 해제 (sizeForItemAt에서 직접 계산)
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
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
        } else {
            let selectedBuild = filteredBuilds[indexPath.item]
            guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "BuildDetailViewController") as? BuildDetailViewController else { return }
            detailVC.build = selectedBuild
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {

    // 컬렉션뷰별 셀 크기를 반환하는 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let text = categories[indexPath.item]
            let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)]).width
            return CGSize(width: ceil(textWidth) + 28, height: 34)
        }

        let width = collectionView.bounds.width - 32
        let imageHeight = width * 0.55
        let infoHeight: CGFloat = 140
        return CGSize(width: width, height: imageHeight + infoHeight)
    }
}
