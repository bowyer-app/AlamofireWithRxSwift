//
//  ViewController.swift
//  github
//
//  Created by Bowyer on 2016/06/18.
//  Copyright © 2016年 Bowyer. All rights reserved.
//

import Hakuba
import RxSwift

class GithubUserViewController: UITableViewController {

    private lazy var hakuba: Hakuba = Hakuba(tableView: self.tableView)
    private let disposeBag = DisposeBag()
    
    class func instantiate() -> GithubUserViewController {
        return GithubUserViewController(style: .Plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureHakuba()
        getUsers()
    }
    private func configureTableView() {
        tableView.separatorStyle = .None
    }
    
    private func configureHakuba() {
        hakuba.registerCellByNib(UserViewCell)
    }
    
    private func getUsers(){
        AlamofireManager.sharedInstance.getUsers()
            .subscribeNext { [weak self] users in
                let userModels = users.map{user -> UserViewCellModel in
                    return UserViewCellModel(userName: user.name as String, imageUrl: user.avatarUrl!){[weak self] _ in
                        // TODO call Safariview
                    }
                }
                let section = Section().reset(userModels)
                self!.hakuba.reset(section).bump()
            }.addDisposableTo(disposeBag)
    }

}

