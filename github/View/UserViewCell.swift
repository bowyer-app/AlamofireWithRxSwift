//
//  UserViewCell.swift
//  github
//
//  Created by Bowyer on 2016/06/18.
//  Copyright © 2016年 Bowyer. All rights reserved.
//

import Hakuba

class UserViewCellModel: CellModel {
    private let userName: String
    private let imageUrl: NSURL
    
    init(userName: String, imageUrl: NSURL,selectionHandler: SelectionHandler) {
        self.userName = userName
        self.imageUrl = imageUrl
        super.init(cell: UserViewCell.self, height: 80, selectionHandler: selectionHandler)
    }
}

class UserViewCell: Cell, CellType {
    
    typealias CellModel = UserViewCellModel
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func configure() {
        super.configure()
        guard let cellmodel = cellmodel else {
            return
        }
        nameLabel.text = cellmodel.userName
        iconImage.sd_setImageWithURL(cellmodel.imageUrl)
    }
    
}