//
//  PopUpViewController.swift
//  RPG Maps
//
//  Created by USER on 20.07.21.
//

import UIKit
import AVFoundation

class PopUpViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        showAnimate()
        // Do any additional setup after loading the view.
        
        //this plays the sound of the trumpet signifying that you unlocked an achievement
        let pathToSound = Bundle.main.path(forResource: "AchievementUnlocked", ofType: ".wav")
        let url = URL(fileURLWithPath: pathToSound!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch  {
            print("there was an error playing audio")
        }
    }
    

    @IBAction func onDismiss(_ sender: UIButton) {
        removeAnimate()
        self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        // this is the fade in animation for the view
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        // this is the fade out animation for the view
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
}
