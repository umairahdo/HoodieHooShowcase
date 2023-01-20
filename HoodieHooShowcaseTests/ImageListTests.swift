//
//  ImageListTests.swift
//  HoodieHooShowcaseTests
//
//  Created by Umair Ahmad on 20/01/23.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest

@testable import HoodieHooShowcase

class ImageListTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    var viewModel: ImagesListViewModel!
    var scheduler: TestScheduler!
    
    // MARK: - GIVEN

    override func setUp() {
        viewModel = ImagesListViewModel(networkingApi: MockNetworkingAPI())
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        
        scheduler.createHotObservable([.next(100, ())])
            .bind(to: viewModel.input.viewDidLoad)
            .disposed(by: disposeBag)
    }

    func testIndicatorEvents() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Bool.self)
        
        viewModel.output.isLoading
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Bool>>] = [
            .next(0, false),
            .next(100, true),
            .next(100, false)
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }
    
    func testListCount() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(Int.self)
        
        viewModel.output.list
            .map { $0.count }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(0, 0),
            .next(100, 6)
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }
    
    func testImageData() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(String?.self)
        
        viewModel.output.list
            .map({ $0.last })
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<String?>>] = [
            .next(0, nil),
            .next(100, "https://surroundvision.co.uk/wp-content/uploads/2018/10/Client-Earth-Lawerys-protecting-the-environment-500x500.jpg")
        ]
        
        // MARK: - THEN
        
        XCTAssertEqual(observer.events, exceptEvents)
    }
}
