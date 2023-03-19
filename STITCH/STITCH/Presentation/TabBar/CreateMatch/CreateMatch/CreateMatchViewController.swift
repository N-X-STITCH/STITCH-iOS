//
//  CreateMatchViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

import FSCalendar
import RxCocoa
import RxSwift

final class CreateMatchViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding2 = 2
        static let padding8 = 8
        static let padding12 = 12
        static let padding14 = 14
        static let padding16 = 16
        static let padding20 = 18
        static let padding24 = 24
        static let padding28 = 28
        static let padding32 = 32
        static let padding48 = 48
        static let radius10 = 10
        static let titleLabelHeight = 56
        static let matchImageHeight = 96
        static let matchCancelButtonWidth = 20
        static let matchInfoViewHeight = 42
        static let matchLocationHeight = 55
        static let matchLocationArrowWidth = 24
        static let titleHeight = 20
        static let textFieldWidth = 120
        static let textFieldHeight = 55
        static let textViewHeight = 158
        static let countLabelHeight = 18
        static let barHeight = 1
        static let clockIconWidth = 18
        static let contentViewHeight = 1700
        static let stepperWidth = 136
        static let stepperHeight = 24
        static let defaultTime = 30
        static let defaultPeople = 1
        static let matchFeeSubTitleHeight = 36
        
        static let titleValidation = 30
        static let contentValidation = 1000
    }
    
    private let finishButton = UIButton().then {
        $0.titleLabel?.font = .Subhead_16
        $0.setTitle("완료", for: .normal)
        $0.setTitle("완료", for: .disabled)
        $0.setTitleColor(.yellow05_primary, for: .normal)
        $0.setTitleColor(.gray10, for: .disabled)
    }
    
    // MARK: ScrollView
    
    private let scrollView = UIScrollView().then {
        $0.keyboardDismissMode = .interactive
    }
    private let contentView = UIView()
    
    // MARK: Title
    
    private let titleLabel = DefaultTitleLabel(text: "즐거운 매치를 위한\n상세 설명을 등록해볼까요?")
    
    // MARK: Match Image
    
    private let matchImageView = SelectPhotoView()
    private let matchImageButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    private let matchImageCancelButton = UIButton().then {
        $0.setImage(.xmarkCircle?.withTintColor(.gray06, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    // MARK: Match Title
    
    private let matchTitleLabel = DefaultTitleLabel(text: "매치 제목", textColor: .gray02, font: .Subhead2_14)
    private lazy var matchTitleTextField = DefaultTextField(placeholder: "매치 제목을 설정해주세요 (30자 이내)").then {
        $0.delegate = self
    }
    private let matchTitleRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let matchTitleCountLabel = DefaultTitleLabel(text: "0 / 30", textColor: .gray09, font: .Caption1_12)
    
    // MARK: Match Content
    
    private let matchDetailTitleLabel = DefaultTitleLabel(text: "상세 내용", textColor: .gray02, font: .Subhead2_14)
    private let matchDetailTextView = DefaultTextView(placeholder: "매치 소개글을 입력해 주세요 (선택)")
    private let matchDetailRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let matchDetailCountLabel = DefaultTitleLabel(text: "0 / 1000", textColor: .gray09, font: .Caption1_12)
    
    // MARK: Match Schedule
    
    private let matchScheduleTitleLabel = DefaultTitleLabel(text: "매치 날짜/시간", textColor: .gray02, font: .Subhead2_14)
    private lazy var matchScheduleTextField = DefaultTextField(placeholder: "날짜와 시간을 설정해주세요").then {
        $0.delegate = self
        $0.tintColor = .clear
    }
    private let matchScheduleRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let matchScheduleInfoView = MatchScheduleInfoView(frame: .zero)
    
    // MARK: Match Schedule - Calendar
    
    private lazy var calendarView = CalendarView(frame: .zero)
    private let clockImageView = UIImageView(
        image: .clock?.withTintColor(.gray02, renderingMode: .alwaysOriginal)
    )
    
    // MARK: Match Schedule - Time
    
    private lazy var startTimeTextField = UITextField().then {
        $0.delegate = self
        $0.text = "오전 1:00"
        $0.textColor = .gray02
        $0.font = .Body1_16
        $0.tintColor = .clear
        $0.inputView = startTimePickerView
        $0.inputAccessoryView = startTimePickerToolBar
    }
    private lazy var startTimePickerView = TimePickerView(viewController: self)
    private let cancelButton = UIBarButtonItem(title: "취소", style: .done, target: nil, action: nil).then {
        $0.tintColor = .gray04
    }
    private let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(title: "확인", style: .done, target: nil, action: nil).then {
        $0.tintColor = .yellow05_primary
    }
    private lazy var startTimePickerToolBar = UIToolbar(
        frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 48))
    ).then {
        $0.backgroundColor = .gray12.withAlphaComponent(0.8)
        $0.setItems([cancelButton, space, doneButton], animated: true)
        $0.sizeToFit()
        $0.set(corners: [.topLeft, .topRight], radius: CGFloat(Constant.radius10))
    }
    
    // MARK: Match Time
    
    private let matchTimeTitleLabel = DefaultTitleLabel(text: "소요시간", textColor: .gray02, font: .Subhead2_14)
    private lazy var matchTimeTextField = DefaultTextField(placeholder: "플레이 시간 설정").then {
        $0.delegate = self
        $0.text = "플레이 시간 설정"
        $0.clearButtonMode = .never
    }
    private let matchTimeStepper = Stepper(defaultText: "30분", defaultValue: Constant.defaultTime)
    private let matchTimeRowView = UIView().then { $0.backgroundColor  = .gray09 }
    
    // MARK: Match Location
    
    private let matchLocationTitleLabel = DefaultTitleLabel(text: "매치 장소", textColor: .gray02, font: .Subhead2_14)
    private let matchLocationButton = DefaultButton(
        title: "  매치 장소를 선택하세요",
        fontColor: .gray09,
        normalColor: .clear
    ).then {
        $0.contentHorizontalAlignment = .left
    }
    private let matchLocationArrowButton = UIButton().then {
        $0.setImage(.arrowRight?.withTintColor(.gray09, renderingMode: .alwaysOriginal), for: .normal)
    }
    private let matchLocationRowView = UIView().then { $0.backgroundColor = .gray09 }
    
    // MARK: Match People Count
    
    private let matchPeopleTitleLabel = DefaultTitleLabel(text: "참가인원", textColor: .gray02, font: .Subhead2_14)
    private let matchPeopleSubTitleLabel = DefaultTitleLabel(text: "(본인을 포함한 총 참여 인원수)", textColor: .gray06, font: .Body2_14)
    private lazy var matchPeopleTextField = DefaultTextField(placeholder: "인원수 설정").then {
        $0.delegate = self
        $0.text = "인원수 설정"
        $0.clearButtonMode = .never
    }
    private let matchPeopleStepper = Stepper(defaultText: "\(Constant.defaultPeople)명", defaultValue: Constant.defaultPeople)
    private let matchPeopleRowView = UIView().then { $0.backgroundColor  = .gray09 }
    
    // MARK: Match Fee
    
    private let matchFeeTitleLabel = DefaultTitleLabel(text: "참가비가 있나요?", textColor: .gray02, font: .Subhead2_14)
    private let matchFeeSubTitleLabel = DefaultTitleLabel(
        text: "개인 거래로 문제가 발생하는 것을 예방하기 위해 매치 진행에 필요한 모든 금액을 참가비로 설정해 주세요.",
        textColor: .gray06,
        font: .Caption1_12
    )
    private let matchFeeLabel = UILabel().then {
        $0.text = "₩"
        $0.textColor = .gray02
        $0.font = .Body1_16
    }
    private let matchFeeTextField = DefaultTextField(placeholder: "0").then {
        $0.keyboardType = .numberPad
    }
    private let matchFeeRowView = UIView().then { $0.backgroundColor  = .gray09 }
    
    // MARK: Properties
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 E요일"
        return formatter
    }()
    
    private let createMatchViewModel: CreateMatchViewModel
    
    private lazy var imagePickerController = ImagePickerController()
    
    // MARK: - Initializer
    
    init(createMatchViewModel: CreateMatchViewModel) {
        self.createMatchViewModel = createMatchViewModel
        super.init()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let rect = scrollView.recursiveUnionInDepthFor(view: scrollView)
        scrollView.contentLayoutGuide.snp.updateConstraints { make in
            make.height.equalTo(rect.height)
        }
    }
    
    // MARK: - Methods
    
    override func setting() {
        changeButton(isEnabled: false)
        // TODO: 삭제
        scrollView.delegate = self
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.isUserInteractionEnabled = true
        imagePickerController.delegate = self
    }
    
    override func bind() {
        bindRowViewUpdates()
        bindTextFieldScroll()
        
        let finishButtonTapValidate = finishButton.rx.tap
            .filter { [weak self] _ in
                guard let owner = self else { return false }
                if (owner.matchTitleTextField.text ?? "") == "" {
                    owner.matchTitleTextField.becomeFirstResponder()
                    return false
                } else if (owner.matchScheduleTextField.text ?? "") == "" {
                    owner.hideKeyboard()
                    owner.moveScrollView(owner.matchScheduleTitleLabel)
                    return false
                } else if (owner.matchLocationButton.titleLabel?.text ?? "" ) == "매치 장소를 선택하세요" {
                    owner.hideKeyboard()
                    owner.moveScrollView(owner.matchLocationTitleLabel)
                    return false
                } else {
                    owner.hideKeyboard()
                    return true
                }
            }
            
        
        doneButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.startTimeTextField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.startTimeTextField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        Observable.of(matchLocationButton.rx.tap, matchLocationArrowButton.rx.tap).merge()
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.setLocation)
            }
            .disposed(by: disposeBag)
        
        let imageObservable = matchImageButton.rx.tap
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.imagePickerController.pickImage()
            }
            .share()
        
        imageObservable
            .bind(to: matchImageView.photoView.rx.image)
            .disposed(by: disposeBag)
        
        let matchTitleTextFieldChange = matchTitleTextField.rx.text.orEmpty
            .debounce(.milliseconds(10), scheduler: MainScheduler.instance)
            .share()
        
        matchTitleTextFieldChange
            .withUnretained(self)
            .subscribe { owner, title in
                owner.validate(
                    text: title,
                    textField: owner.matchTitleTextField,
                    countLabel: owner.matchTitleCountLabel,
                    validateCount: Constant.titleValidation
                )
                owner.createMatchViewModel.newMatch.matchTitle = owner.matchTitleTextField.text ?? ""
            }
            .disposed(by: disposeBag)
        
        let matchContentTextFieldChange = matchDetailTextView.rx.text
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .share()
        
        matchContentTextFieldChange
            .withUnretained(self)
            .subscribe { owner, content in
                guard let content else { return }
                owner.validate(
                    text: content,
                    textView: owner.matchDetailTextView,
                    countLabel: owner.matchDetailCountLabel,
                    validateCount: Constant.contentValidation
                )
                owner.createMatchViewModel.newMatch.matchTitle = owner.matchDetailTextView.text ?? ""
            }
            .disposed(by: disposeBag)
        
        let matchTimeObservable = matchTimeStepper.valueObservable().share()
        
        matchTimeObservable
            .withUnretained(self)
            .subscribe { owner, matchTime in
                owner.createMatchViewModel.newMatch.duration = matchTime
                owner.matchTimeStepper.countLabel.text = matchTime.matchTimeString()
            }
            .disposed(by: disposeBag)
        
        let matchPeopleCountObservable = matchPeopleStepper.valueObservable().share()
        
        matchPeopleCountObservable
            .withUnretained(self)
            .subscribe { owner, peopleCount in
                owner.createMatchViewModel.newMatch.maxHeadCount = peopleCount
                owner.matchPeopleStepper.countLabel.text = "\(peopleCount)명"
            }
            .disposed(by: disposeBag)
        
        let matchFeeObservable = matchFeeTextField.rx.text.orEmpty.share()
        
        matchFeeObservable
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { owner, fee in
                owner.createMatchViewModel.newMatch.fee = fee.feeInt()
                owner.matchFeeTextField.text = fee.feeString()
            }
            .disposed(by: disposeBag)
        
        let input = CreateMatchViewModel.Input(completeFinishButtom: finishButtonTapValidate)
        
        imageObservable
            .withUnretained(self)
            .subscribe { owner, data in
                input.matchImage.onNext(data.jpegData(compressionQuality: 1.0))
            }
            .disposed(by: disposeBag)
        
        let output = createMatchViewModel.transform(input)
        
        output.createdMatchResult
            .withUnretained(self)
            .subscribe (onNext: { owner, match in
                owner.coordinatorPublisher.onNext(.created(match: match))
            }, onError: { [weak self] error in
                self?.handle(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.backgroundColor = .background
        navigationItem.title = "매치 개설하기"
        
        let rightBarButton = UIBarButtonItem(customView: finishButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.height.equalTo(Constant.contentViewHeight)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        configureContentView()
    }
    
    private func bindRowViewUpdates() {
        matchTitleTextField.editingDidEnd(rowView: matchTitleRowView).disposed(by: disposeBag)
        matchDetailTextView.editingDidEnd(rowView: matchDetailRowView).disposed(by: disposeBag)
        matchFeeTextField.editingDidEnd(rowView: matchFeeRowView).disposed(by: disposeBag)
    }
    
    private func bindTextFieldScroll() {
        matchTitleTextField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.moveScrollView(owner.matchTitleLabel, rowView: owner.matchTitleRowView)
            }
            .disposed(by: disposeBag)
        
        matchDetailTextView.rx.didBeginEditing
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.moveScrollView(owner.matchDetailTitleLabel, rowView: owner.matchDetailRowView)
            }
            .disposed(by: disposeBag)
        
        matchFeeTextField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.moveScrollView(owner.matchFeeTitleLabel, rowView: owner.matchFeeRowView)
            }
            .disposed(by: disposeBag)
        
        startTimeTextField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.moveScrollView(owner.calendarView)
            }
            .disposed(by: disposeBag)
    }
    
    private func changeButton(isEnabled: Bool) {
        finishButton.isEnabled = isEnabled
    }
    
    private func validate(text: String, textView: UITextView, countLabel: UILabel, validateCount: Int) {
        let offset = validateCount < text.count ? validateCount : text.count
        let index = text.index(text.startIndex, offsetBy: offset)
        let text = String(text[..<index])
        textView.text = text
        bindTextCount(text: text, label: countLabel, validateCount: validateCount)
    }
    
    private func validate(text: String, textField: UITextField, countLabel: UILabel, validateCount: Int) {
        let offset = validateCount < text.count ? validateCount : text.count
        let index = text.index(text.startIndex, offsetBy: offset)
        let text = String(text[..<index])
        textField.text = text
        bindTextCount(text: text, label: countLabel, validateCount: validateCount)
    }
    
    private func bindTextCount(text: String, label: UILabel, validateCount: Int) {
        label.text = "\(text.count) / \(validateCount)"
    }
    
    private func moveScrollView(_ view: UIView, rowView: UIView? = nil) {
        if view == matchFeeTitleLabel || view == calendarView {
            scrollView.setContentOffset(CGPoint(x: 0, y: view.frame.midY - 240), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: 0, y: view.frame.midY - 20), animated: true)
        }
        if let rowView {
            rowView.updateBackgroundColor(isEditing: true)
        }
    }
    
    func didReceive(locationInfo: LocationInfo) {
        matchLocationButton.setTitle("  \(locationInfo.address)", for: .normal)
        matchLocationButton.setTitleColor(.gray02, for: .normal)
    }
}

// MARK: - UIScrollView Delegate

extension CreateMatchViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        hideKeyboard()
    }
}

// MARK: - FSCalendar Delegate

extension CreateMatchViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        createMatchViewModel.newMatch.startDate = date
        let selectedDateText = dateFormatter.string(from: date)
        
        matchScheduleTextField.text = "\(selectedDateText) / \(startTimeTextField.text ?? "")"
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

extension CreateMatchViewController: FSCalendarDelegateAppearance {
    func calendar(
        _ calendar: FSCalendar,
        appearance: FSCalendarAppearance,
        titleDefaultColorFor date: Date
    ) -> UIColor? {
        let dateMonth = Calendar.current.component(.month, from: date)
        let dateWeekday = Calendar.current.component(.weekday, from: date) - 1
        let dateDay = Calendar.current.component(.day, from: date)
        let nowMonth = Calendar.current.component(.month, from: Date.now)
        let nowDay = Calendar.current.component(.day, from: Date.now)

        if dateMonth < nowMonth {
            return .gray10
        } else if dateMonth == nowMonth && dateDay == nowDay {
            return .gray12
        } else if dateMonth == nowMonth && dateDay < nowDay {
            return .gray10
        } else
        if Calendar.current.shortWeekdaySymbols[dateWeekday] == "일" {
            return .error01
        } else if Calendar.current.shortWeekdaySymbols[dateWeekday] == "토" {
            return .secondary
        }

        return .gray04
    }
}

// MARK: - UIPickerViewDelegaet

extension CreateMatchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return Meridiem.allCases[row].rawValue
        case 1:
            return "\(Hour.allCases[row].rawValue)"
        default:
            return "\(Minute.allCases[row].rawValue)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            guard let text = startTimeTextField.text else { return }
            let timeText = text.components(separatedBy: " ")[1]
            let times = timeText.components(separatedBy: ":")
            startTimeTextField.text = "\(Meridiem.allCases[row].rawValue) \(timeText)"
            createMatchViewModel.newMatch.startHour = Int(times[0])!
            createMatchViewModel.newMatch.startMinute = Int(times[1])!
        case 1:
            guard let text = startTimeTextField.text else { return }
            let meridiem = text.components(separatedBy: " ")[0]
            let timeText = text.components(separatedBy: " ")[1]
            let times = timeText.components(separatedBy: ":")
            startTimeTextField.text = "\(meridiem) \(Hour.allCases[row].rawValue):\(times[1])"
            createMatchViewModel.newMatch.startHour = Int(times[0])!
            createMatchViewModel.newMatch.startMinute = Int(times[1])!
        case 2:
            guard let text = startTimeTextField.text else { return }
            let meridiem = text.components(separatedBy: " ")[0]
            let timeText = text.components(separatedBy: " ")[1]
            let times = timeText.components(separatedBy: ":")
            startTimeTextField.text = "\(meridiem) \(times[0]):\(Minute.allCases[row].rawValue)"
            createMatchViewModel.newMatch.startHour = Int(times[0])!
            createMatchViewModel.newMatch.startMinute = Int(times[1])!
        default: return
        }
        guard let date = matchScheduleTextField.text else { return }
        matchScheduleTextField.text = "\(date.components(separatedBy: " / ")[0]) / \(startTimeTextField.text ?? "")"
    }
}

// MARK: - UITextFieldDelegate

extension CreateMatchViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == matchScheduleTextField ||
           textField == matchTimeTextField || textField == matchPeopleTextField {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == matchTitleTextField {
            matchDetailTextView.becomeFirstResponder()
        } else if textField == matchDetailTextView {
            moveScrollView(matchScheduleTitleLabel)
        }
        return true
    }
}

// MARK: - UI

extension CreateMatchViewController {
    private func configureContentView() {
        contentView.addSubviews([titleLabel, matchImageView, matchImageButton])
        contentView.addSubviews([matchTitleLabel, matchTitleTextField, matchTitleRowView, matchTitleCountLabel])
        contentView.addSubviews([matchDetailTitleLabel, matchDetailTextView, matchDetailRowView, matchDetailCountLabel])
        contentView.addSubviews([matchScheduleTitleLabel, matchScheduleTextField, matchScheduleRowView, matchScheduleInfoView])
        contentView.addSubviews([calendarView, startTimeTextField, clockImageView])
        contentView.addSubviews([matchTimeTitleLabel, matchTimeTextField, matchTimeStepper, matchTimeRowView])
        contentView.addSubviews([matchLocationTitleLabel, matchLocationButton, matchLocationRowView, matchLocationArrowButton])
        contentView.addSubviews([
            matchPeopleTitleLabel, matchPeopleSubTitleLabel, matchPeopleTextField, matchPeopleStepper, matchPeopleRowView
        ])
        contentView.addSubviews([matchFeeTitleLabel, matchFeeSubTitleLabel, matchFeeLabel, matchFeeTextField, matchFeeRowView])
        
        configureTitleView()
        configureDetailView()
        configureScheduleView()
        configureTimeView()
        configureLocationView()
        configurePeopleView()
        configureFeeView()
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
        
        matchImageButton.snp.makeConstraints { make in
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
        
        matchScheduleInfoView.snp.makeConstraints { make in
            make.top.equalTo(matchScheduleRowView.snp.bottom).offset(Constant.padding12)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.matchInfoViewHeight)
            
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(matchScheduleInfoView.snp.bottom).offset(Constant.padding32)
            make.height.equalTo(312) // TODO: 미정
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        startTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(Constant.padding28)
            make.centerX.equalToSuperview()
        }
        
        clockImageView.snp.makeConstraints { make in
            make.right.equalTo(startTimeTextField.snp.left).offset(-Constant.padding8)
            make.centerY.equalTo(startTimeTextField)
            make.width.height.equalTo(Constant.clockIconWidth)
        }
        
        startTimePickerToolBar.updateConstraintsIfNeeded()
    }
    
    private func configureTimeView() {
        matchTimeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(startTimeTextField.snp.bottom).offset(Constant.padding48)
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
        
        matchLocationButton.snp.makeConstraints { make in
            make.top.equalTo(matchLocationTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.matchLocationHeight)
        }
        
        matchLocationArrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.padding24)
            make.centerY.equalTo(matchLocationButton)
            make.width.height.equalTo(Constant.matchLocationArrowWidth)
        }
        
        matchLocationRowView.snp.makeConstraints { make in
            make.top.equalTo(matchLocationButton.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
    }
    
    private func configurePeopleView() {
        matchPeopleTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchLocationRowView.snp.bottom).offset(Constant.padding32)
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
    
    private func configureFeeView() {
        matchFeeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchPeopleRowView.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        matchFeeSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchFeeTitleLabel.snp.bottom).offset(Constant.padding2)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.matchFeeSubTitleHeight)
        }
        
        matchFeeLabel.snp.makeConstraints { make in
            make.top.equalTo(matchFeeSubTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(Constant.padding24)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        matchFeeTextField.snp.makeConstraints { make in
            make.top.equalTo(matchFeeSubTitleLabel.snp.bottom)
            make.left.equalTo(matchFeeLabel.snp.right).offset(Constant.padding2)
            make.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        matchFeeRowView.snp.makeConstraints { make in
            make.top.equalTo(matchFeeTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
    }
}
