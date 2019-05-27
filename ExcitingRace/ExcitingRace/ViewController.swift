//
//  ViewController.swift
//  memorize images
//
//  Created by Hieu Nghia on 2/24/19.
//  Copyright © 2019 Hieu Nghia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var racer1Slider: UISlider!
    @IBOutlet weak var racer2Slider: UISlider!
    @IBOutlet weak var racer3Slider: UISlider!
    @IBOutlet weak var flagRacer1: UIImageView!
    @IBOutlet weak var flagRacer2: UIImageView!
    @IBOutlet weak var flagRacer3: UIImageView!
    @IBOutlet weak var start: UIImageView!
    @IBOutlet weak var flagRacer1Button: UIButton!
    @IBOutlet weak var flagRacer2Button: UIButton!
    @IBOutlet weak var flagRacer3Button: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    
    var goalCount = 0
    var flagRacer = UIImageView()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func selectFlag1(_ sender: UIButton) {
        chooseFlag(flagRacer: flagRacer1)
    }
    @IBAction func selectFlag2(_ sender: UIButton) {
        chooseFlag(flagRacer: flagRacer2)
    }
    @IBAction func selectFlag3(_ sender: UIButton) {
        chooseFlag(flagRacer: flagRacer3)
    }
    @IBAction func selectStartButton(_ sender: UIButton) {
        disableFlagChoose()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.startRun()
        })
    }
    
    func setupView() {
        racer1Slider.setThumbImage(UIImage(named: "snail1"), for: .normal)
        racer2Slider.setThumbImage(UIImage(named: "snail2"), for: .normal)
        racer3Slider.setThumbImage(UIImage(named: "snail3"), for: .normal)
        chooseFlag(flagRacer: flagRacer1)
        goalLabel.text = String(goalCount)
    }
    
    func chooseFlag(flagRacer: UIImageView) {
        let flagUnChooseAlpha: CGFloat = 0.1
        flagRacer1.alpha = flagUnChooseAlpha
        flagRacer2.alpha = flagUnChooseAlpha
        flagRacer3.alpha = flagUnChooseAlpha
        flagRacer.alpha = 1
        self.flagRacer = flagRacer
    }
    
    func disableFlagChoose() {
        flagRacer1Button.isEnabled = false
        flagRacer2Button.isEnabled = false
        flagRacer3Button.isEnabled = false
        startButton.isEnabled = false
    }
    
    func enableFlagChoose() {
        flagRacer1Button.isEnabled = true
        flagRacer2Button.isEnabled = true
        flagRacer3Button.isEnabled = true
        startButton.isEnabled = true
        refreshRace()
        updateGoalCount()
    }
    
    func refreshRace() {
        racer1Slider.value = 0
        racer2Slider.value = 0
        racer3Slider.value = 0
    }
    
    func updateGoalCount() {
        goalLabel.text = String(goalCount)
    }
    
    func finish(goal: Bool) {
        self.timer.invalidate()
        if (goal) {
            goalCount += 2
            showAlert(isWinner: true)
        } else {
            if (goalCount > 0) {
                goalCount -= 1
            }
            showAlert(isWinner: false)
        }
    }
    
    func startRun() {
        self.racer1Slider.value += Float.random(in: 1...30)/1
        if (self.racer1Slider.value >= self.racer1Slider.maximumValue) {
            self.finish(goal: self.flagRacer1.isEqual(flagRacer))
        }
        self.racer2Slider.value += Float.random(in: 1...30)/1
        if (self.racer2Slider.value >= self.racer2Slider.maximumValue) {
            self.finish(goal: self.flagRacer2.isEqual(flagRacer))
        }
        self.racer3Slider.value += Float.random(in: 1...30)/1
        if (self.racer3Slider.value >= self.racer3Slider.maximumValue) {
            self.finish(goal: self.flagRacer3.isEqual(flagRacer))
        }
    }
    
    func showAlert(isWinner: Bool) {
        var title = "Victory"
        var message = "The winner is +2 points"
        if (!isWinner) {
            title = "Defeat"
            message = "The loser is -1 points"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            self.enableFlagChoose()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

