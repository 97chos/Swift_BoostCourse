//
//  MusicCell.swift
//  MusicApp
//
//  Created by sangho Cho on 2020/12/18.
//

import Foundation
import UIKit
import SnapKit

class MusicCell: UITableViewCell {
    var imgView: UIImageView!
    var title: UILabel!
    var artist: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func cellUI() {

        self.accessoryType = .disclosureIndicator

        self.imgView = UIImageView()
        self.title = {
            let title = UILabel()
            title.font = .boldSystemFont(ofSize: 20)
            title.textAlignment = .left
            return title
        }()
        self.artist = {
            let singer = UILabel()
            singer.font = .systemFont(ofSize: 16)
            singer.textColor = .lightGray
            singer.textAlignment = .left
            return singer
        }()

        contentView.addSubview(imgView)
        contentView.addSubview(title)
        contentView.addSubview(artist)

        imgView.contentMode = .center

        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 5/UIFont.labelFontSize

        self.imgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(imgView.snp.width)
            $0.centerY.equalToSuperview()
        }

        self.title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(150)
            $0.trailing.equalToSuperview().inset(20)
        }

        self.artist.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(15)
            $0.leading.equalTo(title.snp.leading)
        }
    }
}
