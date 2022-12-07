//
//  AppAlert.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/07.
//

import Foundation
import SwiftUI

struct AppAlert {
    let model: AppAlertModel
    
    init(appAlertModel: AppAlertModel) {
        self.model = appAlertModel
    }
    
    var show: Alert {
        // CASE: 確認アラート
        if model.onCancelClicked != nil {
            return Alert(
                title: Text(model.title ?? ""),
                message: Text(model.message),
                primaryButton: .default(Text(model.okString ?? "OK"), action: {
                    model.onOkClicked()
                }),
                secondaryButton: .default(Text(model.cancelString ?? "キャンセル"), action: {
                    guard let onCancelClicked = model.onCancelClicked else {
                        return
                    }
                    onCancelClicked()
                })
            )
            
        }
        
        // CASE: 知らせアラート
        return Alert(
            title: Text(model.title ?? ""),
            message: Text(model.message),
            dismissButton: .default(Text(model.okString ?? "OK"), action: {
                model.onOkClicked()
            })
        )
    }
}
