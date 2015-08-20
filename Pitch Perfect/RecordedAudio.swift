//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Martin Kelly on 08/08/2015.
//  Copyright (c) 2015 Scriptable. All rights reserved.
//

import Foundation

class RecordedAudio {
    
    init (url:NSURL, title:String) {
        self.url = url
        self.title = title
    }
    
    var url: NSURL!
    var title: String!
}
