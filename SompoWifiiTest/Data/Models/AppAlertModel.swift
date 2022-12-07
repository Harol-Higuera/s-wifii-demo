//
//  AppAlertModel.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/07.
//

import Foundation

struct AppAlertModel: Equatable, Identifiable {
    
    static func == (lhs: AppAlertModel, rhs: AppAlertModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    
    let title: String?
    let message: String
    let okString: String?
    let cancelString: String?
    let onOkClicked: () -> Void
    var onCancelClicked: (() -> Void)? = nil
    
    init(
        message: String,
        title: String?,
        okString: String?,
        cancelString: String?,
        onOkClicked: @escaping () -> Void,
        onCancelClicked: (() -> Void)?
    ) {
        self.message = message
        self.title = title
        self.okString = okString
        self.cancelString = cancelString
        self.onOkClicked = onOkClicked
        self.onCancelClicked = onCancelClicked
    }
    
    init(
        toConfirm message: String,
        onOkClicked: @escaping () -> Void,
        onCancelClicked: @escaping () -> Void
    ) {
        self.init(message: message, title: nil, okString: nil, cancelString: nil, onOkClicked: onOkClicked, onCancelClicked: onCancelClicked)
    }
    
    init(
        toNotice message: String,
        onOkClicked: @escaping () -> Void
    ) {
        self.init(message: message, title: nil, okString: nil, cancelString: nil, onOkClicked: onOkClicked, onCancelClicked: nil)
    }
    
    init(
        toNoticeOverrideAll message: String,
        title: String, okString: String?,
        cancelString: String?,
        onOkClicked: @escaping () -> Void
    ) {
        self.init(message: message, title: title, okString: okString, cancelString: cancelString, onOkClicked: onOkClicked, onCancelClicked: nil)
    }
    
    init(
        toConfirmOverrideAll message: String,
        title: String,
        okString: String?,
        cancelString: String?,
        onOkClicked: @escaping () -> Void,
        onCancelClicked: @escaping () -> Void
    ) {
        self.init(message: message, title: title, okString: okString, cancelString: cancelString, onOkClicked: onOkClicked, onCancelClicked: onCancelClicked)
    }
}
