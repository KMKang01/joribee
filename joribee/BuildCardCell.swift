//
//  BuildCardCell.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 탐색 탭에서 견적을 카드 형태로 보여주는 컬렉션뷰 셀
class BuildCardCell: UICollectionViewCell {

    // 셀 재사용 식별자
    static let identifier = "BuildCardCell"

    // 대표 이미지를 표시하는 이미지뷰
    @IBOutlet weak var thumbnailImageView: UIImageView!
    // 빌드 카테고리 태그를 표시하는 레이블
    @IBOutlet weak var categoryLabel: UILabel!
    // 견적 제목을 표시하는 레이블
    @IBOutlet weak var titleLabel: UILabel!
    // CPU 이름을 표시하는 레이블
    @IBOutlet weak var cpuLabel: UILabel!
    // GPU 이름을 표시하는 레이블
    @IBOutlet weak var gpuLabel: UILabel!
    // 총 가격을 표시하는 레이블
    @IBOutlet weak var priceLabel: UILabel!
    // 좋아요 아이콘을 표시하는 이미지뷰
    @IBOutlet weak var heartImageView: UIImageView!
    // 좋아요 수를 표시하는 레이블
    @IBOutlet weak var likeCountLabel: UILabel!

    // XIB에서 로드 후 셀의 그림자 및 둥근 모서리 스타일을 설정하는 함수
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.masksToBounds = false

        thumbnailImageView.layer.cornerRadius = 12
        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        categoryLabel.layer.cornerRadius = 8
        categoryLabel.clipsToBounds = true
    }

    // Build 데이터를 셀 UI에 바인딩하는 함수
    func configure(with build: Build) {
        titleLabel.text = build.title
        categoryLabel.text = "  \(build.category.rawValue)  "
        cpuLabel.text = "CPU: \(build.cpuName ?? "-")"
        gpuLabel.text = "GPU: \(build.gpuName ?? "-")"
        likeCountLabel.text = "\(build.likeCount)"

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let priceString = formatter.string(from: NSNumber(value: build.totalPrice)) ?? "0"
        priceLabel.text = "\(priceString)원"

        thumbnailImageView.image = UIImage(named: build.imageName) ?? UIImage(systemName: "desktopcomputer")
    }
}
