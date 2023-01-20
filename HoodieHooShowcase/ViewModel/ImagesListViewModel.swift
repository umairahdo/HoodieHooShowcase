//
//  ImagesListViewModel.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import RxSwift
import RxCocoa

class ImagesListViewModel {
    private let disposeBag = DisposeBag()
    private let networkingApi: NetworkingService!
    
    // MARK: - ViewModelType
    
    struct Input {
        let viewDidLoad = PublishRelay<Void>()
        let refreshTrigger = PublishRelay<Void>()
    }
    
    struct Output {
        let list = BehaviorRelay<[String]>(value: [])
        let isLoading = BehaviorRelay<Bool>(value: false)
        let isRefreshing = PublishRelay<Bool>()
        let errorRelay = PublishRelay<NetworkingError>()
    }
    
    let input = Input()
    let output = Output()
    
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
        let activityIndicator = ActivityIndicator()
        let refreshIndicator = ActivityIndicator()
        
        input.viewDidLoad
            .asObservable()
            .flatMapLatest {
                networkingApi.request(.getImageList)
                    .trackActivity(activityIndicator)
                    .do(onError: { [weak self] error in
                        self?.output.errorRelay.accept(error as! NetworkingError)
                    })
            }
            .bind(to: output.list)
            .disposed(by: disposeBag)
        
        input.refreshTrigger
            .asObservable()
            .flatMapLatest {
                networkingApi.request(.getImageList)
                    .trackActivity(refreshIndicator)
                    .do(onError: { [weak self] error in
                        self?.output.errorRelay.accept(error as! NetworkingError)
                    })
            }
            .bind(to: output.list)
            .disposed(by: disposeBag)
        
        activityIndicator
            .asObservable()
            .bind(to: output.isLoading)
            .disposed(by: disposeBag)
        
        refreshIndicator
            .asObservable()
            .bind(to: output.isRefreshing)
            .disposed(by: disposeBag)
    }
}

