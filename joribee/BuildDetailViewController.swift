//
//  BuildDetailViewController.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 견적 상세 화면 - 선택한 빌드의 전체 부품 목록과 가격을 보여주는 화면
class BuildDetailViewController: UIViewController {

    // 표시할 견적 데이터 (Storyboard에서 인스턴스화 후 외부에서 주입)
    var build: Build?

    // 상단 대표 이미지뷰 (Storyboard 연결)
    @IBOutlet weak var headerImageView: UIImageView!
    // 카테고리 태그 레이블 (Storyboard 연결)
    @IBOutlet weak var categoryLabel: UILabel!
    // 견적 제목 레이블 (Storyboard 연결)
    @IBOutlet weak var titleLabel: UILabel!
    // 좋아요 수 레이블 (Storyboard 연결)
    @IBOutlet weak var likeCountLabel: UILabel!
    // 부품 목록 스택뷰 (Storyboard 연결)
    @IBOutlet weak var componentStackView: UIStackView!
    // 합계 금액 레이블 (Storyboard 연결)
    @IBOutlet weak var totalPriceLabel: UILabel!
    // "내 빌더로 가져오기" 버튼 (Storyboard 연결)
    @IBOutlet weak var importButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle()
        configureData()
        importButton.addTarget(self, action: #selector(importButtonTapped), for: .touchUpInside)
    }

    // 버튼의 둥근 모서리 스타일을 설정하는 함수
    private func setupButtonStyle() {
        importButton.layer.cornerRadius = 12
        importButton.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.clipsToBounds = true
    }

    // Build 데이터를 각 UI 요소에 바인딩하는 함수
    private func configureData() {
        guard let build = build else { return }

        headerImageView.image = UIImage(named: build.imageName) ?? UIImage(systemName: "desktopcomputer")
        categoryLabel.text = "  \(build.category.rawValue)  "
        titleLabel.text = build.title
        likeCountLabel.text = "\(build.likeCount)"

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        for component in build.components {
            let row = createComponentRow(component: component, formatter: formatter)
            componentStackView.addArrangedSubview(row)
        }

        let totalString = formatter.string(from: NSNumber(value: build.totalPrice)) ?? "0"
        totalPriceLabel.text = "합계  \(totalString)원"
    }

    // 부품 한 줄(카테고리명 + 부품명 + 가격)을 생성하는 함수
    private func createComponentRow(component: Component, formatter: NumberFormatter) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 44).isActive = true

        // 부품 카테고리 레이블
        let categoryTag = UILabel()
        categoryTag.text = component.category.rawValue
        categoryTag.font = .systemFont(ofSize: 12, weight: .bold)
        categoryTag.textColor = .systemBlue
        categoryTag.translatesAutoresizingMaskIntoConstraints = false

        // 부품 이름 레이블
        let nameLabel = UILabel()
        nameLabel.text = component.name
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        // 부품 가격 레이블
        let priceLabel = UILabel()
        let priceString = formatter.string(from: NSNumber(value: component.price)) ?? "0"
        priceLabel.text = "\(priceString)원"
        priceLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        priceLabel.textColor = .secondaryLabel
        priceLabel.textAlignment = .right
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(categoryTag)
        container.addSubview(nameLabel)
        container.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            categoryTag.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            categoryTag.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            categoryTag.widthAnchor.constraint(equalToConstant: 52),

            nameLabel.leadingAnchor.constraint(equalTo: categoryTag.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceLabel.leadingAnchor, constant: -8),

            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 90),
        ])

        return container
    }

    // "내 빌더로 가져오기" 버튼 탭 시 호출되는 함수
    @objc private func importButtonTapped() {
        let alert = UIAlertController(
            title: "빌더로 가져오기",
            message: "이 견적을 빌더 탭으로 가져오시겠습니까?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "가져오기", style: .default) { _ in
            self.tabBarController?.selectedIndex = 1
        })
        present(alert, animated: true)
    }
}
