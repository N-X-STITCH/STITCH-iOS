//
//  MatchDetailViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

import Kingfisher

final class MatchDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding6 = 6
        static let padding8 = 8
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
        static let buttonHeight = 56
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
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let sportImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let gradientView = UIImageView(image: .detailBottomGradient)
    
    private let matchImageView = DefaultProfileImageView()
    
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
    
    // TODO: 지도
    
    private let matchJoinButton = IconButton(iconButtonType: .matchJoin).then {
        $0.layer.cornerRadius = CGFloat(Constant.radius28)
    }
    
    // MARK: Properties
    
    private let matchDetailViewModel: MatchDetailViewModel
    
    // MARK: - Initializer
    
    init(matchDetailViewModel: MatchDetailViewModel) {
        self.matchDetailViewModel = matchDetailViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
    }
    
    override func bind() {
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .clear
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        view.addSubview(matchJoinButton)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(view)
            make.top.equalTo(view.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        matchJoinButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide).inset(Constant.padding16)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            // TODO: 변경
            make.height.equalTo(1500)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        contentView.addSubviews([sportImageView, gradientView])
        contentView.addSubviews([matchImageView, matchTitleLabel])
        contentView.addSubviews([locationView, scheduleView, feeView, peopleCountView, miniDivisionView])
        contentView.addSubviews([matchHostProfileImageView, matchHostNicknameLabel, matchContentLabel])
        // TODO: 지도
        contentView.addSubviews([divisionView])
        
        configureTop()
        configureMatchProfileView()
        configureInfoView()
        configureMatch()
        configureDetailInfo()
    }
    
    func configure(match: Match) {
        print(match)
        matchImageView.image = match.sport.image
        matchTitleLabel.text = match.matchTitle
        sportBadgeView.set(sport: match.sport)
        locationView.textLabel.text = match.locationInfo.address
        scheduleView.textLabel.text = match.startDate.toString()
        feeView.textLabel.text = "\(String(match.fee).feeString())원"
        peopleCountView.textLabel.text =  "\(match.headCount)/\(match.maxHeadCount)명"
        
        if let matchImageURL = URL(string: match.matchImageURL) {
            sportImageView.kf.setImage(with: matchImageURL)
        }
        
        // TODO: matchHostProfileImageView
        // matchHostNicknameLabel
        
        matchContentLabel.text = match.content
    }
}

// MARK: - UI

extension MatchDetailViewController {
    private func configureTop() {
        sportImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(Constant.sportHeight)
        }
        
        gradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(sportImageView)
            make.height.equalTo(Constant.gradientViewHeight)
        }
    }
    
    private func configureMatchProfileView() {
        matchImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.matchImageHeight)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.bottom.equalTo(sportImageView.snp.bottom).inset(Constant.padding40)
        }
        
        matchTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchImageView)
            make.left.equalTo(matchImageView.snp.right).offset(Constant.padding8)
            make.height.equalTo(Constant.matchTitleHeight)
        }
    }
    
    private func configureInfoView() {
        locationView.snp.makeConstraints { make in
            make.top.equalTo(sportImageView.snp.bottom).offset(Constant.padding24)
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
        
    }
}
