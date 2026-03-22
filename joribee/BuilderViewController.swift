//
//  BuilderViewController.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 빌더 탭 - 단계별 위저드로 부품을 선택하여 견적을 구성하는 화면
class BuilderViewController: UIViewController {

    // 상단 진행률 표시 바 (Storyboard 연결)
    @IBOutlet weak var progressView: UIProgressView!
    // 현재 단계 제목 레이블 (Storyboard 연결)
    @IBOutlet weak var stepTitleLabel: UILabel!
    // 현재 단계 가이드 설명 레이블 (Storyboard 연결)
    @IBOutlet weak var guideLabel: UILabel!
    // 부품 옵션 선택 테이블뷰 (Storyboard 연결)
    @IBOutlet weak var optionsTableView: UITableView!
    // 하단 총 가격 레이블 (Storyboard 연결)
    @IBOutlet weak var totalPriceLabel: UILabel!
    // 하단 호환성 상태 레이블 (Storyboard 연결)
    @IBOutlet weak var compatibilityLabel: UILabel!
    // 다음 단계 버튼 (Storyboard 연결)
    @IBOutlet weak var nextButton: UIButton!

    // 빌더 전체 상태를 관리하는 객체
    private let builderState = BuilderState()
    // 현재 단계에서 표시할 옵션 목록 (섹션별로 분리)
    private var currentOptions: [[ComponentOption]] = []
    // 현재 단계의 섹션 제목 목록
    private var sectionTitles: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "빌더"
        setupTableView()
        setupNextButton()
        updateUI()
    }

    // 테이블뷰의 delegate, dataSource를 설정하는 함수
    private func setupTableView() {
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
    }

    // 다음 단계 버튼의 둥근 모서리와 액션을 설정하는 함수
    private func setupNextButton() {
        nextButton.layer.cornerRadius = 12
        nextButton.clipsToBounds = true
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    // 현재 단계에 맞게 전체 UI를 갱신하는 함수
    private func updateUI() {
        let step = builderState.currentStep

        progressView.setProgress(builderState.progress, animated: true)
        stepTitleLabel.text = step.title
        guideLabel.text = step.guide
        updateTotalPrice()
        loadOptionsForCurrentStep()
        optionsTableView.reloadData()
        updateNextButtonState()
        updateCompatibilityLabel()

        navigationItem.leftBarButtonItem = step == .purpose ? nil :
            UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(previousButtonTapped))
    }

    // 현재 단계에 맞는 옵션 목록을 로드하는 함수
    private func loadOptionsForCurrentStep() {
        guard let category = builderState.selectedCategory else {
            if builderState.currentStep == .purpose {
                loadPurposeOptions()
            } else {
                currentOptions = []
                sectionTitles = []
            }
            return
        }

        switch builderState.currentStep {
        case .purpose:
            loadPurposeOptions()
        case .cpu:
            currentOptions = [BuilderSampleData.cpuOptions(for: category)]
            sectionTitles = ["CPU 선택"]
        case .gpu:
            currentOptions = [BuilderSampleData.gpuOptions(for: category)]
            sectionTitles = ["그래픽카드 선택"]
        case .motherboard:
            currentOptions = [BuilderSampleData.motherboardOptions(for: category)]
            sectionTitles = ["메인보드 선택"]
        case .ramAndStorage:
            currentOptions = [
                BuilderSampleData.ramOptions(for: category),
                BuilderSampleData.storageOptions(for: category)
            ]
            sectionTitles = ["RAM 선택", "저장장치 선택"]
        case .power:
            currentOptions = [BuilderSampleData.powerOptions(for: category)]
            sectionTitles = ["파워서플라이 선택"]
        case .caseAndCooler:
            currentOptions = [
                BuilderSampleData.caseOptions(for: category),
                BuilderSampleData.coolerOptions(for: category)
            ]
            sectionTitles = ["케이스 선택", "쿨러 선택"]
        case .complete:
            loadCompleteSummary()
        }
    }

    // 용도 선택 단계의 옵션을 로드하는 함수
    private func loadPurposeOptions() {
        let categories: [BuildCategory] = [.office, .budgetGaming, .highEndGaming, .videoEditing, .design, .streaming, .whiteBuild]
        currentOptions = [categories.map { cat in
            ComponentOption(
                name: cat.rawValue,
                price: 0,
                category: .cpu,
                tag: cat.recommendedBudget.displayText,
                description: cat.subtitle
            )
        }]
        sectionTitles = ["이 컴퓨터로 무엇을 하시겠습니까?"]
    }

    // 완성 단계에서 선택된 부품 요약을 로드하는 함수
    private func loadCompleteSummary() {
        currentOptions = []
        sectionTitles = []
    }

    // 총 가격 레이블을 갱신하는 함수
    private func updateTotalPrice() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let priceString = formatter.string(from: NSNumber(value: builderState.totalPrice)) ?? "0"
        totalPriceLabel.text = "\(priceString)원"
    }

    // 다음 단계 버튼의 활성화 상태를 갱신하는 함수
    private func updateNextButtonState() {
        let step = builderState.currentStep

        if step == .complete {
            nextButton.setTitle("견적 저장", for: .normal)
            nextButton.isEnabled = true
        } else if step == .purpose {
            nextButton.setTitle("다음 단계", for: .normal)
            nextButton.isEnabled = builderState.selectedCategory != nil
        } else {
            nextButton.setTitle("다음 단계", for: .normal)
            let requiredCategories = step.componentCategories
            let allSelected = requiredCategories.allSatisfy { builderState.selectedComponents[$0] != nil }
            nextButton.isEnabled = allSelected
        }

        nextButton.alpha = nextButton.isEnabled ? 1.0 : 0.5
    }

    // 호환성 상태 레이블을 갱신하는 함수
    private func updateCompatibilityLabel() {
        if builderState.selectedComponents.isEmpty {
            compatibilityLabel.text = "부품을 선택하세요"
            compatibilityLabel.textColor = .secondaryLabel
        } else {
            compatibilityLabel.text = "✓ 호환성 완벽"
            compatibilityLabel.textColor = .systemGreen
        }
    }

    // 다음 단계 버튼 탭 시 호출되는 함수
    @objc private func nextButtonTapped() {
        if builderState.currentStep == .complete {
            saveBuild()
            return
        }
        if builderState.moveToNextStep() {
            updateUI()
        }
    }

    // 이전 단계 버튼 탭 시 호출되는 함수
    @objc private func previousButtonTapped() {
        if builderState.moveToPreviousStep() {
            updateUI()
        }
    }

    // 완성된 견적을 저장하는 함수
    private func saveBuild() {
        let alert = UIAlertController(title: "견적 저장", message: "이 견적을 저장하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.builderState.reset()
            self.updateUI()
        })
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension BuilderViewController: UITableViewDataSource {

    // 섹션 수를 반환하는 함수
    func numberOfSections(in tableView: UITableView) -> Int {
        if builderState.currentStep == .complete {
            return 1
        }
        return currentOptions.count
    }

    // 섹션 제목을 반환하는 함수
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if builderState.currentStep == .complete {
            return "선택된 부품 요약"
        }
        return sectionTitles[safe: section]
    }

    // 섹션별 행 수를 반환하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if builderState.currentStep == .complete {
            return builderState.selectedComponents.count
        }
        return currentOptions[safe: section]?.count ?? 0
    }

    // 각 행의 셀을 구성하여 반환하는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)

        if builderState.currentStep == .complete {
            configureCompleteCell(cell, at: indexPath)
        } else {
            configureOptionCell(cell, at: indexPath)
        }

        return cell
    }

    // 완성 단계의 셀을 구성하는 함수
    private func configureCompleteCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let components = Array(builderState.selectedComponents.values)
        guard let component = components[safe: indexPath.row] else { return }

        var content = cell.defaultContentConfiguration()
        content.text = "\(component.category.rawValue): \(component.name)"
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        content.secondaryText = "\(formatter.string(from: NSNumber(value: component.price)) ?? "0")원"
        cell.contentConfiguration = content
        cell.accessoryType = .checkmark
        cell.selectionStyle = .none
    }

    // 옵션 선택 단계의 셀을 구성하는 함수
    private func configureOptionCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let option = currentOptions[safe: indexPath.section]?[safe: indexPath.row] else { return }

        var content = cell.defaultContentConfiguration()
        if let tag = option.tag {
            content.text = "\(option.name)  [\(tag)]"
        } else {
            content.text = option.name
        }

        if builderState.currentStep == .purpose {
            content.secondaryText = "\(option.description)\n추천 예산: \(option.tag ?? "")"
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let priceStr = formatter.string(from: NSNumber(value: option.price)) ?? "0"
            content.secondaryText = "\(option.description) · \(priceStr)원"
        }
        content.secondaryTextProperties.numberOfLines = 0

        cell.contentConfiguration = content

        let isSelected: Bool
        if builderState.currentStep == .purpose {
            isSelected = builderState.selectedCategory?.rawValue == option.name
        } else {
            isSelected = builderState.selectedComponents[option.category]?.name == option.name
        }
        cell.accessoryType = isSelected ? .checkmark : .none
    }
}

// MARK: - UITableViewDelegate
extension BuilderViewController: UITableViewDelegate {

    // 행 선택 시 부품을 선택/해제하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if builderState.currentStep == .complete { return }

        if builderState.currentStep == .purpose {
            handlePurposeSelection(at: indexPath)
        } else {
            handleComponentSelection(at: indexPath)
        }

        tableView.reloadData()
        updateNextButtonState()
        updateTotalPrice()
        updateCompatibilityLabel()
    }

    // 용도 선택을 처리하는 함수
    private func handlePurposeSelection(at indexPath: IndexPath) {
        let categories: [BuildCategory] = [.office, .budgetGaming, .highEndGaming, .videoEditing, .design, .streaming, .whiteBuild]
        guard let selected = categories[safe: indexPath.row] else { return }
        builderState.selectedCategory = selected
        builderState.budget = selected.recommendedBudget.maxPrice
    }

    // 부품 선택을 처리하는 함수
    private func handleComponentSelection(at indexPath: IndexPath) {
        guard let option = currentOptions[safe: indexPath.section]?[safe: indexPath.row] else { return }
        let component = Component(category: option.category, name: option.name, price: option.price)
        builderState.selectedComponents[option.category] = component
    }
}

// MARK: - Array 안전 접근 확장
extension Array {
    // 인덱스 범위를 벗어나도 nil을 반환하는 안전한 접근자
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
