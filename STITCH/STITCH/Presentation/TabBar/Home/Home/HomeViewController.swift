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
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
        static let floatingButtonWidth = 56
        static let scrollViewHeight = 350
        static let popularCollectionViewHeight = 384
        static let matchCollectionViewHeight = 1400
        static let pages = 3
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let topView = UIView()
    private lazy var topGradientLayer = CAGradientLayer()
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
        layout: MatchCollectionViewLayout.layout(matchSection: .newMatch),
        matchSection: .newMatch
    )
    
    private let locationButton = IconButton(iconButtonType: .location)
    
    private lazy var locationBarButton = UIBarButtonItem(customView: locationButton)
    
    private let floatingButton = FloatingButton(frame: .zero)
    
    // MARK: Properties
    
    private var isNavigationBarTranscluent = true
    private let homeViewModel: HomeViewModel
    
    // MARK: - Initializer
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradientLayer(superView: topView)
    }
    
    // MARK: - Methods
    
    override func setting() {
        // TODO: 삭제
        popularMatchCollectionView.setData([])
        
        setScrollViewTop()
        scrollView.delegate = self
    }
    
    override func bind() {
        topScrollView.setImages()
        matchCollectionView.setData(section: .newMatch, matchInfos: [])
        
        floatingButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.generateImpactHaptic()
                owner.coordinatorPublisher.onNext(.selectMatchType)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationItem.leftBarButtonItem = locationBarButton
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        view.addSubview(floatingButton)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalToSuperview().inset(Constant.padding24)
            make.width.height.equalTo(Constant.floatingButtonWidth)
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
        
        topScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topPageControl.snp.makeConstraints { make in
            make.top.equalTo(topScrollView.snp.bottom).offset(Constant.padding12)
            make.centerX.equalToSuperview()
        }
        
        popularMatchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topPageControl.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview()
            make.height.equalTo(Constant.popularCollectionViewHeight)
        }
        
        matchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularMatchCollectionView.snp.bottom).offset(Constant.padding40)
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
        topGradientLayer.colors = [
            UIColor.background.withAlphaComponent(0.0).cgColor,
            UIColor.background.cgColor
        ]
        
        topGradientLayer.locations = [0, 1]
        topGradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        topGradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        topGradientLayer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0)
        )
        topGradientLayer.bounds = superView.bounds.insetBy(
            dx: -0.5 * superView.bounds.size.width,
            dy: -0.5 * superView.bounds.size.height
        )
        topGradientLayer.position = superView.center
        
        if topGradientLayer.superlayer == nil {
            superView.layer.addSublayer(topGradientLayer)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if topScrollView == scrollView {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            setPageControl(page: page)
        }
        
        if self.scrollView == scrollView {
            if isNavigationBarTranscluent &&
                CGFloat(Constant.scrollViewHeight) <= scrollView.contentOffset.y {
                isNavigationBarTranscluent = false
                configureNavigationBar(isTranslucent: false)
            } else if !isNavigationBarTranscluent &&
                        CGFloat(Constant.scrollViewHeight) > scrollView.contentOffset.y {
                isNavigationBarTranscluent = true
                configureNavigationBar(isTranslucent: true)
            }
        }
    }
}
