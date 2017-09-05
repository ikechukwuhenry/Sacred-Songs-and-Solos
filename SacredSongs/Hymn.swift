//
//  Hymn.swift
//  SacredSongs
//
//  Created by MAC on 04/05/2016.
//  Copyright © 2016 Ikhub. All rights reserved.
//

import Foundation

class Hymn {
    let index: Int
    let title: String
    let hasChorus: Bool
    let chorus: String?
    let verses: [String]
    
    init(index: Int, title: String, hasChorus: Bool, chorus: String?, verses: [String]){
        self.index = index
        self.title = title
        self.hasChorus = hasChorus
        if !hasChorus {
            self.chorus = nil
        }else {
            self.chorus = chorus
        }
        //self.chorus = chorus
        self.verses = verses
        
    }
}