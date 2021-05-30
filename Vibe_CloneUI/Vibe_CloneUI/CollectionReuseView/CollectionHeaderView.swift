//
//  CollectionHeaderView.swift
//  Vibe_CloneUI
//
//  Created by sangho Cho on 2021/05/29.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    func set(title: String) {
        self.headerTitle.text = title
        self.headerTitle.sizeToFit()
    }
}
