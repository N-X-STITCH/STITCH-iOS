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
        static let padding12 = 12
        static let padding16 = 16
        static let padding32 = 32
        static let scrollViewHeight = 350
        static let popularCollectionViewHeight = 400
        static let matchCollectionViewHeight = 1400
        static let pages = 3
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let topView = UIView()
    private lazy var topScrollView = TopScrollView(delegate: self, view)
    
    private lazy var topPageControl = UIPageControl(frame: .zero).then {
        $0.numberOfPages = Constant.pages
    }
    
    private lazy var popularMatchCollectionView = PopularMatchCollectionView(
        self,
        layout: PopularCollectionViewLayout.layout()
    )
    
    private lazy var matchCollectionView = MatchCollectionView(
        self,
        layout: MatchCollectionViewLayout.layout()
    )
    
    // MARK: Properties
    
    private let homeViewModel: HomeViewModel
    
    // MARK: - Initializer
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init()
    }
    
    override func viewDidLayoutSubviews() {
        setGradientLayer(superView: topView)
    }
    
    // MARK: - Methods
    
    override func setting() {
        popularMatchCollectionView.setData(MatchInfo.dump())
        setScrollViewTop()
    }
    
    override func bind() {
        topScrollView.setImages()
        matchCollectionView.setData(matchInfos: MatchInfo.dump())
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
        
        contentView.addSubview(topView)
        topView.addSubview(topScrollView)
        contentView.addSubview(topPageControl)
        contentView.addSubview(popularMatchCollectionView)
        contentView.addSubview(matchCollectionView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constant.scrollViewHeight)
        }
        
        topScrollView.backgroundColor = .yellow01
        topScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topPageControl.snp.makeConstraints { make in
            make.top.equalTo(topScrollView.snp.bottom).offset(Constant.padding12)
            make.centerX.equalToSuperview()
        }
        
        popularMatchCollectionView.backgroundColor = .cyan
        popularMatchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topPageControl.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview()
            make.height.equalTo(Constant.popularCollectionViewHeight)
        }
        
        matchCollectionView.backgroundColor = .black
        matchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularMatchCollectionView.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.matchCollectionViewHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    func setScrollViewTop() {
        let navbarHeight = navigationController?.navigationBar.frame.height ?? 0
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height else { return }
        let topInset = navbarHeight + statusBarHeight
        scrollView.contentInset.top = -topInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    func setPageControl(page: Int) {
        topPageControl.currentPage = page
    }
    
    private func setGradientLayer(superView: UIView) {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.background.withAlphaComponent(0.0).cgColor,
            UIColor.background.cgColor
        ]
        
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0)
        )
        layer.bounds = superView.bounds.insetBy(
            dx: -0.5 * superView.bounds.size.width,
            dy: -0.5 * superView.bounds.size.height
        )
        layer.position = superView.center
        superView.layer.addSublayer(layer)
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        setPageControl(page: page)
    }
}
