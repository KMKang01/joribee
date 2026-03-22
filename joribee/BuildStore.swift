//
//  BuildStore.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import Foundation

// 견적 데이터를 저장하고 관리하는 싱글톤 클래스
class BuildStore {

    // 앱 전체에서 접근 가능한 공유 인스턴스
    static let shared = BuildStore()

    // 저장된 견적 목록 (날짜 최신순 정렬)
    private(set) var savedBuilds: [Build] = []

    private init() {
        loadInitialData()
    }

    // 초기 샘플 데이터를 로드하는 함수
    private func loadInitialData() {
        savedBuilds = SampleData.createSampleBuilds()
        savedBuilds.sort { $0.createdDate > $1.createdDate }
    }

    // 새로운 견적을 저장하는 함수
    func saveBuild(_ build: Build) {
        savedBuilds.insert(build, at: 0)
    }

    // 특정 견적을 삭제하는 함수
    func deleteBuild(at index: Int) {
        guard savedBuilds.indices.contains(index) else { return }
        savedBuilds.remove(at: index)
    }

    // 두 견적의 부품별 가격 차이를 비교하여 반환하는 함수
    func compareBuilds(_ buildA: Build, _ buildB: Build) -> [ComponentComparison] {
        var comparisons: [ComponentComparison] = []

        let allCategories: [ComponentCategory] = [.cpu, .gpu, .ram, .storage, .motherboard, .power, .cooler, .pcCase]

        for category in allCategories {
            let compA = buildA.components.first { $0.category == category }
            let compB = buildB.components.first { $0.category == category }

            comparisons.append(ComponentComparison(
                category: category,
                componentA: compA,
                componentB: compB
            ))
        }

        return comparisons
    }
}

// 두 견적의 부품 비교 결과를 담는 모델
struct ComponentComparison {
    // 부품 카테고리
    let category: ComponentCategory
    // 견적 A의 부품 (없으면 nil)
    let componentA: Component?
    // 견적 B의 부품 (없으면 nil)
    let componentB: Component?

    // 가격 차이를 반환하는 속성 (B - A, 양수면 B가 비쌈)
    var priceDifference: Int {
        return (componentB?.price ?? 0) - (componentA?.price ?? 0)
    }
}
