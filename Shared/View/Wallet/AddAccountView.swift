//
//  AddAccountView.swift
//  BarimWallet
//
//  Created by Junhyung Cho on 2021/03/29.
//

import SwiftUI

struct AddAccountView: View {
    @Binding var presentAddAcountView: Bool
    @State private var accountName: String = ""
    
    private var addAccount: () -> Void {
        {
            guard !accountName.isEmpty  else { fatalError("Account name is empty") }
            presentAddAcountView = false
        }
    }
    
    var body: some View {
        List {
            Section(header:
                        HStack {
                            Spacer()
                            Button(action: { presentAddAcountView = false }) {
                                Image(systemName: "chevron.compact.down")
                                    .font(.system(.title))
                                    .padding()
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Spacer()
                        },
                    footer:
                        BigButton(text: "Add",
                                  height: 56,
                                  action: addAccount)
                        .disabled(accountName.isEmpty)
                        .padding(.top)
            ) {
                TextField("Account Name", text: $accountName)
                    .foregroundColor(.accentColor)
                    .font(.largeTitle)
            }
        }
        .listStyle(GroupedListStyle())
    }
}
