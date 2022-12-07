//
//  MainScreen.swift
//  SompoWifiiTest
//
//  Created by Harol Higuera on 2022/12/02.
//

import SwiftUI

struct MainScreen: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State var entrySsid: String = ""
    @State var entryPassword: String = ""
    
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
                                    TextField("SSID", text:  $entrySsid)
                                        .padding(.all)
                                        .background(Color(red: 245, green: 245, blue: 245))
                                }
                                Section(header: Text("パスワード")) {
                                    TextField("パスワード", text:  $entryPassword)
                                        .padding(.all)
                                        .background(Color(red: 245, green: 245, blue: 245))
                                }
                                
                            }
                            .navigationBarItems(
                                trailing: Button(action: {
                                    viewModel.registerDevice(
                                        ssid: entrySsid,
                                        password: entryPassword) { errorMessage in
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
