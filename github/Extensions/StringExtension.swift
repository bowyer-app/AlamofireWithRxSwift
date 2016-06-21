//
//  StringExtension.swift
//  github
//
//  Created by Bowyer on 2016/06/21.
//  Copyright © 2016年 Bowyer. All rights reserved.
//

extension String {

    var url: NSURL? {
        return NSURL(string: self)
    }
    
}