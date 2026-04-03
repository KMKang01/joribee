import UIKit

/// 앱 전체에서 사용하는 브랜드 컬러 팔레트
enum AppColor {

    // MARK: - Primary (브랜드 핵심 색상)

    /// 주 동작 버튼, 아이콘 하이라이트, 알림 배지 — Golden Yellow #FBC02D
    static let primary: UIColor = UIColor(hex: "#FBC02D")

    // MARK: - Secondary (기술/액션 색상)

    /// 가격 표시, 내비게이션 바 제목, 보조 버튼 — Tech Blue #2196F3
    static let secondary: UIColor = UIColor(hex: "#2196F3")

    // MARK: - Accent (구조/가독성 색상)

    /// 바디 텍스트, 테이블 분리선, 비선택 탭 아이콘 — Deep Brown #4E342E
    static let accent: UIColor = UIColor(hex: "#4E342E")

    // MARK: - Background (배경/테두리 색상)

    /// 앱 전체 배경, 카드 배경 — White #FFFFFF
    static let background: UIColor = .white

    /// 필드 테두리, 구분 영역 배경 — Light Gray #F5F5F5
    static let backgroundSecondary: UIColor = UIColor(hex: "#F5F5F5")

    // MARK: - Status (상태 표시 색상)

    /// 호환성 검사 성공, 안정 가격 — Stable Green #4CAF50
    static let success: UIColor = UIColor(hex: "#4CAF50")

    /// 호환성 경고, 예산 초과, 가격 상승 — Alert Red #E53935
    static let danger: UIColor = UIColor(hex: "#E53935")
}

// MARK: - UIColor HEX 초기화 확장

private extension UIColor {

    /// HEX 문자열(#RRGGBB)로 UIColor 생성
    convenience init(hex: String) {
        // '#' 제거 후 정수 변환
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0 // 빨간 채널
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0  // 초록 채널
        let b = CGFloat(rgb & 0xFF) / 255.0          // 파란 채널
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
