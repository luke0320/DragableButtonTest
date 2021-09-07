//
//  MyButton.swift
//  ButtonLayout
//
//  Created by Luke Lee on 2021/9/7.
//

import Foundation

enum ButtonAction {
    case openWebPage(url: URL)
    case openPlainPage
}

struct MyButton {
    var title: String
    var colorHex: Int
    var action: ButtonAction
}
