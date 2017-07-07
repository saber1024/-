//
//  WaveProgressView.swift
//  WaveView
//
//  Created by rayootech on 16/9/1.
//  Copyright © 2016年 demon. All rights reserved.
//

import UIKit

class WaveProgressView: UIView {

    /// 前面波纹颜色
    var frontWaveColor: UIColor?
    /// 后面波纹颜色
    var behindWaveColor: UIColor?
    /// 百分比
    var percent: CGFloat = 0
    /// 波纹振幅
    var waveAmplitude: CGFloat = 5
    var waveCycle: CGFloat = 0
    /// 波纹左右偏移速度
    var waveSpeed: CGFloat = CGFloat(0.3 / .pi)
    /// 波纹上下偏移速度
    var waveGrowth: CGFloat = 0.6
    /// 当前波纹高度
    var currentWavePointY: CGFloat = 0
    /// 横坐标偏移量
    var offsetX: CGFloat = 0
    var waveWidth: CGFloat = 0
    var waveHeight: CGFloat = 0
    
    fileprivate var frontWaveLayer: CAShapeLayer?
    fileprivate var behindWaveLayer: CAShapeLayer?
    fileprivate var displayLink: CADisplayLink?
    /// 实时更新振幅，更贴近真实波纹
    fileprivate var waveAmplitudeItem: CGFloat = 1.6
    /// 振幅增加还是减少
    fileprivate var increase: Bool = false
    
    //life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    //MARK: - event
    @objc func startWaveAnimation() {
        if percent == 0 {
            return
        }
        
        updateAmplitude()
        updateFrontWaveLayer()
        updateBehindWaveLayer()
        
        let finalY = waveHeight * (1 - percent)
        if currentWavePointY > finalY {
            currentWavePointY -= waveGrowth
        }
        
        offsetX += waveSpeed
    }
    
    //MARK: - privath methods
    //基本配置
    fileprivate func setUp() {
        clipsToBounds = true
        
        frontWaveColor = UIColor.red
        behindWaveColor = UIColor.cyan
        waveWidth = frame.size.width
        waveHeight = frame.size.height
        currentWavePointY = waveHeight
        waveCycle = 1.29 * .pi / waveWidth
    }
    //刷新前面的waveLayer
    fileprivate func updateFrontWaveLayer() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: currentWavePointY))
        for i in 0...Int(waveWidth) {
            let x = CGFloat(i)
            let y = waveAmplitude * sin(waveCycle*x + offsetX) + currentWavePointY
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: waveWidth, y: waveHeight))
        path.addLine(to: CGPoint(x: 0, y: waveHeight))
        path.close()
        frontWaveLayer?.path = path.cgPath
    }
    //刷新后面的waveLayer
    fileprivate func updateBehindWaveLayer() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: currentWavePointY))
        for i in 0...Int(waveWidth) {
            let x = CGFloat(i)
            let y = waveAmplitude * cos(waveCycle*x + offsetX) + currentWavePointY
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: waveWidth, y: waveHeight))
        path.addLine(to: CGPoint(x: 0, y: waveHeight))
        path.close()
        behindWaveLayer?.path = path.cgPath
    }
    //刷新振幅
    fileprivate func updateAmplitude() {
        if increase {
            waveAmplitudeItem += 0.01
        }else {
            waveAmplitudeItem -= 0.01
        }
        if waveAmplitudeItem <= 1 {
            increase = true
        }
        if waveAmplitudeItem >= 1.6 {
            increase = false
        }
        waveAmplitude = waveAmplitudeItem * 5
    }
    
    //MARK: - public methods
    /**
     开始波动
     */
    func startWave() {
        if behindWaveLayer == nil {
            behindWaveLayer = CAShapeLayer()
            behindWaveLayer?.fillColor = behindWaveColor?.cgColor
            layer.addSublayer(behindWaveLayer!)
        }
        if frontWaveLayer == nil {
            frontWaveLayer = CAShapeLayer()
            frontWaveLayer?.fillColor = frontWaveColor?.cgColor
            layer.addSublayer(frontWaveLayer!)
        }
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(startWaveAnimation))
            displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        }
    }
    /**
     停止波动
     */
    func stopWave() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
}
