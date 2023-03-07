//
//  CalendarView.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

import FSCalendar

final class CalendarView: FSCalendar {
    
    enum Constant {
        static let headerHeight = 48
        static let padding12 = 12
        static let padding16 = 16
    }
    
    private lazy var leftButton = UIButton().then {
        $0.setImage(.arrowLeft, for: .normal)
        $0.tag = -1
        $0.addTarget(self, action: #selector(scrollCurrentPage(_:)), for: .touchUpInside)
    }
    
    private lazy var rightButton = UIButton().then {
        $0.setImage(.arrowRight, for: .normal)
        $0.tag = 1
        $0.addTarget(self, action: #selector(scrollCurrentPage(_:)), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubviews([leftButton, rightButton])
        
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding16)
            make.left.equalToSuperview().offset(Constant.padding12)
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().inset(Constant.padding12)
        }
    }
    
    private func configureCalendar() {
        locale = Locale(identifier: "ko_KR")
        scrollEnabled = true
        scrollDirection = .horizontal
        scope = .month
        headerHeight = CGFloat(Constant.headerHeight)
        appearance.headerTitleFont = .Body1_16
        appearance.weekdayFont = .Body2_14
        appearance.titleFont = .Body2_14
        appearance.headerDateFormat = "M월 YYYY년"
        appearance.headerTitleColor = .gray02
        appearance.titleDefaultColor = .gray04
        appearance.titleWeekendColor = .error01
        appearance.titlePlaceholderColor = .gray10
        appearance.weekdayTextColor = .gray04
        appearance.todayColor = .yellow01
        appearance.titleTodayColor = .gray12
        appearance.headerMinimumDissolvedAlpha = 0.0
        appearance.selectionColor = .yellow05_primary
        appearance.titleSelectionColor = .gray12
        calendarWeekdayView.weekdayLabels[0].textColor = .error01
        calendarWeekdayView.weekdayLabels[6].textColor = .secondary
    }
    
    @objc func scrollCurrentPage(_ sender: UIButton) {
        let cur = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = sender.tag
            
        currentPage = cur.date(byAdding: dateComponents, to: currentPage) ?? Date.now
        setCurrentPage(currentPage, animated: true)
    }
}
