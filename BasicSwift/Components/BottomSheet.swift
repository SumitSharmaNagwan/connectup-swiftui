//
//  BottomSheet.swift
//  BasicSwift
//
//  Created by remotestate on 07/04/23.
//

import Foundation
import SwiftUI

struct BottomSheet : View {
    @State
    var isOpen = false
    @State private var sheetHeight: CGSize = .zero
    var body: some View {
        VStack {
            
            Text("hddsfsfsd")
         ProgressView()
            
            Button {
                isOpen = true
            } label: {
                Text("Open Sheet")
            }
            .sheet(isPresented: $isOpen) {
                VStack {
                    Button {
                        isOpen = false
                    } label: {
                        Text("cancel")
                    }
                    .padding(40)
            
                    Text("Bottom sheet")
                        .padding(40)
                
                }
                .onPreferenceChange( SizePreferenceKey.self){ newSize in
                    sheetHeight = newSize
                    
                }
                .presentationDetents([.height(sheetHeight.height)])
            }
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { value = nextValue() }
}


struct BottomSheetPreview : PreviewProvider {
    static var previews: some View{
        BottomSheet()
    }
}
