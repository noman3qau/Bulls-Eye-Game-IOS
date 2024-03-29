//
//  ViewController.swift
//  BullsEye
//
//  Created by Noman on 4/11/19.
//  Copyright © 2019 EvampSaanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue=Int(slider.value.rounded())
    
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlited = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)


    }

    @IBAction func showAlert(){
        
        let difference = abs(currentValue - targetValue)

        var points: Int = 100 - difference

        score += points
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5{
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        }else {
            title = "Not even close..."
        }
        
        let alert = UIAlertController(title: title, message: "You scored \(points) points", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })

        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    
    @IBAction func sliderMoved(slider: UISlider){
        
        print("Slider current value is: \(slider.value)")
        
        currentValue = Int(slider.value.rounded())
        
    }
    
    func startNewRound() {

        round += 1
        
        targetValue = Int.random(in: 1...100)
        
        currentValue = 50
        
        slider.value = Float(currentValue)
        
        updateLabels()
    }
    
    func updateLabels()  {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startNewGame(){
         score = 0
         round = 0
        startNewRound()
    }

}

