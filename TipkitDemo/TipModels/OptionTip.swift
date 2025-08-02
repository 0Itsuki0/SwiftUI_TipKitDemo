//
//  OptionTip.swift
//  TipkitDemo
//
//  Created by Itsuki on 2025/08/01.
//


import TipKit

struct OptionTip: Tip {
    var title: Text {
        Text("Once Forever, Regardless of Display Frequency, Disappear after 60 Second")
    }

    var options: [Option] {
        // Specifies the maximum number of times a tip displays before the system automatically invalidates it.
        // For example, with the following option, if the displayFrequency is set to weekly, this Tip will only be displayed once.
        MaxDisplayCount(1);
        
        // Controls whether a tip obeys the preconfigured display frequency interval.
        IgnoresDisplayFrequency(false);
        
        // Specifies the maximum amount of time a tip is displayed before it is invalidated.
        // - minimum display duration of 60 seconds before they can be automatically invalidated by MaxDisplayDuration in order to avoid appearing and disappearing too quickly
        // - This is a cumulative value; if a tip specifies a 2 minute maximum display duration and is displayed for 1 minute on Monday and 1 minute on Tuesday it will be automatically invalidated and no longer appear.
        MaxDisplayDuration(60.0)
    }
}
