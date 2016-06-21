//
//  AlamofireManager.swift
//  github
//
//  Created by Bowyer on 2016/06/18.
//  Copyright © 2016年 Bowyer. All rights reserved.
//

import Alamofire
import Alamofire_SwiftyJSON
import Hakuba
import RxSwift
import SwiftyJSON

class AlamofireManager {
    
    private let userApi = "https://api.github.com/users?since=0"
    
    static let sharedInstance: AlamofireManager = AlamofireManager()
    
    private init() {}
    
    func getUsers() -> Observable<[User]> {
        return getJson(userApi).map{ self.convertUsers($0) }
    }
    
    private func convertUsers(json:JSON) -> [User] {
        var users :[User] = []
        guard let data = json.array else {
            return users
        }
        
        data.toObservable()
            .map { result -> User in
                let name = result["login"].string ?? ""
                let url = result["html_url"].string?.url
                let avatarUrl = result["avatar_url"].string?.url
                return User(name: name, url: url, avatarUrl: avatarUrl)
        }.doOnNext { user in
            users.append(user)
        }.subscribe().dispose()
        
        return users;
    }
    
    private func getJson(url :String) -> Observable<JSON> {
        return Observable.create{ observer in
            let request = Alamofire.request(.GET, url)
                .responseSwiftyJSON( { (request, response, json, error) in
                    if let error = error {
                        observer.onError(error)
                    }else{
                        observer.onNext(json)
                        observer.onCompleted()
                    }
                });
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
}
