//
//  ViewController.swift
//  github
//
//  Created by Bowyer on 2016/06/18.
//  Copyright © 2016年 Bowyer. All rights reserved.
//

import Hakuba
import RxSwift
import SafariServices

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
                let userModels = users.flatMap{ user -> UserViewCellModel? in
                    guard let avatarUrl = user.avatarUrl , url = user.url else {
                        return nil
                    }
                    return UserViewCellModel(userName: user.name, imageUrl: avatarUrl) { [weak self] _ in
                        let safariviewController = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                        self!.presentViewController(safariviewController, animated: true, completion: nil)
                    }
                
                }
                let section = Section().reset(userModels)
                self!.hakuba.reset(section).bump()
            }.addDisposableTo(disposeBag)
    }

}

