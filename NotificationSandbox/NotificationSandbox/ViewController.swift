//
//  ViewController.swift
//  NotificationSandbox
//
//  Created by soranoba on 2021/09/02.
//

import UIKit

class ViewController: UIViewController {

    private let notificationCenter = UNUserNotificationCenter.current()

    // MARK: - Lifecycle

    init() {
        super.init(nibName: "ViewController", bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light

        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        }
    }

    // MARK: - Actions

    @IBAction private func didChangeBackgroundColor(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            overrideUserInterfaceStyle = .light
        case 1:
            overrideUserInterfaceStyle = .dark
        default:
            break
        }
    }

    @IBAction private func didTapPush(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "通知テスト"
        content.body = """
            雨ニモマケズ
            風ニモマケズ
            雪ニモ夏ノ暑サニモマケヌ
            丈夫ナカラダヲモチ
            慾ハナク
            決シテ瞋ラズ
            イツモシヅカニワラッテヰル
            一日ニ玄米四合ト
            味噌ト少シノ野菜ヲタベ
            アラユルコトヲ
            ジブンヲカンジョウニ入レズニ
            ヨクミキキシワカリ
            ソシテワスレズ
        """
        content.sound = .default

        let req = UNNotificationRequest(identifier: "test", content: content, trigger: nil)
        notificationCenter.add(req) { error in
            if let error = error {
                print("\(error)")
            }
        }
    }
}

