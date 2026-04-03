//
//  BuilderStep.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import Foundation

// 빌더 위저드의 각 단계를 나타내는 열거형 (실제 조립 순서 기반)
enum BuilderStep: Int, CaseIterable {
    case purpose = 0        // 용도와 예산 설정
    case cpu = 1            // CPU 결정
    case gpu = 2            // 그래픽카드(GPU) 결정
    case motherboard = 3    // 메인보드 선택
    case ramAndStorage = 4  // RAM 및 저장장치 선택
    case power = 5          // 파워서플라이 결정
    case caseAndCooler = 6  // 케이스 및 쿨러 선택
    case complete = 7       // 완성

    // 각 단계의 한글 제목을 반환하는 속성
    var title: String {
        switch self {
        case .purpose: return "용도와 예산"
        case .cpu: return "CPU"
        case .gpu: return "그래픽카드"
        case .motherboard: return "메인보드"
        case .ramAndStorage: return "RAM / 저장장치"
        case .power: return "파워서플라이"
        case .caseAndCooler: return "케이스 / 쿨러"
        case .complete: return "완성"
        }
    }

    // 각 단계의 가이드 설명을 반환하는 속성
    var guide: String {
        switch self {
        case .purpose:
            return "이 컴퓨터로 무엇을 할 것인지 정하고, 예산 범위를 설정하세요."
        case .cpu:
            return "전체 성능 등급을 결정하는 첫 번째 부품입니다. CPU에 따라 나머지 부품의 등급이 정해집니다."
        case .gpu:
            return "게이밍이나 고사양 작업이 목적이라면 CPU만큼 중요합니다. 보통 전체 예산의 30~50%를 투자하는 것이 밸런스가 좋습니다."
        case .motherboard:
            return "앞서 고른 CPU와 호환되는 소켓/칩셋을 확인하세요. CPU 등급에 맞는 보드를 선택합니다."
        case .ramAndStorage:
            return "RAM은 기본 16GB(8GBx2) 권장, 고사양 작업 시 32GB 이상. SSD는 NVMe M.2로 최소 512GB 이상을 추천합니다."
        case .power:
            return "CPU와 GPU 전력 소모량 합산 후 20~30% 여유 있게 선택하세요. 80 PLUS 인증 등급을 확인하세요."
        case .caseAndCooler:
            return "메인보드 크기, 그래픽카드 길이, 쿨러 높이가 들어가는지 확인하세요. 발열이 심한 CPU라면 별도 쿨러를 추가합니다."
        case .complete:
            return "모든 부품 선택이 완료되었습니다! 호환성과 가격을 최종 확인하세요."
        }
    }

    // 각 단계에 대응하는 부품 카테고리 목록을 반환하는 속성
    var componentCategories: [ComponentCategory] {
        switch self {
        case .cpu: return [.cpu]
        case .gpu: return [.gpu]
        case .motherboard: return [.motherboard]
        case .ramAndStorage: return [.ram, .storage]
        case .power: return [.power]
        case .caseAndCooler: return [.pcCase, .cooler]
        default: return []
        }
    }
}

// 빌더에서 선택 가능한 부품 옵션 모델
struct ComponentOption {
    // 부품 이름
    let name: String
    // 부품 가격 (원)
    let price: Int
    // 부품 카테고리
    let category: ComponentCategory
    // 추천 태그 (예: "가장 많이 선택됨")
    let tag: String?
    // 간단한 스펙 설명
    let description: String
}

// 용도별 예산 범위를 나타내는 구조체
struct BudgetRange {
    // 최소 예산 (원)
    let minPrice: Int
    // 최대 예산 (원)
    let maxPrice: Int
    // 예산 범위 표시 텍스트
    var displayText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let min = formatter.string(from: NSNumber(value: minPrice / 10000)) ?? "0"
        let max = formatter.string(from: NSNumber(value: maxPrice / 10000)) ?? "0"
        return "\(min)만 원 ~ \(max)만 원"
    }
}

// 용도별 추천 예산 범위를 제공하는 속성 (BuildCategory 확장)
extension BuildCategory {
    // 해당 용도의 추천 예산 범위를 반환하는 속성
    var recommendedBudget: BudgetRange {
        switch self {
        case .office:
            return BudgetRange(minPrice: 400000, maxPrice: 600000)
        case .budgetGaming:
            return BudgetRange(minPrice: 800000, maxPrice: 1200000)
        case .highEndGaming:
            return BudgetRange(minPrice: 1500000, maxPrice: 2500000)
        case .videoEditing:
            return BudgetRange(minPrice: 1500000, maxPrice: 3000000)
        case .design:
            return BudgetRange(minPrice: 1500000, maxPrice: 2500000)
        case .streaming:
            return BudgetRange(minPrice: 1200000, maxPrice: 2000000)
        case .whiteBuild:
            return BudgetRange(minPrice: 1000000, maxPrice: 2000000)
        }
    }

    // 용도별 한 줄 설명을 반환하는 속성
    var subtitle: String {
        switch self {
        case .office:
            return "저사양 CPU, 내장 그래픽으로 충분"
        case .budgetGaming:
            return "합리적인 가격에 대부분의 게임 가능"
        case .highEndGaming:
            return "GPU에 가장 많은 투자 필요"
        case .videoEditing:
            return "CPU와 RAM에 우선순위"
        case .design:
            return "GPU 가속과 넉넉한 RAM 필요"
        case .streaming:
            return "멀티태스킹에 강한 CPU 필요"
        case .whiteBuild:
            return "화이트 파츠 위주로 감성 조립"
        }
    }
}

// 빌더 위저드의 전체 상태를 관리하는 클래스
class BuilderState {
    // 현재 진행 중인 단계
    var currentStep: BuilderStep = .purpose
    // 선택된 용도 카테고리
    var selectedCategory: BuildCategory?
    // 설정된 예산 (원)
    var budget: Int = 0
    // 각 단계별 선택된 부품을 저장하는 딕셔너리
    var selectedComponents: [ComponentCategory: Component] = [:]

    // 현재까지 선택된 부품의 총 가격을 계산하는 속성
    var totalPrice: Int {
        return selectedComponents.values.reduce(0) { $0 + $1.price }
    }

    // 남은 예산을 계산하는 속성
    var remainingBudget: Int {
        return budget - totalPrice
    }

    // 현재 단계의 진행률(0.0~1.0)을 반환하는 속성
    var progress: Float {
        return Float(currentStep.rawValue) / Float(BuilderStep.allCases.count - 1)
    }

    // 전체 선택을 초기화하는 함수
    func reset() {
        currentStep = .purpose
        selectedCategory = nil
        budget = 0
        selectedComponents.removeAll()
    }

    // 다음 단계로 이동하는 함수 (마지막이면 false 반환)
    func moveToNextStep() -> Bool {
        guard let nextRaw = BuilderStep(rawValue: currentStep.rawValue + 1) else { return false }
        currentStep = nextRaw
        return true
    }

    // 이전 단계로 이동하는 함수 (처음이면 false 반환)
    func moveToPreviousStep() -> Bool {
        guard currentStep.rawValue > 0,
              let prevRaw = BuilderStep(rawValue: currentStep.rawValue - 1) else { return false }
        currentStep = prevRaw
        return true
    }
}

// 선택된 부품 조합의 호환성을 검사하는 구조체
struct CompatibilityChecker {

    // CPU 이름 키워드 → 소켓 타입 매핑 딕셔너리
    private static let cpuSocketMap: [String: String] = [
        "i3-14100": "LGA1700",
        "i5-14400": "LGA1700",
        "i5-14600KF": "LGA1700",
        "i7-14700KF": "LGA1700",
        "i9-14900K": "LGA1700",
        "5600G": "AM4",
        "7600": "AM5",
        "7700X": "AM5",
        "7800X3D": "AM5",
        "7900X": "AM5",
        "7950X": "AM5",
    ]

    // 메인보드 이름 키워드 → 소켓 타입 매핑 딕셔너리
    private static let motherboardSocketMap: [String: String] = [
        "B760M DS3H": "LGA1700",
        "B760M AORUS Elite": "LGA1700",
        "Z790 STRIX-A": "LGA1700",
        "A620M-HDV": "AM5",
        "B650M 박격포": "AM5",
        "B650M PG Riptide": "AM5",
        "B650 TOMAHAWK": "AM5",
        "X670E AORUS Master": "AM5",
    ]

    // CPU 이름으로 소켓 타입을 찾는 함수
    static func cpuSocket(for cpuName: String) -> String? {
        return cpuSocketMap.first { cpuName.contains($0.key) }?.value
    }

    // 메인보드 이름으로 소켓 타입을 찾는 함수
    static func motherboardSocket(for mbName: String) -> String? {
        return motherboardSocketMap.first { mbName.contains($0.key) }?.value
    }

    // 메인보드 이름으로 DDR 세대를 반환하는 함수 (B760M DS3H만 DDR4)
    static func motherboardDDR(for mbName: String) -> String {
        return mbName.contains("B760M DS3H") ? "DDR4" : "DDR5"
    }

    // RAM 이름으로 DDR 세대를 반환하는 함수
    static func ramDDR(for ramName: String) -> String? {
        if ramName.contains("DDR4") { return "DDR4" }
        if ramName.contains("DDR5") { return "DDR5" }
        return nil
    }

    // 선택된 부품 조합의 호환성 문제 목록을 반환하는 함수
    static func issues(for components: [ComponentCategory: Component]) -> [String] {
        var problems: [String] = []

        // CPU-메인보드 소켓 호환성 검사
        if let cpu = components[.cpu], let mb = components[.motherboard] {
            let cpuSock = cpuSocket(for: cpu.name)
            let mbSock = motherboardSocket(for: mb.name)
            if let cs = cpuSock, let ms = mbSock, cs != ms {
                problems.append("⚠ CPU(\(cs)) · 메인보드(\(ms)) 소켓 불일치")
            }
        }

        // 메인보드-RAM DDR 세대 호환성 검사
        if let mb = components[.motherboard], let ram = components[.ram] {
            let mbDDR = motherboardDDR(for: mb.name)
            if let rDDR = ramDDR(for: ram.name), mbDDR != rDDR {
                problems.append("⚠ 메인보드(\(mbDDR)) · RAM(\(rDDR)) DDR 세대 불일치")
            }
        }

        return problems
    }
}
