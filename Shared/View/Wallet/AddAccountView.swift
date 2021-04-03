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
    
    private var cancelAction: () -> Void {
        {
            presentAddAcountView = false
        }
    }
    
    private var addAction: () -> Void {
        {
            guard !accountName.isEmpty  else { fatalError("Account name is empty") }
            presentAddAcountView = false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: cancelAction) { Text("Cancel") }
                Spacer()
                Button(action: addAction) { Text("Add") }
                    .disabled(accountName.isEmpty)
            }.padding(.bottom)
            
            HStack {
                TextField("Account Name", text: $accountName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }
            Spacer()
        }
        .padding()
    }
}
