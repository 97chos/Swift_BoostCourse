//
//  ResultCell.swift
//  MusicSearchApp
//
//  Created by sangho Cho on 2020/12/20.
//

import Foundation
import UIKit
import SnapKit

class ResultCell: UITableViewCell {
    var title: UILabel!
    var artistName: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(data: Track) {
        self.title.text = data.title
        self.artistName.text = data.artistName
    }

    func setUI() {
        self.title = UILabel(frame: CGRect.zero)
        self.artistName = UILabel(frame: CGRect.zero)

        self.title.font = .systemFont(ofSize: 18, weight: .heavy)
        self.artistName.font = .systemFont(ofSize: 13)
        self.artistName.textColor = .lightGray

        contentView.addSubview(title)
        contentView.addSubview(artistName)

        title.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(25)
        }

        artistName.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(title.snp.leading)
            $0.trailing.equalTo(title.snp.trailing)
        }

        self.artistName.lineBreakMode = .byTruncatingTail
        self.title.lineBreakMode = .byTruncatingTail
    }
}
