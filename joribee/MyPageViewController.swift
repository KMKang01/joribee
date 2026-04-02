//
//  MyPageViewController.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 마이페이지 탭 - 프로필, 선호 설정, 활동 요약, 앱 정보 화면
class MyPageViewController: UIViewController {

    // 마이페이지 테이블뷰 (Storyboard 연결)
    @IBOutlet weak var myPageTableView: UITableView!

    // 섹션 제목 목록
    private let sectionTitles = ["프로필", "나의 선호", "활동", "앱 정보"]
    // 각 섹션별 행 제목 목록
    private let rowTitles = [
        ["닉네임"],
        ["선호 용도", "예산 범위"],
        ["저장된 견적"],
        ["앱 버전", "오픈소스 라이선스"]
    ]

    // 사용자 닉네임 (UserDefaults 저장)
    private var nickname: String {
        get { UserDefaults.standard.string(forKey: "userNickname") ?? "사용자" }
        set { UserDefaults.standard.set(newValue, forKey: "userNickname") }
    }

    // 선호 용도 인덱스 (UserDefaults 저장, 범위 초과 시 0으로 보정)
    private var preferredCategoryIndex: Int {
        get { min(UserDefaults.standard.integer(forKey: "preferredCategoryIndex"), categoryOptions.count - 1) }
        set { UserDefaults.standard.set(newValue, forKey: "preferredCategoryIndex") }
    }

    // 예산 범위 인덱스 (UserDefaults 저장, 범위 초과 시 0으로 보정)
    private var budgetRangeIndex: Int {
        get { min(UserDefaults.standard.integer(forKey: "budgetRangeIndex"), budgetOptions.count - 1) }
        set { UserDefaults.standard.set(newValue, forKey: "budgetRangeIndex") }
    }

    // 선호 용도 선택지 목록
    private let categoryOptions = ["가성비 게이밍", "고사양 게이밍", "4K 영상 편집", "사무용", "디자인/3D", "스트리밍", "화이트 감성"]
    // 예산 범위 선택지 목록
    private let budgetOptions = ["50만원 이하", "50~100만원", "100~150만원", "150~200만원", "200만원 이상"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "마이페이지"
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myPageTableView.reloadData()
    }

    // 테이블뷰의 delegate, dataSource를 설정하는 함수
    private func setupTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }

    // 닉네임 편집 알림창을 표시하는 함수
    private func showNicknameEditor() {
        let alert = UIAlertController(title: "닉네임 변경", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.text = self?.nickname
            textField.placeholder = "닉네임을 입력하세요"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self?.nickname = text
            self?.myPageTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        })
        present(alert, animated: true)
    }

    // 선호 용도 선택 액션시트를 표시하는 함수
    private func showCategoryPicker() {
        let alert = UIAlertController(title: "선호 용도", message: "주로 사용할 용도를 선택하세요", preferredStyle: .actionSheet)
        for (index, option) in categoryOptions.enumerated() {
            let action = UIAlertAction(title: option, style: .default) { [weak self] _ in
                self?.preferredCategoryIndex = index
                self?.myPageTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            }
            if index == preferredCategoryIndex {
                action.setValue(true, forKey: "checked")
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }

    // 예산 범위 선택 액션시트를 표시하는 함수
    private func showBudgetPicker() {
        let alert = UIAlertController(title: "예산 범위", message: "원하는 예산 범위를 선택하세요", preferredStyle: .actionSheet)
        for (index, option) in budgetOptions.enumerated() {
            let action = UIAlertAction(title: option, style: .default) { [weak self] _ in
                self?.budgetRangeIndex = index
                self?.myPageTableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
            }
            if index == budgetRangeIndex {
                action.setValue(true, forKey: "checked")
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyPageViewController: UITableViewDataSource {

    // 섹션 수를 반환하는 함수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    // 각 섹션의 행 수를 반환하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTitles[section].count
    }

    // 섹션 헤더 제목을 반환하는 함수
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    // 각 행의 셀을 구성하여 반환하는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = rowTitles[indexPath.section][indexPath.row]

        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.detailTextLabel?.text = nickname
            cell.accessoryType = .disclosureIndicator
        case (1, 0):
            cell.detailTextLabel?.text = categoryOptions[preferredCategoryIndex]
            cell.accessoryType = .disclosureIndicator
        case (1, 1):
            cell.detailTextLabel?.text = budgetOptions[budgetRangeIndex]
            cell.accessoryType = .disclosureIndicator
        case (2, 0):
            cell.detailTextLabel?.text = "\(BuildStore.shared.savedBuilds.count)개"
            cell.accessoryType = .none
            cell.selectionStyle = .none
        case (3, 0):
            cell.detailTextLabel?.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
            cell.accessoryType = .none
            cell.selectionStyle = .none
        case (3, 1):
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension MyPageViewController: UITableViewDelegate {

    // 행 선택 시 해당 설정 화면을 표시하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            showNicknameEditor()
        case (1, 0):
            showCategoryPicker()
        case (1, 1):
            showBudgetPicker()
        case (3, 1):
            showLicenseInfo()
        default:
            break
        }
    }

    // 오픈소스 라이선스 정보를 표시하는 함수
    private func showLicenseInfo() {
        let alert = UIAlertController(title: "오픈소스 라이선스", message: "이 앱은 SF Symbols를 사용합니다.\n\n© Apple Inc. All rights reserved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
