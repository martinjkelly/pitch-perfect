//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Martin Kelly on 08/08/2015.
//  Copyright (c) 2015 Scriptable. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    init(url:NSURL, fileTitle:String) {
        filePathUrl = url
        title = fileTitle
    }
    
    var filePathUrl: NSURL!
    var title: String!
}
