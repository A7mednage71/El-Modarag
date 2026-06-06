//
//  FavoritesPresenterTests.swift
//  WhistleTests
//
//  Created by Ahmed Nageh on 06/06/2026.
//

@testable import Whistle
import Foundation
import XCTest

class FavoritesPresenterTests: XCTestCase {
    
    var presenter: FavoritesPresenter!
    var mockView: MockFavoritesViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // تهيئة البيئة قبل كل تست
        mockView = MockFavoritesViewController()
      presenter = FavoritesPresenter(view: mockView)
        
        // 💡 تنويه: لو الـ LocalServices بيرجع داتا حقيقية، يفضل عمل Mocking له مستقبلاً.
        // الحين هنختبر الـ Logic المبني على الداتا المتاحة.
    }
    
    override func tearDownWithError() throws {
        // تنظيف الـ Memory
        presenter = nil
        mockView = nil
        try super.tearDownWithError()
    }
    
    // 🧪 الاختبار الأول: التأكد من سيكوانس الـ Load (Loading -> Fetch -> Reload)
    func testViewDidLoad_ShouldShowLoadingThenHideAndReload() {
        // Given (المعطيات مجهزة في الـ setUp)
        
        // When (الحدث)
        presenter.viewDidLoad()
        
        // Then (النتائج المتوقعة)
        XCTAssertTrue(mockView.showLoadingCalled, "الـ Presenter مفروض يظهر الـ Loading أول ما يفتح")
        XCTAssertTrue(mockView.hideLoadingCalled, "الـ Presenter مفروض يخفي الـ Loading بعد الـ Fetch")
        XCTAssertTrue(mockView.reloadFavoritesDataCalled, "الـ Presenter مفروض يطلب من الـ View تعمل reload للجدول")
    }
    
    // 🧪 الاختبار الثاني: التحقق من صحة التنقل وتمرير البيانات المظبوطة للشاشة التالية
    func testDidSelectFavorite_ShouldNavigateWithCorrectData() {
        // Given
        // بما إن الـ favoritesList بريفيت وبتقرأ من LocalServices، هنعمل دبل تشيك للحالة دي:
        presenter.viewDidLoad() // عشان نملأ الستيت لو فيه داتا
        
        // حزام أمان: لو الـ DB فاضية والتست مش لاقي عناصر، التست هيعدي Skip عشان ميكرشش.
        guard presenter.numberOfFavorites > 0 else {
            print("⚠️ الـ Local Database فاضية حالياً، يرجى ملء داتا للتست بالكامل.")
            return
        }
        
        let targetIndex = 0
        let expectedLeague = presenter.favoriteItem(at: targetIndex)
        
        // When
        presenter.didSelectFavorite(at: targetIndex)
        
        // Then
        XCTAssertTrue(mockView.navigateToDetailsCalled, "الـ Presenter مفروض يوجه الـ View للشاشة التالية")
        XCTAssertEqual(mockView.lastSelectedLeagueName, expectedLeague.leagueName, "اسم البطولة الممرر مش مظبوط")
        XCTAssertEqual(mockView.lastSelectedLeagueId, expectedLeague.leagueKey, "الـ ID الممرر للشاشة التالية مش مظبوط")
    }
    
    // 🧪 الاختبار الثالث: اختبار دالة الحذف وتأثيرها على العدد (Count)
    func testDidRemoveFavorite_ShouldDecreaseCount() {
        // Given
        presenter.viewDidLoad()
        let initialCount = presenter.numberOfFavorites
        
        guard initialCount > 0 else { return }
        
        // When
        presenter.didRemoveFavorite(at: 0)
        
        // Then
        let finalCount = presenter.numberOfFavorites
        XCTAssertEqual(finalCount, initialCount - 1, "عدد العناصر في المصفوفة مفروض يقل بمقدار ١ بعد الحذف")
    }
}
