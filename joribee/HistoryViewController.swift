//
//  HistoryViewController.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import UIKit

// 기록 탭 - 사용자가 작성한 견적을 날짜순으로 정렬하고 비교하는 화면
class HistoryViewController: UIViewController {

    // 견적 목록 테이블뷰 (Storyboard 연결)
    @IBOutlet weak var historyTableView: UITableView!
    // 견적이 없을 때 표시되는 안내 레이블 (Storyboard 연결)
    @IBOutlet weak var emptyLabel: UILabel!
    // 비교 버튼 (Storyboard 연결)
    @IBOutlet weak var compareBarButton: UIBarButtonItem!

    // 저장된 견적 목록 (BuildStore에서 가져옴)
    private var builds: [Build] = []
    // 비교 모드 활성화 여부
    private var isCompareMode = false
    // 비교 모드에서 선택된 견적 인덱스 목록
    private var selectedIndices: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "기록"
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBuilds()
    }

    // 테이블뷰의 delegate, dataSource를 설정하는 함수
    private func setupTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
    }

    // BuildStore에서 견적 목록을 가져와 갱신하는 함수
    private func loadBuilds() {
        builds = BuildStore.shared.savedBuilds
        emptyLabel.isHidden = !builds.isEmpty
        historyTableView.isHidden = builds.isEmpty
        historyTableView.reloadData()
        updateCompareButton()
    }

    // 비교 버튼의 상태를 갱신하는 함수
    private func updateCompareButton() {
        if isCompareMode {
            navigationItem.rightBarButtonItem?.title = "취소"
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "비교하기 (\(selectedIndices.count)/2)",
                style: .done,
                target: self,
                action: #selector(executeCompare)
            )
            navigationItem.leftBarButtonItem?.isEnabled = selectedIndices.count == 2
        } else {
            navigationItem.rightBarButtonItem?.title = "비교"
            navigationItem.leftBarButtonItem = nil
        }
    }

    // 비교 모드를 토글하는 함수 (Storyboard 연결)
    @IBAction func compareButtonTapped(_ sender: UIBarButtonItem) {
        if builds.count < 2 {
            let alert = UIAlertController(title: "비교 불가", message: "비교하려면 최소 2개의 견적이 필요합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }

        isCompareMode.toggle()
        selectedIndices.removeAll()
        historyTableView.reloadData()
        updateCompareButton()
    }

    // 선택된 두 견적을 비교 화면으로 이동하는 함수
    @objc private func executeCompare() {
        guard selectedIndices.count == 2 else { return }
        let indices = Array(selectedIndices).sorted()
        let buildA = builds[indices[0]]
        let buildB = builds[indices[1]]

        let compareVC = CompareViewController()
        compareVC.buildA = buildA
        compareVC.buildB = buildB
        navigationController?.pushViewController(compareVC, animated: true)

        isCompareMode = false
        selectedIndices.removeAll()
        historyTableView.reloadData()
        updateCompareButton()
    }
}

// MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {

    // 견적 목록의 행 수를 반환하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return builds.count
    }

    // 각 행의 셀을 구성하여 반환하는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let build = builds[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = build.title
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let priceStr = formatter.string(from: NSNumber(value: build.totalPrice)) ?? "0"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateStr = dateFormatter.string(from: build.createdDate)

        content.secondaryText = "\(build.category.rawValue) · \(priceStr)원 · \(dateStr)"
        content.secondaryTextProperties.color = .secondaryLabel
        cell.contentConfiguration = content

        if isCompareMode {
            cell.accessoryType = selectedIndices.contains(indexPath.row) ? .checkmark : .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension HistoryViewController: UITableViewDelegate {

    // 행 선택 시 상세 화면 이동 또는 비교 선택을 처리하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if isCompareMode {
            if selectedIndices.contains(indexPath.row) {
                selectedIndices.remove(indexPath.row)
            } else if selectedIndices.count < 2 {
                selectedIndices.insert(indexPath.row)
            }
            tableView.reloadData()
            updateCompareButton()
        } else {
            let build = builds[indexPath.row]
            guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "BuildDetailViewController") as? BuildDetailViewController else { return }
            detailVC.build = build
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    // 스와이프 삭제를 처리하는 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            BuildStore.shared.deleteBuild(at: indexPath.row)
            builds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            emptyLabel.isHidden = !builds.isEmpty
            historyTableView.isHidden = builds.isEmpty
        }
    }
}
