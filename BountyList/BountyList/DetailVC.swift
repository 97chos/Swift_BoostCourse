//
//  DetailVC.swift
//  MusicChart
//
//  Created by sangho Cho on 2020/12/17.
//

import Foundation
import UIKit
import SnapKit

class DetailVC: UIViewController {

    var closeBtn: UIButton!
    var imgView: UIImageView!
    var name: UILabel!
    var bounty: UILabel!
    var data: pageData?

    override func viewDidLoad() {
        closeBtn = UIButton()
        imgView = UIImageView()
        name = UILabel()
        bounty = UILabel()

        self.closeBtn.addTarget(self, action: #selector(closeBtn(_:)), for: .touchUpInside)

        name.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3)
        bounty.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3)

        name.alpha = 0
        bounty.alpha = 0

        setData()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.name.transform = CGAffineTransform.identity
                        self.name.alpha = 1
                       })

        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       options: .curveEaseIn,
                       animations: {
                        self.bounty.transform = CGAffineTransform.identity
                        self.bounty.alpha = 1
                       })


        DispatchQueue.main.async {
            UIView.transition(with: self.imgView,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil)
        }

    }

    func setData() {
        guard let setData = self.data else { return }

        self.imgView.image = setData.img
        self.name.text = setData.name
        self.bounty.text = setData.bounty
    }

    func layout() {

        closeBtn.setBackgroundImage(UIImage(named: "close_ic"), for: .normal)
        self.view.backgroundColor = .white

        self.view.addSubview(imgView)
        self.view.addSubview(name)
        self.view.addSubview(bounty)
        self.view.addSubview(closeBtn)

        closeBtn.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(30)
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().inset(30)
        }

        imgView.snp.makeConstraints() {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(200)
        }

        name.snp.makeConstraints() {
            $0.top.equalTo(imgView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }

        bounty.snp.makeConstraints() {
            $0.top.equalTo(name.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }

        self.name.font = .boldSystemFont(ofSize: 25)

        self.name.sizeToFit()
        self.bounty.sizeToFit()
    }

    @objc func closeBtn(_ Sender: UIButton) {
        self.dismiss(animated: true)
    }
}

