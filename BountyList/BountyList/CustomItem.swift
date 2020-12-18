//
//  CustomItem.swift
//  MusicChart
//
//  Created by sangho Cho on 2020/12/18.
//

import Foundation
import UIKit
import SnapKit

class CustomItem: UICollectionViewCell {
    var imgView = UIImageView(frame: CGRect.zero)
    var name = UILabel(frame: CGRect.zero)
    var bounty = UILabel(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        itemLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func itemLayout() {

        contentView.addSubview(imgView)
        contentView.addSubview(name)
        contentView.addSubview(bounty)

        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(imgView.snp.width).multipliedBy(10.0/7.0)
        }

        name.font = .boldSystemFont(ofSize: 25)
        name.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }

        bounty.font = .systemFont(ofSize: 17)
        bounty.textColor = .lightGray
        bounty.snp.makeConstraints() {
            $0.top.equalTo(name.snp.bottom).offset(20)
            $0.leading.equalTo(name.snp.leading)
        }
    }
}
