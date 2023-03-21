//
//  Application.swift
//  BasicSwift
//
//  Created by remotestate on 14/03/23.
//

import Foundation
import UIKit
final class ApplicationUtiles{
    static var rootViewController :UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
