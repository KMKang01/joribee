//
//  Build.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import Foundation

// 부품 카테고리 (CPU, GPU, RAM 등 조립 PC 구성 요소 분류)
enum ComponentCategory: String, Codable {
    case cpu = "CPU"
    case gpu = "GPU"
    case ram = "RAM"
    case storage = "저장장치"
    case motherboard = "메인보드"
    case power = "파워"
    case cooler = "쿨러"
    case pcCase = "케이스"
}

// 빌드 목적 카테고리 (게이밍, 작업용 등 사용 목적별 분류)
enum BuildCategory: String, Codable {
    case budgetGaming = "가성비 게이밍"
    case highEndGaming = "고사양 게이밍"
    case videoEditing = "4K 영상 편집"
    case office = "사무용"
    case design = "디자인/3D"
    case streaming = "스트리밍"
    case whiteBuild = "화이트 감성"
}

// 개별 부품 정보를 담는 모델
struct Component: Codable {
    // 부품 카테고리 (CPU, GPU 등)
    let category: ComponentCategory
    // 부품 이름 (예: "AMD Ryzen 7 7800X3D")
    let name: String
    // 부품 가격 (원)
    let price: Int
}

// PC 견적 한 세트를 나타내는 모델
struct Build: Codable {
    // 견적 고유 식별자
    let id: UUID
    // 견적 제목 (예: "가성비 끝판왕 게이밍 PC")
    let title: String
    // 대표 이미지 이름
    let imageName: String
    // 빌드 목적 카테고리
    let category: BuildCategory
    // 구성 부품 목록
    let components: [Component]
    // 좋아요 수
    var likeCount: Int
    // 견적 생성 날짜
    let createdDate: Date

    // 전체 부품 가격 합계를 계산하는 속성
    var totalPrice: Int {
        return components.reduce(0) { $0 + $1.price }
    }

    // CPU 부품 이름을 반환하는 속성
    var cpuName: String? {
        return components.first { $0.category == .cpu }?.name
    }

    // GPU 부품 이름을 반환하는 속성
    var gpuName: String? {
        return components.first { $0.category == .gpu }?.name
    }
}
