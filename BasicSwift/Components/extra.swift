//
//  extra.swift
//  BasicSwift
//
//  Created by remotestate on 22/03/23.
//

import Foundation
import SwiftUI


struct ExtraView : View {
    var body: some View{
        VStack {
            
            HStack{
                
                Text("hello dsffj sdlfds lsdfjsdl sflds sdl sdfjls lllllllllllllllllllllllllllllllllll  dffdfd")
                Text("hello dsffj sdlfds lsdfjsdl sflds sdl sdfjls lllllllllllllllllllllllllllllllllll  dffdfd")
                
            }.frame(width: .infinity, height: 50)
                .background(.blue)
            
            Spacer()
            
        }
    }
}

struct ExtraViwPreview : PreviewProvider {
    static var previews: some View {
        ExtraView()
    }
}
