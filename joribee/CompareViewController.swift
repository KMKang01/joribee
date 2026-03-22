//
//  CompareViewController.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 두 견적을 부품별로 비교하는 화면
class CompareViewController: UIViewController {

    // 비교할 견적 A
    var buildA: Build?
    // 비교할 견적 B
    var buildB: Build?

    // 비교 결과를 표시하는 테이블뷰
    private let compareTableView = UITableView(frame: .zero, style: .insetGrouped)
    // 비교 결과 데이터 목록
    private var comparisons: [ComponentComparison] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "견적 비교"
        view.backgroundColor = .systemBackground
        setupTableView()
        loadComparisons()
    }

    // 테이블뷰를 생성하고 레이아웃을 설정하는 함수
    private func setupTableView() {
        compareTableView.delegate = self
        compareTableView.dataSource = self
        compareTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CompareCell")
        compareTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(compareTableView)

        NSLayoutConstraint.activate([
            compareTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            compareTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            compareTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            compareTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // 두 견적의 비교 결과를 로드하는 함수
    private func loadComparisons() {
        guard let buildA = buildA, let buildB = buildB else { return }
        comparisons = BuildStore.shared.compareBuilds(buildA, buildB)
        compareTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CompareViewController: UITableViewDataSource {

    // 섹션 수를 반환하는 함수 (부품 비교 + 총합)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // 섹션 제목을 반환하는 함수
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "부품별 비교"
        }
        return "합계"
    }

    // 각 섹션의 행 수를 반환하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return comparisons.count
        }
        return 1
    }

    // 각 행의 셀을 구성하여 반환하는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompareCell", for: indexPath)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        if indexPath.section == 0 {
            configureComparisonCell(cell, at: indexPath.row, formatter: formatter)
        } else {
            configureTotalCell(cell, formatter: formatter)
        }

        cell.selectionStyle = .none
        return cell
    }

    // 부품 비교 셀을 구성하는 함수
    private func configureComparisonCell(_ cell: UITableViewCell, at row: Int, formatter: NumberFormatter) {
        let comparison = comparisons[row]
        var content = cell.defaultContentConfiguration()
        content.text = comparison.category.rawValue

        let priceA = formatter.string(from: NSNumber(value: comparison.componentA?.price ?? 0)) ?? "0"
        let priceB = formatter.string(from: NSNumber(value: comparison.componentB?.price ?? 0)) ?? "0"
        let nameA = comparison.componentA?.name ?? "미선택"
        let nameB = comparison.componentB?.name ?? "미선택"

        content.secondaryText = "A: \(nameA) (\(priceA)원)\nB: \(nameB) (\(priceB)원)"
        content.secondaryTextProperties.numberOfLines = 0
        content.secondaryTextProperties.color = .secondaryLabel

        if comparison.priceDifference > 0 {
            content.image = UIImage(systemName: "arrow.up.circle.fill")
            content.imageProperties.tintColor = .systemRed
        } else if comparison.priceDifference < 0 {
            content.image = UIImage(systemName: "arrow.down.circle.fill")
            content.imageProperties.tintColor = .systemBlue
        } else {
            content.image = UIImage(systemName: "equal.circle.fill")
            content.imageProperties.tintColor = .systemGray
        }

        cell.contentConfiguration = content
    }

    // 합계 비교 셀을 구성하는 함수
    private func configureTotalCell(_ cell: UITableViewCell, formatter: NumberFormatter) {
        var content = cell.defaultContentConfiguration()
        let totalA = buildA?.totalPrice ?? 0
        let totalB = buildB?.totalPrice ?? 0
        let diff = totalB - totalA

        let priceA = formatter.string(from: NSNumber(value: totalA)) ?? "0"
        let priceB = formatter.string(from: NSNumber(value: totalB)) ?? "0"
        let diffStr = formatter.string(from: NSNumber(value: abs(diff))) ?? "0"

        content.text = "A: \(priceA)원  vs  B: \(priceB)원"

        if diff > 0 {
            content.secondaryText = "B가 \(diffStr)원 더 비쌈"
            content.secondaryTextProperties.color = .systemRed
        } else if diff < 0 {
            content.secondaryText = "A가 \(diffStr)원 더 비쌈"
            content.secondaryTextProperties.color = .systemBlue
        } else {
            content.secondaryText = "동일한 가격"
            content.secondaryTextProperties.color = .systemGray
        }

        cell.contentConfiguration = content
    }
}

// MARK: - UITableViewDelegate
extension CompareViewController: UITableViewDelegate {

    // 행 높이를 자동으로 설정하는 함수
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
