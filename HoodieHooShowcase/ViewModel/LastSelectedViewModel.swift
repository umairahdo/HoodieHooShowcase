//
//  LastSelectedViewModel.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import RxSwift
import RxCocoa

class LastSelectedViewModel {
    private let disposeBag = DisposeBag()
    private let networkingApi: NetworkingService!
    
    // MARK: - ViewModelType
    
    struct Input {
        let viewWillAppear = PublishRelay<Void>()
        let tabBarIndex = BehaviorRelay<Int>(value: 0)
    }
    
    struct Output {
        let image = BehaviorRelay<String>(value: "")
        let isLoading = BehaviorRelay<Bool>(value: false)
        let errorRelay = PublishRelay<NetworkingError>()
    }
    
    let input = Input()
    let output = Output()
    
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
        let activityIndicator = ActivityIndicator()
        
        input.viewWillAppear
            .asObservable()
            .map {
                if self.input.tabBarIndex.value == 1 {
                    return ImageManager.shared.getLastSelectedImage()
                } else if self.input.tabBarIndex.value == 2 {
                    return ImageManager.shared.getSecondLastSelectedImage()
                }
                return ""
            }
            .bind(to: output.image)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: output.isLoading)
            .disposed(by: disposeBag)
    }
}
