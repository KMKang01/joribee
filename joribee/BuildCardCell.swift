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

    // 견적 제목을 표시하는 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
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

    // 좋아요 버튼 (비선택: 빈 하트, 선택: 채워진 하트)
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // 좋아요 버튼 탭 시 실행할 클로저 (ExploreViewController에서 주입)
    var onLikeTapped: (() -> Void)?

    // 좋아요 수를 표시하는 레이블
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true

        updateDynamicColors()
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }

    // 다크모드 전환 시 색상 속성을 갱신하는 함수
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateDynamicColors()
        }
    }

    // 현재 인터페이스 스타일에 맞게 그림자·테두리 색상을 적용하는 함수
    private func updateDynamicColors() {
        let isDark = traitCollection.userInterfaceStyle == .dark
        layer.shadowColor = isDark ? UIColor.white.cgColor : UIColor.black.cgColor
        contentView.layer.borderColor = isDark
            ? UIColor.systemGray3.cgColor
            : UIColor.clear.cgColor
    }

    // 서브뷰를 contentView에 추가하는 함수
    private func setupSubviews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cpuLabel)
        contentView.addSubview(gpuLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeCountLabel)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }

    // 오토레이아웃 제약 조건을 설정하는 함수
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.55),

            categoryLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            categoryLabel.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            cpuLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            cpuLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cpuLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            gpuLabel.topAnchor.constraint(equalTo: cpuLabel.bottomAnchor, constant: 2),
            gpuLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            gpuLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            priceLabel.topAnchor.constraint(equalTo: gpuLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            likeButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 12),
            likeButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 22),
            likeButton.heightAnchor.constraint(equalToConstant: 22),

            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 4),
            likeCountLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            likeCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }

    // Build 데이터를 셀 UI에 바인딩하는 함수
    func configure(with build: Build) {
        titleLabel.text = build.title
        categoryLabel.text = "  \(build.category.rawValue)  "
        cpuLabel.text = "CPU: \(build.cpuName ?? "-")"
        gpuLabel.text = "GPU: \(build.gpuName ?? "-")"
        likeCountLabel.text = "\(build.likeCount)"
        likeButton.isSelected = BuildStore.shared.isLiked(build.id)

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let priceString = formatter.string(from: NSNumber(value: build.totalPrice)) ?? "0"
        priceLabel.text = "\(priceString)원"

        thumbnailImageView.image = UIImage(named: build.imageName) ?? UIImage(systemName: "desktopcomputer")
    }

    // 좋아요 버튼 탭 이벤트를 클로저로 전달하는 함수
    @objc private func likeButtonTapped() {
        onLikeTapped?()
    }
}
