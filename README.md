# joribee - 조립 컴퓨터 견적 가이드 앱

컴퓨터에 대한 지식이 부족한 사람들을 위해 조립 컴퓨터 견적을 짜주는 iOS 가이드 앱입니다.

## 주요 기능

- 사용자의 목적에 맞는 사양 기준 부품 추천 (네이버 쇼핑 API 실시간 검색)
- 부품 간 호환성 검사 및 최저가 탐색
- 본인이 짰던 견적 히스토리 관리 및 비교
- 인기 견적 탐색 및 카테고리·키워드 검색
- 좋아요 기능 및 다크모드 지원

## 탭 구성

| 탭 | 이름 | 설명 |
|----|------|------|
| Tab 1 | 탐색 (Explore) | 인기 견적, 목적별 베스트 빌드를 카드형 피드로 제공 |
| Tab 2 | 빌더 (Builder) | 단계별 위저드로 부품을 선택하여 견적 구성 |
| Tab 3 | 기록 (History) | 작성한 견적을 날짜순 정렬 및 비교 |
| Tab 4 | 마이 (My) | 프로필, 선호도 설정, 앱 정보 |

---

## Tab 1 - 탐색

### 화면 구성
- **상단 카테고리 필터**: 전체 / 가성비 게이밍 / 고사양 게이밍 / 4K 영상 편집 / 사무용 / 디자인/3D / 스트리밍 / 화이트 감성
- **검색 바**: 제목, 카테고리, CPU·GPU 이름으로 실시간 검색
- **빌드 카드 피드**: 대표 이미지, 카테고리 태그, 제목, CPU/GPU 정보, 총 가격, 좋아요 수 (좋아요 내림차순 정렬)
- **견적 상세 화면**: 전체 부품 목록 + 가격, 합계, 하트 좋아요, "내 빌더로 가져오기" 버튼

### 관련 파일
| 파일 | 역할 |
|------|------|
| `ExploreViewController.swift` | 탐색 탭 메인 화면 (카테고리 필터 + 검색 + 카드 피드) |
| `BuildDetailViewController.swift` | 견적 상세 화면 (부품 목록 + 좋아요 + 가져오기) |
| `BuildCardCell.swift` | 빌드 카드 컬렉션뷰 셀 |
| `CategoryCell.swift` | 카테고리 필터 태그 셀 |
| `Build.swift` | 견적 데이터 모델 (Build, Component, 열거형) |
| `SampleData.swift` | 최초 실행 시 시드 샘플 견적 7종 |

---

## Tab 2 - 빌더

### 빌더 단계 (8단계)
| 순서 | 단계 | 설명 |
|------|------|------|
| 1 | 용도와 예산 | 목적 선택 + 예산 범위 설정 |
| 2 | CPU | 전체 성능 등급 결정 |
| 3 | 그래픽카드 | 예산의 30~50% 투자 권장 |
| 4 | 메인보드 | CPU 호환 소켓/칩셋 확인 |
| 5 | RAM / 저장장치 | RAM + SSD 통합 선택 |
| 6 | 파워서플라이 | 전력 합산 + 20~30% 여유 |
| 7 | 케이스 / 쿨러 | 크기 호환 + 냉각 통합 |
| 8 | 완성 | 최종 확인 및 저장 |

### 부품 로딩 방식
네이버 쇼핑 검색 API를 호출하여 실시간 최저가 부품 목록을 불러옵니다. API 실패 시 `BuilderSampleData`의 로컬 데이터로 자동 폴백되며, UUID 토큰 기반으로 stale 응답을 무시합니다.

### 호환성 검사
CPU 소켓, 메인보드 칩셋, 파워 용량 등 부품 간 호환 여부를 자동으로 검사하여 경고 메시지를 표시합니다.

### 관련 파일
| 파일 | 역할 |
|------|------|
| `BuilderStep.swift` | 빌더 단계 열거형, 부품 옵션 모델, 빌더 상태 관리 |
| `BuilderSampleData.swift` | 용도별 검색 쿼리 매핑 및 폴백 부품 데이터 |
| `BuilderViewController.swift` | 빌더 탭 메인 화면 (단계별 위저드) |
| `NaverShoppingService.swift` | 네이버 쇼핑 검색 API 호출 서비스 |

---

## Tab 3 - 기록

### 화면 구성
- **견적 목록**: 저장된 견적을 날짜순으로 표시 (제목, 카테고리, 가격, 날짜)
- **스와이프 삭제**: 좌측 스와이프로 견적 삭제
- **비교 모드**: 2개 견적 선택 후 부품별 가격 비교 화면 이동
- **비교 화면**: 8개 부품 카테고리별 A/B 가격 대조 + 총합 차액 표시

### 관련 파일
| 파일 | 역할 |
|------|------|
| `BuildStore.swift` | 견적 영구 저장/삭제/좋아요/비교 싱글톤 |
| `HistoryViewController.swift` | 기록 탭 메인 화면 (목록 + 비교 모드) |
| `CompareViewController.swift` | 두 견적 부품별 가격 비교 화면 |

---

## Tab 4 - 마이

### 화면 구성
- **프로필**: 닉네임 설정 (UserDefaults 저장)
- **나의 선호**: 선호 용도, 예산 범위 선택
- **활동**: 저장된 견적 수 표시
- **다크모드**: 앱 내 다크모드 토글 스위치
- **앱 정보**: 버전, 오픈소스 라이선스

### 관련 파일
| 파일 | 역할 |
|------|------|
| `MyPageViewController.swift` | 마이페이지 화면 (설정 + 다크모드 + 정보) |
| `AppColor.swift` | 다크모드 대응 다이나믹 컬러 팔레트 |

---

## 기술 스택

- **언어**: Swift 5
- **UI**: UIKit + Storyboard (셀은 코드 기반)
- **아키텍처**: MVC
- **데이터 저장**: `savedBuilds.json` (Documents 디렉토리, Codable), UserDefaults (좋아요·설정)
- **외부 API**: 네이버 쇼핑 검색 API
- **최소 지원**: iOS 18+

---

## 프로젝트 구조

```
joribee/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Base.lproj/
│   ├── Main.storyboard               # TabBar + 4탭 NavigationController + 상세화면
│   └── LaunchScreen.storyboard
├── Build.swift                       # 견적 데이터 모델 (Build, Component, 열거형)
├── BuildStore.swift                  # 견적 영구 저장/비교/좋아요 싱글톤
├── SampleData.swift                  # 최초 실행 시드 데이터 (7종)
├── NaverShoppingService.swift        # 네이버 쇼핑 API 서비스
├── APIKeys.swift                     # API 키 (gitignore 처리)
├── AppColor.swift                    # 다크모드 다이나믹 컬러 팔레트
├── BuilderStep.swift                 # 빌더 단계 열거형 및 상태 관리
├── BuilderSampleData.swift           # 빌더 폴백 부품 데이터
├── ExploreViewController.swift       # Tab 1 - 탐색 (필터·검색·카드 피드)
├── BuildDetailViewController.swift   # 견적 상세 (부품·좋아요·가져오기)
├── BuildCardCell.swift               # 빌드 카드 컬렉션뷰 셀
├── CategoryCell.swift                # 카테고리 필터 태그 셀
├── BuilderViewController.swift       # Tab 2 - 빌더 (단계별 위저드)
├── HistoryViewController.swift       # Tab 3 - 기록 (목록·비교 모드)
├── CompareViewController.swift       # 두 견적 부품별 비교 화면
├── MyPageViewController.swift        # Tab 4 - 마이 (설정·다크모드)
└── Assets.xcassets/
```

---

## 시작하기

1. `APIKeys.swift`를 아래 형식으로 생성합니다 (gitignore 처리됨):

```swift
struct APIKeys {
    static let naverClientId     = "YOUR_CLIENT_ID"
    static let naverClientSecret = "YOUR_CLIENT_SECRET"
}
```

2. Xcode에서 프로젝트를 열고 빌드합니다.
