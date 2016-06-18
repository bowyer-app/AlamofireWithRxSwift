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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

