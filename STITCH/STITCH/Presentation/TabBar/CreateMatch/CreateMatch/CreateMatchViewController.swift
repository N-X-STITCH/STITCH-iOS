//
//  CreateMatchViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

final class CreateMatchViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding2 = 2
        static let padding8 = 8
        static let padding12 = 12
        static let padding16 = 16
        static let padding20 = 18
        static let padding24 = 24
        static let padding32 = 32
        static let titleLabelHeight = 56
        static let matchImageHeight = 96
        static let titleHeight = 20
        static let textFieldWidth = 200
        static let textFieldHeight = 55
        static let textViewHeight = 158
        static let countLabelHeight = 18
        static let barHeight = 1
        static let contentViewHeight = 1500
        static let stepperWidth = 100
        static let stepperHeight = 24
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = DefaultTitleLabel(text: "즐거운 매치를 위한\n상세 설명을 등록해볼까요?")
    private let matchImageView = SelectPhotoView()
    
    private let matchTitleLabel = DefaultTitleLabel(text: "매치 제목", textColor: .gray02, font: .Subhead2_14)
    private let matchTitleTextField = DefaultTextField(placeholder: "매치 제목을 설정해주세요 (30자 이내)")
    private let matchTitleRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let matchTitleCountLabel = DefaultTitleLabel(text: "0 / 30", textColor: .gray09, font: .Caption1_12)
    
    private let matchDetailTitleLabel = DefaultTitleLabel(text: "상세 내용", textColor: .gray02, font: .Subhead2_14)
    private let matchDetailTextView = DefaultTextView(placeholder: "매치 소개글을 입력해 주세요 (선택)")
    private let matchDetailRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let matchDetailCountLabel = DefaultTitleLabel(text: "0 / 1000", textColor: .gray09, font: .Caption1_12)
    
    private let matchScheduleTitleLabel = DefaultTitleLabel(text: "매치 날짜/시간", textColor: .gray02, font: .Subhead2_14)
    private let matchScheduleTextField = DefaultTextField(placeholder: "날짜와 시간을 설정해주세요")
    private let matchScheduleRowView = UIView().then { $0.backgroundColor  = .gray09 }
    
    // TODO: 달력
    
    private let matchTimeTitleLabel = DefaultTitleLabel(text: "소요시간", textColor: .gray02, font: .Subhead2_14)
    private let matchTimeTextField = DefaultTextField(placeholder: "날짜와 시간을 설정해주세요")
    private let matchTimeStepper = Stepper(defaultText: "30분", defaultValue: 30)
    private let matchTimeRowView = UIView().then { $0.backgroundColor  = .gray09 }
    
    // TODO: 장소 선택 버튼
    private let matchLocationTitleLabel = DefaultTitleLabel(text: "매치 장소", textColor: .gray02, font: .Subhead2_14)
    
    
    private let matchPeopleTitleLabel = DefaultTitleLabel(text: "참가인원", textColor: .gray02, font: .Subhead2_14)
    private let matchPeopleSubTitleLabel = DefaultTitleLabel(text: "(본인을 포함한 총 참여 인원수)", textColor: .gray06, font: .Body2_14)
    private let matchPeopleTextField = DefaultTextField(placeholder: "인원수 설정")
    private let matchPeopleStepper = Stepper(defaultText: "2명", defaultValue: 2)
    private let matchPeopleRowView = UIView().then { $0.backgroundColor  = .gray09 }
    
    private let matchFeeTitleLabel = DefaultTitleLabel(text: "참가비가 있나요?", textColor: .gray02, font: .Subhead2_14)
    private let matchFeeSubTitleLabel = DefaultTitleLabel(
        text: "개인 거래로 문제가 발생하는 것을 예방하기 위해 매치 진행에 필요한 모든 금액을 참가비로 설정해 주세요.",
        textColor: .gray06,
        font: .Caption1_12
    )
    
    // MARK: Properties
    
    private let createMatchViewModel: CreateMatchViewModel
    
    // MARK: - Initializer
    
    init(createMatchViewModel: CreateMatchViewModel) {
        self.createMatchViewModel = createMatchViewModel
        super.init()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize.height = 1500
    }
    
    // MARK: - Methods
    
    override func setting() {
        // TODO: 삭제
        scrollView.delegate = self
    }
    
    override func bind() {
        
    }
    
    override func configureNavigation() {
        
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        configureContentView()
    }
}

extension CreateMatchViewController: UIScrollViewDelegate {
}

extension CreateMatchViewController {
    private func configureContentView() {
        contentView.addSubviews([titleLabel, matchImageView])
        contentView.addSubviews([matchTitleLabel, matchTitleTextField, matchTitleRowView, matchTitleCountLabel])
        contentView.addSubviews([matchDetailTitleLabel, matchDetailTextView, matchDetailRowView, matchDetailCountLabel])
        contentView.addSubviews([matchScheduleTitleLabel, matchScheduleTextField, matchScheduleRowView])
        contentView.addSubviews([matchTimeTitleLabel, matchTimeTextField, matchTimeStepper, matchTimeRowView])
        contentView.addSubviews([matchLocationTitleLabel])
        contentView.addSubviews([matchPeopleTitleLabel, matchPeopleSubTitleLabel, matchPeopleTextField, matchPeopleStepper, matchPeopleRowView])
        contentView.addSubviews([matchFeeTitleLabel, matchFeeSubTitleLabel])
        
        configureTitleView()
        configureDetailView()
        configureScheduleView()
        configureTimeView()
        configureLocationView()
        configurePeopleView()
    }
    
    private func configureTitleView() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleLabelHeight)
        }
        
        matchImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.matchImageHeight)
        }
        
        matchTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchImageView.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        matchTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(matchTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        matchTitleRowView.snp.makeConstraints { make in
            make.top.equalTo(matchTitleTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
        
        matchTitleCountLabel.snp.makeConstraints { make in
            make.top.equalTo(matchTitleRowView.snp.bottom).offset(Constant.padding2)
            make.right.equalToSuperview().inset(Constant.padding24)
            make.height.equalTo(Constant.countLabelHeight)
        }
    }
    
    private func configureDetailView() {
        matchDetailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchTitleCountLabel.snp.bottom).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        matchDetailTextView.snp.makeConstraints { make in
            make.top.equalTo(matchDetailTitleLabel.snp.bottom).offset(Constant.padding8)
            make.left.right.equalToSuperview().inset(Constant.padding20)
            make.height.equalTo(Constant.textViewHeight)
        }
        
        matchDetailRowView.snp.makeConstraints { make in
            make.top.equalTo(matchDetailTextView.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
        
        matchDetailCountLabel.snp.makeConstraints { make in
            make.top.equalTo(matchDetailRowView.snp.bottom).offset(Constant.padding2)
            make.right.equalToSuperview().inset(Constant.padding24)
            make.height.equalTo(Constant.countLabelHeight)
        }
    }
    
    private func configureScheduleView() {
        matchScheduleTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchDetailCountLabel.snp.bottom).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        matchScheduleTextField.snp.makeConstraints { make in
            make.top.equalTo(matchScheduleTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        matchScheduleRowView.snp.makeConstraints { make in
            make.top.equalTo(matchScheduleTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
    }
    
    private func configureTimeView() {
        matchTimeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchScheduleRowView.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        matchTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(matchTimeTitleLabel.snp.bottom)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.width.equalTo(Constant.textFieldWidth)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        matchTimeStepper.snp.makeConstraints { make in
            make.centerY.equalTo(matchTimeTextField)
            make.right.equalToSuperview().inset(Constant.padding24)
            make.width.equalTo(Constant.stepperWidth)
            make.height.equalTo(Constant.stepperHeight)
        }
        
        matchTimeRowView.snp.makeConstraints { make in
            make.top.equalTo(matchTimeTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
    }
    
    private func configureLocationView() {
        matchLocationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchTimeRowView.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
    }
    
    private func configurePeopleView() {
        matchPeopleTitleLabel.snp.makeConstraints { make in
            // TODO: 변경
            make.top.equalTo(matchLocationTitleLabel.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        matchPeopleSubTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(matchPeopleTitleLabel)
            make.left.equalTo(matchPeopleTitleLabel.snp.right).offset(Constant.padding2)
        }
        
        matchPeopleTextField.snp.makeConstraints { make in
            make.top.equalTo(matchPeopleTitleLabel.snp.bottom)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.width.equalTo(Constant.textFieldWidth)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        matchPeopleStepper.snp.makeConstraints { make in
            make.centerY.equalTo(matchPeopleTextField)
            make.right.equalToSuperview().inset(Constant.padding24)
            make.width.equalTo(Constant.stepperWidth)
            make.height.equalTo(Constant.stepperHeight)
        }
        
        matchPeopleRowView.snp.makeConstraints { make in
            make.top.equalTo(matchPeopleTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
    }
}
