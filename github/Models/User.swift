//
//  User.swift
//  github
//
//  Created by Bowyer on 2016/06/18.
//  Copyright © 2016年 Bowyer. All rights reserved.
//

class User: NSObject {
    var name:NSString
    var url:NSURL?
    var avatarUrl:NSURL?
    
    init(name: String, url: NSURL?,avatarUrl: NSURL?){
        self.name = name
        self.url = url
        self.avatarUrl = avatarUrl
    }
}

