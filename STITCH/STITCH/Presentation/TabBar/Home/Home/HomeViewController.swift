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
    
    private let refreshControl = UIRefreshControl()
    private lazy var scrollView = UIScrollView().then {
        $0.refreshControl = refreshControl
    }
    private let contentView = UIView()
    
    private let topView = UIView()
    private lazy var topGradientLayer = CAGradientLayer()
    private lazy var topScrollView = TopScrollView(delegate: self, view)
    private let topMessageLabel = DefaultTitleLabel(
        text: "STITCH와 함께\n최고의 매치를 가져보세요!",
        textColor: .white,
        font: .Headline_20
    )
    
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
        
        locationButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.findLocation)
            }
            .disposed(by: disposeBag)
        
        floatingButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.generateImpactHaptic()
                owner.coordinatorPublisher.onNext(.selectMatchType)
            }
            .disposed(by: disposeBag)
        
        popularMatchCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe { owner, indexPath in
                guard let popularMatchCell = owner.popularMatchCollectionView.cellForItem(at: indexPath) as? PopularMatchCell else { return }
                
                owner.coordinatorPublisher.onNext(.created(match: popularMatchCell.matchInfo.match))
            }
            .disposed(by: disposeBag)
        
        matchCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe { owner, indexPath in
                guard let matchCell = owner.matchCollectionView.cellForItem(at: indexPath) as? MatchCell else { return }
                
                owner.coordinatorPublisher.onNext(.created(match: matchCell.match))
            }
            .disposed(by: disposeBag)
        
        let refreshObservalble = refreshControl.rx.controlEvent(.valueChanged).asObservable().share()
        
        let input = HomeViewModel.Input(
            viewWillAppear: rx.viewWillAppear.map { _ in () }.asObservable(),
            refreshControl: refreshObservalble
        )
        
        let output = homeViewModel.transform(input: input)
        
        output.userObservable
            .asDriver(onErrorJustReturn: User())
            .drive { [weak self] user in
                guard let owner = self else { return }
                owner.locationButton.setTitle(user.address, for: .normal)
                owner.locationButton.titleLabel?.font = .Headline_20
            }
            .disposed(by: disposeBag)
        
        output.homeMatches
            .asDriver(onErrorJustReturn: ([], []))
            .drive { [weak self] matches in
                guard let owner = self else { return }
                owner.configure(matches: matches)
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
        contentView.addSubview(topMessageLabel)
        contentView.addSubview(topPageControl)
        contentView.addSubview(popularMatchCollectionView)
        contentView.addSubview(matchCollectionView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constant.scrollViewHeight)
        }
        
        topMessageLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(topView.snp.bottom).inset(Constant.padding24)
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
            make.left.right.equalToSuperview()
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
    
    private func configure(matches: (recommendedMatches: [Match], newMatches: [Match])) {
        matchCollectionView.setData(
            section: .newMatch,
            matchInfos: matches.newMatches.map { MatchInfo(match: $0, owner: User()) }
        )
    }
    
    func didReceive(locationInfo: LocationInfo) {
        locationButton.setTitle(locationInfo.address, for: .normal)
        homeViewModel.userUpdate(address: locationInfo.address)
            .withUnretained(self)
            .subscribe { owner, user in
                owner.locationButton.setTitle(user.address, for: .normal)
                owner.locationButton.titleLabel?.font = .Headline_20
            }
            .disposed(by: disposeBag)
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
