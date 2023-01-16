//
//  MainScreen.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                if (viewModel.isConnectedToWifii == nil) {
                    Text("Loading...")
                } else {
                    let isConnectedToWifii = viewModel.isConnectedToWifii ?? true
                    
                    if (!isConnectedToWifii) {
                        
                        VStack {
                            Form {
                                Section(header: Text("SSID")) {
                                    TextField("SSID", text:  $viewModel.entrySsid)
                                        .padding(.all)
                                        .background(Color(red: 245, green: 245, blue: 245))
                                }
                                Section(header: Text("パスワード")) {
                                    TextField("パスワード", text:  $viewModel.entryPassword)
                                        .padding(.all)
                                        .background(Color(red: 245, green: 245, blue: 245))
                                }
                                
                                Section(header: Text("履歴")) {
                                    DevicesList(models: viewModel.devices, viewModel: viewModel, onPopulateFields: { model in
                                        viewModel.populateFields(model: model)
                                    })
                                }
                            }
                            .navigationBarItems(
                                trailing: Button(action: {
                                    viewModel.registerDevice(
                                        ssid: viewModel.entrySsid,
                                        password: viewModel.entryPassword) { errorMessage in
                                            let model = AppAlertModel(toNotice: errorMessage, onOkClicked: {
                                                viewModel.resetAlertModel()
                                            })
                                            viewModel.updateAlertModel(appAlertModel: model)
                                        }
                                }) {
                                    Text("登録")
                                        .foregroundColor(Color.accentColor)
                                }
                            )
                        }
                        .navigationTitle("未登録")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        
                    } else {
                        Form {
                            Section(header: Text("SSID")) {
                                Text(viewModel.deviceSSid)
                                    .padding(.all)
                                    .background(Color(red: 245, green: 245, blue: 245))
                            }
                        }
                        .navigationTitle("登録済み")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(
                            trailing: Button(action: {
                                viewModel.disconnectDevice()
                            }) {
                                Text("切る")
                                    .foregroundColor(Color.accentColor)
                            }
                        )
                    }
                }
            }
            if viewModel.isLoading {
                Loader()
            }
            
        }.alert(item: $viewModel.appAlertModel) { model in
            AppAlert(appAlertModel: model).show
        }
    }
}


struct DevicesList: View {
    let models: [DeviceModel]
    let viewModel: MainScreen.ViewModel
    let onPopulateFields: (DeviceModel) -> Void
    var body: some View {
        if models.isEmpty {
            Spacer()
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(0...models.count - 1, id: \.self) { index in
                        let model = models[index]
                        Button(action: {
                            onPopulateFields(model)
                        }) {
                            DevicetItem(
                                model: model,
                                onDelete: {
                                    viewModel.updateAlertModel(
                                        appAlertModel: AppAlertModel(
                                            toConfirm: "削除しますか？",
                                            onOkClicked: {
                                                viewModel.resetAlertModel()
                                                viewModel.deleteDeviceModel(model: model)
                                            }, onCancelClicked: {
                                                viewModel.resetAlertModel()
                                            }
                                        )
                                    )
                                })
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if !models.isEmpty {
                            Divider()
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

struct DevicetItem: View {
    let model: DeviceModel
    let onDelete: () -> Void
    var body: some View {
        HStack {
            Text(model.deviceSsid)
                .font(AppFont.regular_16)
                .scaledToFit()
            Spacer()
            
            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .foregroundColor(.gray)
        .contentShape(Rectangle())
        .padding(.vertical, 20)
    }
}
