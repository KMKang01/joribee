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
    @IBOutlet weak var nameLabel: UILabel!

    // XIB에서 로드 후 셀의 기본 스타일을 설정하는 함수
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 17
        contentView.layer.borderWidth = 1
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
