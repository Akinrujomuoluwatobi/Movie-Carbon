//
//  CoordinatorAction.swift
//  GoMoney
//

import UIKit
import UserNotifications

enum CoordinatorAction {
    case createTransactionPinFlow
    case fundAccountFlow
    case requestMoneyFlow
    case payBillsFlow
    case splitPaymentsFlow
    case paymentRequest(PaymentRequestDeeplinkData)
    case upgradeAccountFlow
    case regularDocumentVerification(DocumentType)
    case upgradeAccountFromSignup
    case supportTicket(requestId: String)
    case accountUpgradeKyc(path: NotificationsRouter)
}

protocol CoordinatorActionFactory {
    func make(from userActivity: NSUserActivity?) -> CoordinatorAction?
    func make(from launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> CoordinatorAction?
    func make(from notification: [AnyHashable: Any]?) -> CoordinatorAction?
    func make(from shortcutItem: UIApplicationShortcutItem) -> CoordinatorAction?
    func make(from response: UNNotificationResponse?) -> CoordinatorAction?
    func make(from deviceToken: String?) -> CoordinatorAction?
    func make(from urlSchemeHost: String, parameters: [String: Any]) -> CoordinatorAction?
}
