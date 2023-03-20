//
//  SettingViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit
import MessageUI

final class SettingViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
    }
    
    private let settingTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .background
        $0.sectionFooterHeight = 32
    }
    
    // MARK: Properties
    
    private let settingViewModel: SettingViewModel
    
    // MARK: - Initializer
    
    init(settingViewModel: SettingViewModel) {
        self.settingViewModel = settingViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(
            SettingHeaderView.self,
            forHeaderFooterViewReuseIdentifier: SettingHeaderView.reuseIdentifier
        )
        settingTableView.register(
            SettingFooterView.self,
            forHeaderFooterViewReuseIdentifier: SettingFooterView.reuseIdentifier
        )
    }
    
    override func bind() {
        let itemSelected = settingTableView.rx.itemSelected.share()
        
        let input = SettingViewModel.Input(tableViewSelect: itemSelected)
        
        let output = settingViewModel.transform(input: input)
        
        output.logoutResult
            .withUnretained(self)
            .subscribe (onNext: { owner, _ in
                owner.coordinatorPublisher.onNext(.showLogin)
            }, onError: { [weak self] error in
                self?.handle(error: error)
            })
            .disposed(by: disposeBag)
        
        output.signoutResult
            .withUnretained(self)
            .subscribe (onNext: { owner, _ in
                owner.coordinatorPublisher.onNext(.showLogin)
            }, onError: { [weak self] error in
                self?.handle(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
    }
    
    override func configureUI() {
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: GuideSection.opinion.row, section: SettingSection.guide.section):
            sendMail()
        case IndexPath(row: NoneSection.version.row, section: SettingSection.none.section):
            coordinatorPublisher.onNext(.version)
        default: return
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SettingHeaderView.reuseIdentifier
        ) as? SettingHeaderView else {
            return UIView()
        }
        header.set(title: SettingSection.allCases[section].title)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SettingFooterView.reuseIdentifier
        ) as? SettingFooterView else {
            return UIView()
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return GuideSection.allCases.count
        case 1: return AccountSection.allCases.count
        case 2: return NoneSection.allCases.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        var background = cell.defaultBackgroundConfiguration()
        content.attributedText = makeTableViewCellTitle(indexPath)
        background.backgroundColor = .background
        cell.contentConfiguration = content
        cell.backgroundConfiguration = background
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func makeTableViewCellTitle(_ indexPath: IndexPath) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.Body2_14 ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray02
        ]
        return NSAttributedString(
            string: SettingSection.allCases[indexPath.row].rowTitle(indexPath),
            attributes: attributes
        )
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            let bodyString = "개선 및 의견, 문의사항을 남겨주세요."
            composeViewController.setToRecipients(["asdfz888@naver.com"])
            composeViewController.setSubject("[STITCH] 문의 및 오류 제보")
            composeViewController.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeViewController, animated: true, completion: nil)
        } else {
            print("메일 보내기 실패")
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
