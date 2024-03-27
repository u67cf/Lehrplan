//
//  PassView.swift
//  tku-ios
//
//  Created by bochain on 3/27/24.
//

import SwiftUI

struct PassView: View {
    @State private var isOpen: Bool = true
    @State private var url: String = "https://sso.tku.edu.tw/NEAI/logineb.jsp?myurl=https://sso.tku.edu.tw/csminfo/visitor/tkuid.asp?"
    var body: some View {
        VStack{
            Button(action: { }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
        .sheet(isPresented: $isOpen, content: {
            WebView(url: URL(string: url)!)
            Button("Close") {
                // This will show the login page
                self.isOpen = false
            }
        })
    }
}

#Preview {
    PassView()
}
