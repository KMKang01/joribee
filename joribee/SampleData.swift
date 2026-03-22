//
//  SampleData.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import Foundation

// 앱 내 샘플 견적 데이터를 제공하는 구조체
struct SampleData {

    // 탐색 탭에 표시할 샘플 견적 목록을 생성하여 반환하는 함수
    static func createSampleBuilds() -> [Build] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let builds: [Build] = [
            Build(
                id: UUID(),
                title: "가성비 끝판왕 게이밍 PC",
                imageName: "pc_budget_gaming",
                category: .budgetGaming,
                components: [
                    Component(category: .cpu, name: "AMD Ryzen 5 7600", price: 219000),
                    Component(category: .gpu, name: "RTX 4060 Ti", price: 459000),
                    Component(category: .ram, name: "DDR5 16GB x2", price: 98000),
                    Component(category: .storage, name: "NVMe SSD 1TB", price: 89000),
                    Component(category: .motherboard, name: "B650M 박격포", price: 189000),
                    Component(category: .power, name: "700W 80+ Bronze", price: 79000),
                    Component(category: .cooler, name: "ID-COOLING SE-226-XT", price: 39000),
                    Component(category: .pcCase, name: "3RSYS J400", price: 59000)
                ],
                likeCount: 342,
                createdDate: dateFormatter.date(from: "2026-03-20")!
            ),
            Build(
                id: UUID(),
                title: "4K 영상 편집 워크스테이션",
                imageName: "pc_video_editing",
                category: .videoEditing,
                components: [
                    Component(category: .cpu, name: "AMD Ryzen 9 7950X", price: 579000),
                    Component(category: .gpu, name: "RTX 4070 Ti Super", price: 899000),
                    Component(category: .ram, name: "DDR5 32GB x2", price: 198000),
                    Component(category: .storage, name: "NVMe SSD 2TB", price: 179000),
                    Component(category: .motherboard, name: "X670E AORUS Master", price: 389000),
                    Component(category: .power, name: "850W 80+ Gold", price: 129000),
                    Component(category: .cooler, name: "NZXT Kraken X63", price: 159000),
                    Component(category: .pcCase, name: "Fractal Meshify 2", price: 169000)
                ],
                likeCount: 218,
                createdDate: dateFormatter.date(from: "2026-03-18")!
            ),
            Build(
                id: UUID(),
                title: "깔끔한 올화이트 감성 PC",
                imageName: "pc_white_build",
                category: .whiteBuild,
                components: [
                    Component(category: .cpu, name: "Intel i5-14600KF", price: 299000),
                    Component(category: .gpu, name: "RTX 4070 Super White", price: 789000),
                    Component(category: .ram, name: "DDR5 16GB x2 White", price: 119000),
                    Component(category: .storage, name: "NVMe SSD 1TB", price: 89000),
                    Component(category: .motherboard, name: "B760M AORUS Elite AX", price: 199000),
                    Component(category: .power, name: "750W 80+ Gold White", price: 119000),
                    Component(category: .cooler, name: "DeepCool AK620 White", price: 69000),
                    Component(category: .pcCase, name: "NZXT H7 Flow White", price: 139000)
                ],
                likeCount: 487,
                createdDate: dateFormatter.date(from: "2026-03-21")!
            ),
            Build(
                id: UUID(),
                title: "고사양 AAA 게이밍 머신",
                imageName: "pc_highend_gaming",
                category: .highEndGaming,
                components: [
                    Component(category: .cpu, name: "AMD Ryzen 7 7800X3D", price: 399000),
                    Component(category: .gpu, name: "RTX 4080 Super", price: 1290000),
                    Component(category: .ram, name: "DDR5 32GB x2", price: 198000),
                    Component(category: .storage, name: "NVMe SSD 2TB", price: 179000),
                    Component(category: .motherboard, name: "X670E Steel Legend", price: 259000),
                    Component(category: .power, name: "850W 80+ Gold", price: 129000),
                    Component(category: .cooler, name: "Arctic Liquid Freezer II 360", price: 129000),
                    Component(category: .pcCase, name: "Lian Li O11 Dynamic", price: 159000)
                ],
                likeCount: 561,
                createdDate: dateFormatter.date(from: "2026-03-19")!
            ),
            Build(
                id: UUID(),
                title: "실속형 사무용 PC",
                imageName: "pc_office",
                category: .office,
                components: [
                    Component(category: .cpu, name: "Intel i3-14100", price: 159000),
                    Component(category: .gpu, name: "내장 그래픽", price: 0),
                    Component(category: .ram, name: "DDR4 16GB x1", price: 39000),
                    Component(category: .storage, name: "NVMe SSD 500GB", price: 49000),
                    Component(category: .motherboard, name: "B760M DS3H", price: 109000),
                    Component(category: .power, name: "500W 80+", price: 49000),
                    Component(category: .cooler, name: "기본 쿨러", price: 0),
                    Component(category: .pcCase, name: "ABKO Ncore 식스", price: 35000)
                ],
                likeCount: 129,
                createdDate: dateFormatter.date(from: "2026-03-17")!
            ),
            Build(
                id: UUID(),
                title: "스트리밍 방송용 PC",
                imageName: "pc_streaming",
                category: .streaming,
                components: [
                    Component(category: .cpu, name: "AMD Ryzen 7 7700X", price: 329000),
                    Component(category: .gpu, name: "RTX 4070 Super", price: 699000),
                    Component(category: .ram, name: "DDR5 32GB x2", price: 198000),
                    Component(category: .storage, name: "NVMe SSD 1TB", price: 89000),
                    Component(category: .motherboard, name: "B650 AORUS Elite AX", price: 219000),
                    Component(category: .power, name: "750W 80+ Gold", price: 109000),
                    Component(category: .cooler, name: "be quiet! Dark Rock Pro 5", price: 99000),
                    Component(category: .pcCase, name: "Corsair 4000D Airflow", price: 109000)
                ],
                likeCount: 275,
                createdDate: dateFormatter.date(from: "2026-03-16")!
            )
        ]

        return builds
    }
}
