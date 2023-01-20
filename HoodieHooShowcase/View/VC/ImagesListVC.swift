//
//  ImagesListVC.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ImagesListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    private let viewModel = ImagesListViewModel()
    
    // MARK: - Table View
    
    private let dataSource = RxTableViewSectionedReloadDataSource<ImagesListSection>(configureCell: {  (_, tableView, _, image) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as? ImageTableViewCell ?? ImageTableViewCell(style: .default, reuseIdentifier: "ImageTableViewCell")
        cell.setupView(model: image)
        return cell
    })
    
    private func registerXib() {
        let nibName = UINib(nibName: "ImageTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ImageTableViewCell")
        tableView.rowHeight = 114
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupAccessibilityIdentifiers()
        bindViewModel()
        registerXib()
    }
    
    private func setupAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = AccessibilityIdentifiers.imageTableView
    }
    
    private func setupSubview() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.addSubview(activityIndicator)
    }
    
    private func bindViewModel() {
        Observable.just(())
            .bind(to: viewModel.input.viewDidLoad)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.input.refreshTrigger)
            .disposed(by: disposeBag)
        
        viewModel.output.list
            .map { [ImagesListSection(header: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .filter { !$0 }
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.output.isRefreshing
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.output.errorRelay
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(with: error.message)
            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] image in
                ImageManager.shared.setImages(image: image)
                self?.showAlert(with: AppMessages.imageSelected)
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] row in
                self?.tableView.deselectRow(at: row, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
