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
        static let popularCollectionViewHeight = 384
    }
    
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
    }
    
    override func bind() {

    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(popularMatchCollectionView)
        
        popularMatchCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.popularCollectionViewHeight)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}
