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
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // 견적 제목을 표시하는 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 빌드 카테고리 태그를 표시하는 레이블
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // CPU 이름을 표시하는 레이블
    private let cpuLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // GPU 이름을 표시하는 레이블
    private let gpuLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 총 가격을 표시하는 레이블
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 좋아요 아이콘을 표시하는 이미지뷰
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // 좋아요 수를 표시하는 레이블
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // 하단 정보 영역을 감싸는 컨테이너 뷰
    private let infoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCellStyle()
        setupSubviews()
        setupConstraints()
    }

    // 셀의 그림자 및 둥근 모서리 스타일을 설정하는 함수
    private func setupCellStyle() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }

    // 서브뷰를 contentView에 추가하는 함수
    private func setupSubviews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(infoContainerView)
        infoContainerView.addSubview(categoryLabel)
        infoContainerView.addSubview(titleLabel)
        infoContainerView.addSubview(cpuLabel)
        infoContainerView.addSubview(gpuLabel)
        infoContainerView.addSubview(priceLabel)
        infoContainerView.addSubview(heartImageView)
        infoContainerView.addSubview(likeCountLabel)
    }

    // 오토레이아웃 제약 조건을 설정하는 함수
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // 썸네일 이미지
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.55),

            // 정보 컨테이너
            infoContainerView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 12),
            infoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            infoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            infoContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            // 카테고리 태그
            categoryLabel.topAnchor.constraint(equalTo: infoContainerView.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 22),
            categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            // 제목
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),

            // CPU 정보
            cpuLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            cpuLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            cpuLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),

            // GPU 정보
            gpuLabel.topAnchor.constraint(equalTo: cpuLabel.bottomAnchor, constant: 2),
            gpuLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),
            gpuLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),

            // 가격
            priceLabel.topAnchor.constraint(equalTo: gpuLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor),

            // 좋아요 아이콘
            heartImageView.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: likeCountLabel.leadingAnchor, constant: -4),
            heartImageView.widthAnchor.constraint(equalToConstant: 16),
            heartImageView.heightAnchor.constraint(equalToConstant: 16),

            // 좋아요 수
            likeCountLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            likeCountLabel.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor),
        ])
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
