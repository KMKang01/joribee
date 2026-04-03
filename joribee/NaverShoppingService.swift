//
//  NaverShoppingService.swift
//  joribee
//
//  Created by 강경민 on 4/3/26.
//

import Foundation

// 네이버 쇼핑 검색 API 응답 아이템 모델
struct NaverShoppingItem: Decodable {
    // 상품명 (HTML 태그 포함될 수 있음)
    let title: String
    // 최저가 (원, 문자열 형태로 전달됨)
    let lprice: String
    // 판매처 이름
    let mallName: String
}

// 네이버 쇼핑 검색 API 응답 최상위 모델
struct NaverShoppingResponse: Decodable {
    // 검색 결과 아이템 목록
    let items: [NaverShoppingItem]
}

// 네이버 쇼핑 검색 API를 호출하는 서비스 클래스
class NaverShoppingService {

    // 앱 전체에서 접근 가능한 공유 인스턴스
    static let shared = NaverShoppingService()

    // APIKeys.swift에서 읽어온 Client ID
    private let clientId     = APIKeys.naverClientId
    // APIKeys.swift에서 읽어온 Client Secret
    private let clientSecret = APIKeys.naverClientSecret

    private init() {}

    // 키워드로 쇼핑 상품을 검색하여 결과를 반환하는 함수
    func search(query: String, display: Int = 5,
                completion: @escaping (Result<[NaverShoppingItem], Error>) -> Void) {
        var comps = URLComponents(string: "https://openapi.naver.com/v1/search/shop.json")!
        comps.queryItems = [
            URLQueryItem(name: "query",   value: query),
            URLQueryItem(name: "display", value: "\(display)"),
            URLQueryItem(name: "sort",    value: "sim"),
        ]
        guard let url = comps.url else { return }

        var req = URLRequest(url: url)
        req.setValue(clientId,     forHTTPHeaderField: "X-Naver-Client-Id")
        req.setValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")

        URLSession.shared.dataTask(with: req) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(NaverShoppingResponse.self, from: data)
                completion(.success(response.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // HTML 태그와 특수 엔티티를 제거하여 순수 텍스트를 반환하는 함수
    func stripHTML(_ string: String) -> String {
        return string
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "&amp;",  with: "&")
            .replacingOccurrences(of: "&lt;",   with: "<")
            .replacingOccurrences(of: "&gt;",   with: ">")
            .replacingOccurrences(of: "&#39;",  with: "'")
            .replacingOccurrences(of: "&quot;", with: "\"")
    }
}
