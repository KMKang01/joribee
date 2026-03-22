//
//  CategoryCell.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 상단 카테고리 필터에 사용되는 태그 형태의 컬렉션뷰 셀
class CategoryCell: UICollectionViewCell {

    // 셀 재사용 식별자
    static let identifier = "CategoryCell"

    // 카테고리 이름을 표시하는 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupConstraints()
    }

    // 셀의 기본 스타일을 설정하는 함수
    private func setupCell() {
        contentView.layer.cornerRadius = 17
        contentView.layer.borderWidth = 1
        contentView.addSubview(nameLabel)
    }

    // 오토레이아웃 제약 조건을 설정하는 함수
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
        ])
    }

    // 카테고리 이름과 선택 상태를 셀에 반영하는 함수
    func configure(with name: String, isSelected: Bool) {
        nameLabel.text = name

        if isSelected {
            contentView.backgroundColor = .systemBlue
            contentView.layer.borderColor = UIColor.systemBlue.cgColor
            nameLabel.textColor = .white
        } else {
            contentView.backgroundColor = .systemBackground
            contentView.layer.borderColor = UIColor.systemGray4.cgColor
            nameLabel.textColor = .label
        }
    }
}
