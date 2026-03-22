//
//  BuilderSampleData.swift
//  joribee
//
//  Created by 강경민 on 3/22/26.
//

import Foundation

// 빌더 각 단계에서 선택 가능한 부품 옵션 샘플 데이터를 제공하는 구조체
struct BuilderSampleData {

    // 용도에 맞는 CPU 옵션 목록을 반환하는 함수
    static func cpuOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "Intel Core i3-14100", price: 159000, category: .cpu, tag: "가장 많이 선택됨", description: "4코어 8스레드 / 내장 그래픽 포함"),
                ComponentOption(name: "AMD Ryzen 5 5600G", price: 139000, category: .cpu, tag: nil, description: "6코어 12스레드 / 내장 그래픽 포함"),
                ComponentOption(name: "Intel Core i5-14400", price: 229000, category: .cpu, tag: nil, description: "10코어 16스레드 / 내장 그래픽 포함"),
            ]
        case .budgetGaming, .whiteBuild:
            return [
                ComponentOption(name: "AMD Ryzen 5 7600", price: 219000, category: .cpu, tag: "가성비 추천", description: "6코어 12스레드 / AM5 소켓"),
                ComponentOption(name: "Intel Core i5-14400F", price: 199000, category: .cpu, tag: "가장 많이 선택됨", description: "10코어 16스레드 / LGA1700 소켓"),
                ComponentOption(name: "Intel Core i5-14600KF", price: 299000, category: .cpu, tag: nil, description: "14코어 20스레드 / 오버클럭 가능"),
            ]
        case .highEndGaming:
            return [
                ComponentOption(name: "AMD Ryzen 7 7800X3D", price: 399000, category: .cpu, tag: "게이밍 최강", description: "8코어 16스레드 / 3D V-Cache"),
                ComponentOption(name: "Intel Core i7-14700KF", price: 429000, category: .cpu, tag: nil, description: "20코어 28스레드 / 오버클럭 가능"),
                ComponentOption(name: "AMD Ryzen 9 7900X", price: 459000, category: .cpu, tag: nil, description: "12코어 24스레드 / 고성능 멀티태스킹"),
            ]
        case .videoEditing, .design:
            return [
                ComponentOption(name: "AMD Ryzen 7 7700X", price: 329000, category: .cpu, tag: nil, description: "8코어 16스레드 / 작업 가성비"),
                ComponentOption(name: "AMD Ryzen 9 7950X", price: 579000, category: .cpu, tag: "가장 많이 선택됨", description: "16코어 32스레드 / 최상급 멀티코어"),
                ComponentOption(name: "Intel Core i9-14900K", price: 629000, category: .cpu, tag: nil, description: "24코어 32스레드 / 최고 클럭"),
            ]
        case .streaming:
            return [
                ComponentOption(name: "AMD Ryzen 7 7700X", price: 329000, category: .cpu, tag: "가장 많이 선택됨", description: "8코어 16스레드 / 멀티태스킹 강점"),
                ComponentOption(name: "Intel Core i7-14700KF", price: 429000, category: .cpu, tag: nil, description: "20코어 28스레드 / 방송+게임 동시"),
                ComponentOption(name: "AMD Ryzen 9 7900X", price: 459000, category: .cpu, tag: nil, description: "12코어 24스레드 / 여유로운 성능"),
            ]
        }
    }

    // 용도에 맞는 GPU 옵션 목록을 반환하는 함수
    static func gpuOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "내장 그래픽 사용", price: 0, category: .gpu, tag: "추천", description: "별도 GPU 불필요"),
                ComponentOption(name: "GeForce GT 1030", price: 89000, category: .gpu, tag: nil, description: "듀얼 모니터 출력용"),
            ]
        case .budgetGaming, .whiteBuild:
            return [
                ComponentOption(name: "RTX 4060", price: 369000, category: .gpu, tag: "가성비 추천", description: "FHD 게이밍 최적 / 8GB VRAM"),
                ComponentOption(name: "RTX 4060 Ti", price: 459000, category: .gpu, tag: "가장 많이 선택됨", description: "FHD~QHD 게이밍 / 8GB VRAM"),
                ComponentOption(name: "RX 7700 XT", price: 489000, category: .gpu, tag: nil, description: "QHD 게이밍 / 12GB VRAM"),
            ]
        case .highEndGaming:
            return [
                ComponentOption(name: "RTX 4070 Super", price: 699000, category: .gpu, tag: nil, description: "QHD 고프레임 / 12GB VRAM"),
                ComponentOption(name: "RTX 4070 Ti Super", price: 899000, category: .gpu, tag: "가장 많이 선택됨", description: "QHD~4K 게이밍 / 16GB VRAM"),
                ComponentOption(name: "RTX 4080 Super", price: 1290000, category: .gpu, tag: nil, description: "4K 게이밍 최적 / 16GB VRAM"),
            ]
        case .videoEditing, .design:
            return [
                ComponentOption(name: "RTX 4070 Super", price: 699000, category: .gpu, tag: nil, description: "영상 인코딩 가속 / 12GB VRAM"),
                ComponentOption(name: "RTX 4070 Ti Super", price: 899000, category: .gpu, tag: "가장 많이 선택됨", description: "4K 편집 쾌적 / 16GB VRAM"),
                ComponentOption(name: "RTX 4080 Super", price: 1290000, category: .gpu, tag: nil, description: "대용량 프로젝트 / 16GB VRAM"),
            ]
        case .streaming:
            return [
                ComponentOption(name: "RTX 4060 Ti", price: 459000, category: .gpu, tag: nil, description: "NVENC 인코더 / 8GB VRAM"),
                ComponentOption(name: "RTX 4070 Super", price: 699000, category: .gpu, tag: "가장 많이 선택됨", description: "방송+게임 동시 / 12GB VRAM"),
                ComponentOption(name: "RTX 4070 Ti Super", price: 899000, category: .gpu, tag: nil, description: "고화질 방송 / 16GB VRAM"),
            ]
        }
    }

    // 용도에 맞는 메인보드 옵션 목록을 반환하는 함수
    static func motherboardOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "GIGABYTE B760M DS3H", price: 109000, category: .motherboard, tag: "가장 많이 선택됨", description: "M-ATX / LGA1700 / DDR4"),
                ComponentOption(name: "ASRock A620M-HDV", price: 89000, category: .motherboard, tag: nil, description: "M-ATX / AM5 / DDR5"),
            ]
        case .budgetGaming, .whiteBuild:
            return [
                ComponentOption(name: "MSI B650M 박격포", price: 189000, category: .motherboard, tag: "가장 많이 선택됨", description: "M-ATX / AM5 / DDR5"),
                ComponentOption(name: "GIGABYTE B760M AORUS Elite", price: 179000, category: .motherboard, tag: nil, description: "M-ATX / LGA1700 / DDR5"),
                ComponentOption(name: "ASRock B650M PG Riptide", price: 159000, category: .motherboard, tag: "가성비 추천", description: "M-ATX / AM5 / DDR5"),
            ]
        case .highEndGaming, .videoEditing, .design, .streaming:
            return [
                ComponentOption(name: "MSI B650 TOMAHAWK", price: 239000, category: .motherboard, tag: "가장 많이 선택됨", description: "ATX / AM5 / DDR5 / 안정적 전원부"),
                ComponentOption(name: "GIGABYTE X670E AORUS Master", price: 389000, category: .motherboard, tag: nil, description: "ATX / AM5 / DDR5 / 고급 확장"),
                ComponentOption(name: "ASUS Z790 STRIX-A", price: 349000, category: .motherboard, tag: nil, description: "ATX / LGA1700 / DDR5 / WiFi"),
            ]
        }
    }

    // 용도에 맞는 RAM 옵션 목록을 반환하는 함수
    static func ramOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "DDR4 16GB (8GBx2)", price: 39000, category: .ram, tag: "가장 많이 선택됨", description: "3200MHz / 듀얼 채널"),
                ComponentOption(name: "DDR5 16GB (8GBx2)", price: 59000, category: .ram, tag: nil, description: "4800MHz / 듀얼 채널"),
            ]
        case .budgetGaming, .whiteBuild:
            return [
                ComponentOption(name: "DDR5 16GB (8GBx2)", price: 69000, category: .ram, tag: nil, description: "5600MHz / 듀얼 채널"),
                ComponentOption(name: "DDR5 32GB (16GBx2)", price: 119000, category: .ram, tag: "가장 많이 선택됨", description: "5600MHz / 듀얼 채널"),
            ]
        case .highEndGaming, .streaming:
            return [
                ComponentOption(name: "DDR5 32GB (16GBx2)", price: 139000, category: .ram, tag: "가장 많이 선택됨", description: "6000MHz / 듀얼 채널"),
                ComponentOption(name: "DDR5 64GB (32GBx2)", price: 259000, category: .ram, tag: nil, description: "6000MHz / 대용량"),
            ]
        case .videoEditing, .design:
            return [
                ComponentOption(name: "DDR5 32GB (16GBx2)", price: 139000, category: .ram, tag: nil, description: "6000MHz / 듀얼 채널"),
                ComponentOption(name: "DDR5 64GB (32GBx2)", price: 259000, category: .ram, tag: "가장 많이 선택됨", description: "6000MHz / 대용량 작업 필수"),
            ]
        }
    }

    // 용도에 맞는 저장장치 옵션 목록을 반환하는 함수
    static func storageOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "NVMe SSD 500GB", price: 49000, category: .storage, tag: "가장 많이 선택됨", description: "PCIe 3.0 / 읽기 3,500MB/s"),
                ComponentOption(name: "NVMe SSD 1TB", price: 79000, category: .storage, tag: nil, description: "PCIe 4.0 / 읽기 5,000MB/s"),
            ]
        case .budgetGaming, .whiteBuild, .streaming:
            return [
                ComponentOption(name: "NVMe SSD 1TB", price: 89000, category: .storage, tag: "가장 많이 선택됨", description: "PCIe 4.0 / 읽기 5,000MB/s"),
                ComponentOption(name: "NVMe SSD 2TB", price: 159000, category: .storage, tag: nil, description: "PCIe 4.0 / 넉넉한 용량"),
            ]
        case .highEndGaming:
            return [
                ComponentOption(name: "NVMe SSD 1TB", price: 89000, category: .storage, tag: nil, description: "PCIe 4.0 / 읽기 5,000MB/s"),
                ComponentOption(name: "NVMe SSD 2TB", price: 179000, category: .storage, tag: "가장 많이 선택됨", description: "PCIe 4.0 / 대작 게임 다수 설치"),
            ]
        case .videoEditing, .design:
            return [
                ComponentOption(name: "NVMe SSD 2TB", price: 179000, category: .storage, tag: "가장 많이 선택됨", description: "PCIe 4.0 / 대용량 소스 저장"),
                ComponentOption(name: "NVMe SSD 4TB", price: 349000, category: .storage, tag: nil, description: "PCIe 4.0 / 영상 프로젝트 전용"),
            ]
        }
    }

    // 용도에 맞는 파워서플라이 옵션 목록을 반환하는 함수
    static func powerOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "500W 80+ Standard", price: 45000, category: .power, tag: "가장 많이 선택됨", description: "저전력 시스템에 충분"),
                ComponentOption(name: "550W 80+ Bronze", price: 59000, category: .power, tag: nil, description: "여유 있는 전력 공급"),
            ]
        case .budgetGaming, .whiteBuild:
            return [
                ComponentOption(name: "650W 80+ Bronze", price: 69000, category: .power, tag: nil, description: "보급형 게이밍 적합"),
                ComponentOption(name: "700W 80+ Bronze", price: 79000, category: .power, tag: "가장 많이 선택됨", description: "RTX 4060 Ti까지 안정 지원"),
                ComponentOption(name: "750W 80+ Gold", price: 109000, category: .power, tag: nil, description: "높은 효율 / 향후 업그레이드 대비"),
            ]
        case .highEndGaming, .videoEditing, .design, .streaming:
            return [
                ComponentOption(name: "750W 80+ Gold", price: 109000, category: .power, tag: nil, description: "RTX 4070급 안정 지원"),
                ComponentOption(name: "850W 80+ Gold", price: 129000, category: .power, tag: "가장 많이 선택됨", description: "RTX 4080급 안정 지원"),
                ComponentOption(name: "1000W 80+ Gold", price: 169000, category: .power, tag: nil, description: "하이엔드 시스템 / 넉넉한 여유"),
            ]
        }
    }

    // 용도에 맞는 케이스 옵션 목록을 반환하는 함수
    static func caseOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "ABKO Ncore 식스", price: 35000, category: .pcCase, tag: "가장 많이 선택됨", description: "M-ATX / 심플 디자인"),
                ComponentOption(name: "3RSYS J100", price: 39000, category: .pcCase, tag: nil, description: "M-ATX / 컴팩트"),
            ]
        case .budgetGaming:
            return [
                ComponentOption(name: "3RSYS J400", price: 59000, category: .pcCase, tag: "가장 많이 선택됨", description: "ATX / 쿨링 확장 우수"),
                ComponentOption(name: "Corsair 4000D Airflow", price: 109000, category: .pcCase, tag: nil, description: "ATX / 메쉬 전면 / 쿨링 최적화"),
            ]
        case .highEndGaming, .videoEditing, .design, .streaming:
            return [
                ComponentOption(name: "Corsair 4000D Airflow", price: 109000, category: .pcCase, tag: "가장 많이 선택됨", description: "ATX / 메쉬 전면 / 쿨링 최적화"),
                ComponentOption(name: "Lian Li O11 Dynamic", price: 159000, category: .pcCase, tag: nil, description: "ATX / 수랭 특화 / 감성 디자인"),
                ComponentOption(name: "Fractal Meshify 2", price: 169000, category: .pcCase, tag: nil, description: "ATX / 최상급 쿨링 / 정숙"),
            ]
        case .whiteBuild:
            return [
                ComponentOption(name: "NZXT H7 Flow White", price: 139000, category: .pcCase, tag: "가장 많이 선택됨", description: "ATX / 화이트 / 메쉬"),
                ComponentOption(name: "Corsair 4000D Airflow White", price: 119000, category: .pcCase, tag: nil, description: "ATX / 화이트 / 쿨링 우수"),
                ComponentOption(name: "Lian Li O11 Dynamic White", price: 169000, category: .pcCase, tag: nil, description: "ATX / 화이트 / 수랭 특화"),
            ]
        }
    }

    // 용도에 맞는 쿨러 옵션 목록을 반환하는 함수
    static func coolerOptions(for category: BuildCategory) -> [ComponentOption] {
        switch category {
        case .office:
            return [
                ComponentOption(name: "기본 쿨러 (CPU 포함)", price: 0, category: .cooler, tag: "추천", description: "저발열 CPU에 적합"),
            ]
        case .budgetGaming:
            return [
                ComponentOption(name: "ID-COOLING SE-226-XT", price: 39000, category: .cooler, tag: "가장 많이 선택됨", description: "공랭 / 타워형 / 뛰어난 가성비"),
                ComponentOption(name: "DeepCool AK400", price: 29000, category: .cooler, tag: nil, description: "공랭 / 입문용 타워 쿨러"),
            ]
        case .highEndGaming, .streaming:
            return [
                ComponentOption(name: "DeepCool AK620", price: 59000, category: .cooler, tag: nil, description: "공랭 / 듀얼 타워 / 고성능"),
                ComponentOption(name: "Arctic Liquid Freezer II 360", price: 129000, category: .cooler, tag: "가장 많이 선택됨", description: "수랭 360mm / 최상급 냉각"),
                ComponentOption(name: "NZXT Kraken X63", price: 159000, category: .cooler, tag: nil, description: "수랭 280mm / LCD 디스플레이"),
            ]
        case .videoEditing, .design:
            return [
                ComponentOption(name: "be quiet! Dark Rock Pro 5", price: 99000, category: .cooler, tag: nil, description: "공랭 / 듀얼 타워 / 정숙"),
                ComponentOption(name: "Arctic Liquid Freezer II 360", price: 129000, category: .cooler, tag: "가장 많이 선택됨", description: "수랭 360mm / 장시간 렌더링 안정"),
            ]
        case .whiteBuild:
            return [
                ComponentOption(name: "DeepCool AK620 White", price: 69000, category: .cooler, tag: "가장 많이 선택됨", description: "공랭 / 화이트 / 듀얼 타워"),
                ComponentOption(name: "NZXT Kraken X63 White", price: 169000, category: .cooler, tag: nil, description: "수랭 280mm / 화이트 / LCD"),
            ]
        }
    }
}
