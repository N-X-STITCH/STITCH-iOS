//
//  HomeViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/28.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
        static let scrollViewHeight = 350
        static let popularCollectionViewHeight = 400
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var topScrollView = TopScrollView(delegate: self, view)
    private lazy var popularMatchCollectionView = PopularMatchCollectionView(
        self,
        layout: PopularCollectionViewLayout.layout()
    )
    
    // MARK: Properties
    
    private let homeViewModel: HomeViewModel
    
    // MARK: - Initializer
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        popularMatchCollectionView.setData(MatchInfo.dump())
        setScrollViewTop()
    }
    
    override func bind() {

    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        contentView.addSubview(topScrollView)
        contentView.addSubview(popularMatchCollectionView)
        
        topScrollView.backgroundColor = .yellow01
        topScrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constant.scrollViewHeight)
        }
        
        popularMatchCollectionView.backgroundColor = .cyan
        popularMatchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topScrollView.snp.bottom)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview()
            make.height.equalTo(Constant.popularCollectionViewHeight)
        }
        
        topScrollView.setImages()
    }
    
    func setScrollViewTop() {
        let navbarHeight = navigationController?.navigationBar.frame.height ?? 0
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height else { return }
        let topInset = navbarHeight + statusBarHeight
        scrollView.contentInset.top = -topInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension HomeViewController: UICollectionViewDelegate {}
