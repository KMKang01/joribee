# joribee - 조립 컴퓨터 견적 가이드 앱

컴퓨터에 대한 지식이 부족한 사람들을 위해 조립 컴퓨터 견적을 짜주는 iOS 가이드 앱입니다.

## 주요 기능

- 사용자의 목적에 맞는 사양 기준 부품 추천
- 부품 간 호환성 검사 및 최저가 검색
- 본인이 짰던 견적 히스토리 관리
- 비슷한 사용자의 최근 견적 제공

## 탭 구성

| 탭 | 이름 | 설명 | 진행 상태 |
|----|------|------|-----------|
| Tab 1 | 탐색 (Explore) | 인기 견적, 목적별 베스트 빌드를 카드형 피드로 제공 | ✅ 완료 |
| Tab 2 | 빌더 (Builder) | 단계별 위저드로 부품을 선택하여 견적 구성 | ✅ 완료 |
| Tab 3 | 기록 (History) | 작성한 견적을 날짜순 정렬 및 비교 | ✅ 완료 |
| Tab 4 | 마이 (My) | 프로필, 선호도 설정, 앱 정보 | ✅ 완료 |

## Tab 1 - 탐색

### 화면 구성
- **상단 카테고리 필터**: 전체, 가성비 게이밍, 고사양 게이밍, 4K 영상 편집, 사무용, 디자인/3D, 스트리밍, 화이트 감성
- **빌드 카드 피드**: 대표 이미지, 카테고리 태그, 제목, CPU/GPU 정보, 총 가격, 좋아요 수 표시
- **견적 상세 화면**: 전체 부품 목록 + 가격, 합계, "내 빌더로 가져오기" 버튼

### 관련 파일
| 파일 | 역할 |
|------|------|
| `ExploreViewController.swift` | 탐색 탭 메인 화면 (카테고리 필터 + 카드 피드) |
| `BuildDetailViewController.swift` | 견적 상세 화면 (부품 목록 + 가져오기) |
| `BuildCardCell.swift` | 빌드 카드 컬렉션뷰 셀 |
| `CategoryCell.swift` | 카테고리 필터 태그 셀 |
| `Build.swift` | 견적 데이터 모델 (Build, Component, 열거형) |
| `SampleData.swift` | 샘플 견적 데이터 6종 |

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
| 8 | 완성 | 최종 확인 |

### 관련 파일
| 파일 | 역할 |
|------|------|
| `BuilderStep.swift` | 빌더 단계 열거형, 부품 옵션 모델, 상태 관리 클래스 |
| `BuilderSampleData.swift` | 용도별 부품 옵션 샘플 데이터 |
| `BuilderViewController.swift` | 빌더 탭 메인 화면 (단계별 위저드) |

## Tab 3 - 기록

### 화면 구성
- **견적 목록**: 저장된 견적을 날짜순으로 표시 (제목, 카테고리, 가격, 날짜)
- **스와이프 삭제**: 좌측 스와이프로 견적 삭제
- **비교 모드**: 2개 견적 선택 후 부품별 가격 비교 화면 이동

### 관련 파일
| 파일 | 역할 |
|------|------|
| `BuildStore.swift` | 견적 저장/삭제/비교 싱글톤 |
| `HistoryViewController.swift` | 기록 탭 메인 화면 (목록 + 비교 모드) |
| `CompareViewController.swift` | 두 견적 부품별 가격 비교 화면 |

## Tab 4 - 마이

### 화면 구성
- **프로필**: 닉네임 설정 (UserDefaults 저장)
- **나의 선호**: 선호 용도, 예산 범위 선택
- **활동**: 저장된 견적 수 표시
- **앱 정보**: 버전, 오픈소스 라이선스

### 관련 파일
| 파일 | 역할 |
|------|------|
| `MyPageViewController.swift` | 마이페이지 메인 화면 (설정 + 정보) |

## 기술 스택

- **언어**: Swift 5
- **UI**: UIKit + Storyboard (셀은 코드 기반)
- **아키텍처**: MVC
- **데이터 저장**: UserDefaults (선호 설정), 메모리 (BuildStore 싱글톤)
- **최소 지원**: iOS 18+

## 프로젝트 구조

```
joribee/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Base.lproj/
│   ├── Main.storyboard            # TabBar + 4탭 NavigationController + 상세화면
│   └── LaunchScreen.storyboard
├── Build.swift                     # 견적 데이터 모델
├── SampleData.swift                # 샘플 데이터
├── BuilderStep.swift               # 빌더 단계 모델
├── BuilderSampleData.swift         # 용도별 부품 옵션 데이터
├── BuildStore.swift                # 견적 저장/비교 싱글톤
├── ExploreViewController.swift     # Tab 1 - 탐색
├── BuildDetailViewController.swift # 견적 상세
├── BuildCardCell.swift             # 빌드 카드 셀
├── CategoryCell.swift              # 카테고리 필터 셀
├── BuilderViewController.swift     # Tab 2 - 빌더
├── HistoryViewController.swift     # Tab 3 - 기록
├── CompareViewController.swift     # 견적 비교 화면
├── MyPageViewController.swift      # Tab 4 - 마이
├── Assets.xcassets/
└── Info.plist
```
