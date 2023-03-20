//
//  MatchDetailViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

import NMapsMap
import RxCocoa
import RxSwift
import Kingfisher

final class MatchDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding4 = 4
        static let padding6 = 6
        static let padding8 = 8
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
        static let buttonHeight = 56
        static let radius8 = 8
        static let radius28 = 28
        static let sportHeight = 346
        static let gradientViewHeight = 106
        static let matchImageHeight = 48
        static let matchTitleHeight = 24
        static let infoHeight = 20
        static let matchHostImageHeight = 40
        static let matchHostNameHeight = 20
        static let miniDivisionHeight = 1
        static let divisionHeight = 8
        static let detailInfoHeight = 28
        static let iconWidth = 24
        static let mapViewHeight = 150
        static let badgeHeight = 20
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let matchImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let gradientView = UIImageView(image: .detailBottomGradient)
    
    private let matchSportImageView = DefaultProfileImageView()
    
    private let matchTitleLabel = DefaultTitleLabel(
        text: "",
        textColor: .gray02,
        font: .Subhead_16
    )
    
    private lazy var classBadgeView = ClassBadge()
    
    private let sportBadgeView = SportBadge(sport: .etc)
    
    private let locationView = DefaultIconLabelView(icon: .location, text: "서울시 용산구 한강진역")
    private let scheduleView = DefaultIconLabelView(icon: .calendar, text: "2023.3.4(토) 16:00~18:00")
    private let feeView = DefaultIconLabelView(icon: .dollar, text: "10,000원")
    private let peopleCountView = DefaultIconLabelView(icon: .peopleWhite, text: "3/4명")
    
    private let miniDivisionView = UIView().then {
        $0.backgroundColor = .gray11
    }
    
    private let matchHostProfileImageView = DefaultProfileImageView(true)
    
    private let matchHostNicknameLabel = DefaultTitleLabel(text: "good", textColor: .gray04, font: .Subhead2_14)
    
    private let matchContentLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .Body2_14
        $0.textColor = .gray02
        $0.lineBreakMode = .byWordWrapping
        $0.textAlignment = .left
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.44
        
        let attributedText = NSMutableAttributedString(
            string: "레슨해요",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        
        $0.attributedText = attributedText
    }
    
    private let divisionView = UIView().then {
        $0.backgroundColor = .gray12
    }
    
    private let detailInfoTitleLabel = DefaultTitleLabel(
        text: "Detail info",
        textColor: .yellow05_primary,
        font: .Body1_16
    )
    
    private let detailInfoButton = UIButton().then {
        $0.titleLabel?.font = .Headline_20
        $0.backgroundColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("매치의 자세한 위치를 알려드려요", for: .normal)
    }
    
    private let detailInfoImageButton = UIButton().then {
        $0.setImage(.arrowRight, for: .normal)
    }
    
    private lazy var mapView = NMFMapView(frame: view.frame).then {
        $0.layer.cornerRadius = CGFloat(Constant.radius8)
    }
    private var marker: NMFMarker?
    private var currentLocation: NMGLatLng?
    
    // TODO: 지도
    
    private let matchJoinButton = IconButton(iconButtonType: .matchJoin).then {
        $0.layer.cornerRadius = CGFloat(Constant.radius28)
    }
    
    private let floatingView = UIView().then {
        $0.layer.borderColor = UIColor.gray12.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .background
    }
    
    // MARK: Properties
    
    let matchObservable = BehaviorSubject<Match>(value: Match())
    
    private let matchDetailViewModel: MatchDetailViewModel
    
    private var match: Match!
    
    // MARK: - Initializer
    
    init(matchDetailViewModel: MatchDetailViewModel) {
        self.matchDetailViewModel = matchDetailViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        configureMapView()
    }
    
    override func bind() {
        
        let matchJoinButtonTap = matchJoinButton.rx.tap.asObservable()
        
        let matchObserver = matchObservable.asObservable().share()
        
        let mapButtonTap = Observable.of(detailInfoButton.rx.tap, detailInfoImageButton.rx.tap).merge().asObservable()
        
        let input = MatchDetailViewModel.Input(
            match: matchObserver,
            matchJoinButtonTap: matchJoinButtonTap
        )
        let output = matchDetailViewModel.transform(input: input)
        
        output.matchInfo
            .asDriver(onErrorJustReturn: MatchInfo(match: Match(), owner: User()))
            .drive { [weak self] matchInfo in
                print(matchInfo)
                guard let self else { return }
                self.match = matchInfo.match
                self.configure(matchInfo: matchInfo)
            }
            .disposed(by: disposeBag)
        
        mapButtonTap
            .asDriver(onErrorJustReturn: (()))
            .drive { [weak self] _ in
                guard let owner = self else { return }
                owner.openNaverMap()
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.user, output.matchInfo)
            .asDriver(onErrorJustReturn: (User(), MatchInfo(match: Match(), owner: User())))
            .drive { [weak self] user, matchInfo in
                guard let self else { return }
                if user.id == matchInfo.match.matchHostID {
                    self.setButton(isEnabled: false)
                } else if matchInfo.joinedUsers.map({ $0.id }).contains(user.id) {
                    self.setButton(isEnabled: false)
                } else {
                    self.setButton(isEnabled: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .clear
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        view.addSubviews([floatingView, matchJoinButton])
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        matchJoinButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide).inset(Constant.padding16)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        floatingView.snp.makeConstraints { make in
            make.top.equalTo(matchJoinButton.snp.top).offset(-Constant.padding12)
            make.left.right.bottom.equalToSuperview().inset(-1)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        contentView.addSubviews([matchImageView, gradientView])
        contentView.addSubviews([matchSportImageView, matchTitleLabel])
        contentView.addSubviews([locationView, scheduleView, feeView, peopleCountView, miniDivisionView])
        contentView.addSubviews([matchHostProfileImageView, matchHostNicknameLabel, matchContentLabel])
        // TODO: 지도
        contentView.addSubviews([divisionView])
        contentView.addSubviews([detailInfoTitleLabel, detailInfoButton, detailInfoImageButton])
        contentView.addSubview(mapView)
        
        configureTop()
        configureMatchProfileView()
        configureInfoView()
        configureMatch()
        configureDetailInfo()
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.subviews.last!.snp.bottom).offset(100)
        }
    }
    
    private func setButton(isEnabled: Bool) {
        if isEnabled {
            matchJoinButton.changeButtonInMatchDetail(type: .matchJoin)
        } else {
            matchJoinButton.changeButtonInMatchDetail(type: .matchJoined)
        }
    }
    
    private func setBadgeConstraint(badgeView: UIView) {
        contentView.addSubview(badgeView)
        badgeView.snp.makeConstraints { make in
            make.top.equalTo(matchTitleLabel.snp.bottom).offset(Constant.padding4)
            make.left.equalTo(matchSportImageView.snp.right).offset(Constant.padding8)
        }
    }
    
    private func setBadge(match: Match) {
        sportBadgeView.set(sport: match.sport)
        switch match.matchType {
        case .teachMatch:
            let stackView = UIStackView(arrangedSubviews: [classBadgeView, sportBadgeView]).then {
                $0.axis = .horizontal
                $0.spacing = CGFloat(Constant.padding6)
            }
            setBadgeConstraint(badgeView: stackView)
        default:
            setBadgeConstraint(badgeView: sportBadgeView)
        }
    }
    
    func configure(matchInfo: MatchInfo) {
        let match = matchInfo.match
        matchSportImageView.image = match.sport.image
        matchTitleLabel.text = match.matchTitle
        matchContentLabel.text = match.content
        sportBadgeView.set(sport: match.sport)
        locationView.textLabel.text = match.locationInfo.address
        scheduleView.textLabel.text = match.startDate.toDisplay(startDate: match.startDate, duration: match.duration)
        feeView.textLabel.text = "\(String(match.fee).feeString())원"
        peopleCountView.textLabel.text =  "\(match.headCount)/\(match.maxHeadCount)명"
        if let latitude = match.locationInfo.latitude,
           let latitude = Double(latitude),
           let longitude = match.locationInfo.longitude,
           let longitude = Double(longitude) {
            let location = NMGLatLng(lat: latitude, lng: longitude)
            moveCamera(to: location)
            moveMarker(to: location)
        }
        if let matchImageURL = URL(string: match.matchImageURL) {
            print("사진들")
            print(match.matchImageURL)
            matchImageView.kf.setImage(with: matchImageURL)
        } else {
            print("사진들")
            print(match.matchImageURL)
            matchImageView.image = .defaultLogoImageLarge
        }
        
        let user = matchInfo.owner
        matchHostNicknameLabel.text = user.nickname
        if let profileImageURL = user.profileImageURL,
           let matchHostImageURL = URL(string: profileImageURL) {
            matchHostProfileImageView.kf.setImage(with: matchHostImageURL)
        }
        setBadge(match: match)
    }
    
    private func openNaverMap() {
        guard let latitude = match.locationInfo.latitude,
              let latitude = Double(latitude),
              let longitude = match.locationInfo.longitude,
              let longitude = Double(longitude)
        else { return }
        let urlString = "nmap://place?lat=\(latitude)&lng=\(longitude)&name=\(match.locationInfo.address)&appname=com.neuli.STITCH"
        guard let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedURLString) else { return }
        guard let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(appStoreURL)
        }
    }
}

// MARK: - Map

extension MatchDetailViewController {
    private func configureMapView() {
        let center = mapView.projection.latlng(from: CGPoint(
            x: view.frame.midX, y: view.frame.midY - 50)
        )
        // 화면 중앙에 마커 추가
        marker = NMFMarker(position: center)
        marker?.iconImage = NMFOverlayImage(image: .marker ?? .strokedCheckmark)
        marker?.mapView = mapView
        
        // 현재 위치 표시
        mapView.positionMode = .direction
        
    }
    
    private func moveMarker(to location: NMGLatLng) {
        marker?.position = location
        marker?.mapView = mapView
    }
    
    private func moveCamera(to location: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: location)
        cameraUpdate.animation = .fly
        mapView.moveCamera(cameraUpdate)
    }
}

// MARK: - UI

extension MatchDetailViewController {
    private func configureTop() {
        matchImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constant.sportHeight)
        }
        
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(matchImageView)
            make.height.equalTo(Constant.gradientViewHeight)
        }
    }
    
    private func configureMatchProfileView() {
        matchSportImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.matchImageHeight)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.bottom.equalTo(matchImageView.snp.bottom).inset(Constant.padding40)
        }
        
        matchTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(matchImageView.snp.bottom).inset(64)
            make.left.equalTo(matchSportImageView.snp.right).offset(Constant.padding8)
            make.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.matchTitleHeight)
        }
    }
    
    private func configureInfoView() {
        locationView.snp.makeConstraints { make in
            make.top.equalTo(matchImageView.snp.bottom).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.infoHeight)
        }
        
        scheduleView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(Constant.padding8)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.infoHeight)
        }
        
        feeView.snp.makeConstraints { make in
            make.top.equalTo(scheduleView.snp.bottom).offset(Constant.padding8)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.infoHeight)
        }
        
        peopleCountView.snp.makeConstraints { make in
            make.top.equalTo(feeView.snp.bottom).offset(Constant.padding8)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.infoHeight)
        }
        
        miniDivisionView.snp.makeConstraints { make in
            make.top.equalTo(peopleCountView.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.miniDivisionHeight)
        }
    }
    
    private func configureMatch() {
        matchHostProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(miniDivisionView.snp.bottom).offset(Constant.padding24)
            make.width.height.equalTo(Constant.matchHostImageHeight)
            make.centerX.equalToSuperview()
        }
        
        matchHostNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(matchHostProfileImageView.snp.bottom).offset(Constant.padding6)
            make.height.equalTo(Constant.matchHostNameHeight)
            make.centerX.equalToSuperview()
        }
        
        matchContentLabel.snp.makeConstraints { make in
            make.top.equalTo(matchHostNicknameLabel.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        divisionView.snp.makeConstraints { make in
            make.top.equalTo(matchContentLabel.snp.bottom).offset(Constant.padding40)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constant.divisionHeight)
        }
    }
    
    private func configureDetailInfo() {
        detailInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(divisionView.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.detailInfoHeight)
        }
        
        detailInfoButton.snp.makeConstraints { make in
            make.top.equalTo(detailInfoTitleLabel.snp.bottom)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.detailInfoHeight)
        }
        
        detailInfoImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.iconWidth)
            make.right.equalToSuperview().inset(Constant.padding12)
            make.centerY.equalTo(detailInfoButton)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(detailInfoButton.snp.bottom).offset(Constant.padding16)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.mapViewHeight)
        }
    }
}
