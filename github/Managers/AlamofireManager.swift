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
    
    let USER_API = "https://api.github.com/users?since=0"
    
    static let sharedInstance: AlamofireManager = AlamofireManager()
    
    private init() {}
    
    func getUsers() -> Observable<[User]> {
        return getJson(USER_API).map{json -> [User] in return self.convertUsers(json!)};
    }
    
    private func convertUsers(json:SwiftyJSON.JSON) -> [User]{
        var users :[User] = []
        guard let data = json.array else {
            return users
        }
        
        data.toObservable()
            .map{result -> User in
                let name = result["login"].string
                let url = result["html_url"].string
                let avatarUrl = result["avatar_url"].string
                return User(name: name!, url: NSURL(string: url!)!, avatarUrl: NSURL(string: avatarUrl!)!)
        }.doOnNext { user in
            users.append(user)
        }.subscribe().dispose()
        
        return users;
    }
    
    private func getJson(url :String) -> Observable<SwiftyJSON.JSON?> {
        return Observable.create{ observer in
            let request = Alamofire.request(.GET, url)
                .responseSwiftyJSON({ (request, response, json, error) in
                    if((error) != nil){
                        observer.onError(error!)
                    }else{
                        observer.onNext(json);
                        observer.onCompleted()
                    }
                });
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
}
