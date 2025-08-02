//
//  InlineTip.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//

import TipKit

struct InlineTip: Tip {
    var title: Text {
        Text("Hello!")
    }

    var message: Text? {
        Text("Greeting From Itsuki!")
    }


    var image: Image? {
        Image(systemName: "heart.fill")
    }
}
