//
//  PlayerVC.swift
//  MusicApp
//
//  Created by sangho Cho on 2020/12/18.
//

import Foundation
import UIKit
import SnapKit
import AVFoundation

class PlayerVC: UIViewController {

    var albumCover: UIImageView!
    var musicTitle: UILabel!
    var artist: UILabel!

    var currentTimeLabel: UILabel!
    var totalDurationTimeLabel: UILabel!

    var playPauseButton: UIButton!
    var timeSlider: UISlider!
    var closeButton: UIButton!

    var track: TrackModel?
    var avplayer: AVPlayer?
    var timeObserver: Any?

    var currentTime: Double {
        return avplayer?.currentItem?.currentTime().seconds ?? 0
    }

    var totalDurationTime: Double {
        return avplayer?.currentItem?.duration.seconds ?? 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        updateUI()
        prepareToPlay()

        // avplayer 객체 내에서 특정 시간마다 수행할 동작 정의
        self.timeObserver = avplayer?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 10),
                                                              queue: DispatchQueue.main, using: { time in
                                                                self.updateTime(time: time)
                                                              })

        self.playPauseButton.addTarget(self, action: #selector(playpauseAction(_:)), for: .touchUpInside)
        self.timeSlider.addTarget(self, action: #selector(dragging(_:)), for: .valueChanged)
        self.timeSlider.addTarget(self, action: #selector(endDrag(_:)), for: .touchUpInside) 
        self.closeButton.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
    }

    func updateUI() {
        guard let currentTrack = track else {
            return
        }

        self.albumCover = UIImageView()
        self.artist = {
            let artist = UILabel()
            artist.font = .boldSystemFont(ofSize: 20)
            artist.textAlignment = .center
            artist.sizeToFit()
            return artist
        }()
        self.musicTitle = {
            let title = UILabel()
            title.font = .systemFont(ofSize: 15)
            title.sizeToFit()
            return title
        }()
        self.playPauseButton = {
            let btn = UIButton()
            btn.setImage(UIImage(named: "icPlay"), for: .normal)
            return btn
        }()
        self.timeSlider = UISlider()
        self.currentTimeLabel = {
            let time = UILabel()
            time.text = "00:00"
            time.font = .systemFont(ofSize: 13)
            time.textColor = .darkGray
            return time
        }()
        self.totalDurationTimeLabel = {
            let total = UILabel()
            total.font = .systemFont(ofSize: 13)
            total.textColor = .darkGray
            return total
        }()
        self.closeButton = UIButton()
        closeButton.setImage(UIImage(named: "icClose"), for: .normal)

        self.albumCover.image = currentTrack.thumb
        self.musicTitle.text = currentTrack.title
        self.artist.text = currentTrack.artist

        self.view.addSubview(albumCover)
        self.view.addSubview(artist)
        self.view.addSubview(musicTitle)
        self.view.addSubview(playPauseButton)
        self.view.addSubview(timeSlider)
        self.view.addSubview(currentTimeLabel)
        self.view.addSubview(totalDurationTimeLabel)
        self.view.addSubview(closeButton)

        albumCover.snp.makeConstraints{
            $0.top.equalToSuperview().inset(self.view.frame.height * 1/3)
            $0.width.equalToSuperview().multipliedBy(1.0/3.0)
            $0.height.equalTo(albumCover.snp.width)
            $0.centerX.equalToSuperview()
        }

        artist.snp.makeConstraints{
            $0.top.equalTo(albumCover.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        musicTitle.snp.makeConstraints{
            $0.top.equalTo(artist.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        timeSlider.snp.makeConstraints{
            $0.top.equalTo(artist.snp.bottom).offset(30)
            $0.width.equalToSuperview().multipliedBy(2.0/3.0)
            $0.centerX.equalToSuperview()
        }

        playPauseButton.snp.makeConstraints{
            $0.top.equalTo(timeSlider.snp.bottom).offset(20)
            $0.width.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }

        currentTimeLabel.snp.makeConstraints{
            $0.top.equalTo(timeSlider.snp.bottom).offset(10)
            $0.leading.equalTo(timeSlider.snp.leading)
        }

        totalDurationTimeLabel.snp.makeConstraints{
            $0.top.equalTo(timeSlider.snp.bottom).offset(10)
            $0.trailing.equalTo(timeSlider.snp.trailing)
        }

        closeButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(30)
        }
    }
    // asset(음악 파일)을 기반으로 AVPlayer 객체 생성
    func prepareToPlay() {
        guard let currentTrack = track else {
            return
        }
        let asset = currentTrack.asset
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        self.avplayer = player
    }

    var isSeeking = false

    // 현재 플레이 타임, 슬라이더 노드 위치 업데이트
    func updateTime(time: CMTime) {
        currentTimeLabel.text = secondsToString(sec: currentTime)
        totalDurationTimeLabel.text = secondsToString(sec: totalDurationTime)

        if isSeeking == false {
            timeSlider.value = Float(currentTime/totalDurationTime)
        }
    }

    func secondsToString(sec: Double) -> String {
        guard !(sec.isNaN) else {
            return "00:00"
        }
        let totalSeconds = Int(sec)
        // 분 설정
        let min = totalSeconds / 60
        // 초 설정
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }


    func play() {
        avplayer?.play()
    }

    func pause() {
        avplayer?.pause()
    }

    func seek(to: Double) {

        let timeScale: CMTimeScale = 10
        let targetTime: CMTimeValue = CMTimeValue(to * totalDurationTime) * CMTimeValue(timeScale)

        let time = CMTime(value: targetTime, timescale: timeScale)
        avplayer?.seek(to: time)
    }

    @objc func playpauseAction(_ sender: UIButton) {
        // avplayer.rate = 재생 중일 때 1 반환, 멈춘 상태라면 0
        let isPlaying = avplayer?.rate == 1

        if isPlaying {
            avplayer?.pause()
            self.playPauseButton.setImage(UIImage(named: "icPlay"), for: .normal)
        } else {
            avplayer?.play()
            self.playPauseButton.setImage(UIImage(named: "icPause"), for: .normal)
        }
    }

    @objc func dragging(_ sender: UISlider) {
        self.isSeeking = true
        print("drag")
    }

    @objc func endDrag(_ sender: UISlider) {
        self.isSeeking = false
        seek(to: Double(sender.value))
        print("done")
    }

    @objc func close(_ sender: UIButton) {
        pause()
        avplayer?.replaceCurrentItem(with: nil)
        avplayer = nil

        dismiss(animated: true)
    }

}
