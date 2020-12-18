//
//  CustomCell.swift
//  MusicChart
//
//  Created by sangho Cho on 2020/12/17.
//

import Foundation
import UIKit
import SnapKit

class CustomCell: UITableViewCell {

    var imgView: UIImageView = {
        var img = UIImageView(frame: CGRect.zero)
        return img
    }()
    var name: UILabel = {
        var name = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        return name
    }()
    var bounty: UILabel = {
        var bounty = UILabel(frame: CGRect.zero)
        return bounty
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func cellLayout() {

        contentView.addSubview(imgView)
        contentView.addSubview(name)
        contentView.addSubview(bounty)

        imgView.snp.makeConstraints() {
            $0.top.equalTo(self.snp.top).inset(10)
            $0.bottom.equalTo(self.snp.bottom).inset(10)
            $0.leading.equalTo(self.snp.leading).inset(10)
            $0.width.equalTo(130)
        }
        name.font = .boldSystemFont(ofSize: 20)
        name.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalTo(imgView.snp.trailing).offset(70)
        }

        bounty.font = .systemFont(ofSize: 15)
        bounty.snp.makeConstraints() {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.equalTo(name.snp.leading)
        }
    }
}
