//
//  LastSelectedVC.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class LastSelectedVC: UIViewController {
    @IBOutlet weak var lastSelectedImageView: UIImageView!
    @IBOutlet weak var imageUrlLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let disposeBag = DisposeBag()
    private let viewModel = LastSelectedViewModel()
    var index = 0
        
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSubview()
        setupAccessibilityIdentifiers()
        bindViewModel()
    }
    
    private func setupSubview() {
        view.addSubview(activityIndicator)
    }
    
    private func setupAccessibilityIdentifiers() {
        imageUrlLabel.accessibilityIdentifier = AccessibilityIdentifiers.imageUrlLabel
    }
    
    private func setupView(model: String) {
        DispatchQueue.main.async {
            self.lastSelectedImageView.kf.setImage(with: URL(string: model), placeholder: UIImage(systemName: "pencil.and.outline"))
            self.imageUrlLabel.text =  model == "" ? AppMessages.noImageAvailable : model
        }
    }
    
    private func bindViewModel() {
        
        Observable.just(self.index)
            .bind(to: viewModel.input.tabBarIndex)
            .disposed(by: disposeBag)
        
        Observable.just(())
            .bind(to: viewModel.input.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.output.image
            .subscribe(onNext: { [weak self] image in
                self?.setupView(model: image)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.output.errorRelay
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(with: error.message)
            }).disposed(by: disposeBag)
    }
}

