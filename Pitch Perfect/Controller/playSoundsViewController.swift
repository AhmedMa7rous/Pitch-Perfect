//
//  playSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ma7rous on 7/31/21.
//  Copyright © 2021 Ma7rous. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {
    
   // Connect sounds Buttons with controller
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    // code for playback the recorded audio using various effects
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    
    // enumeration for enumrate the value of sound effects types
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    // connect all sounds effects buttons to one action func
    @IBAction func playSoundForButton(_ sender: UIButton) {
        //switch to know which button is the sender by using button tag property
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }

        configureUI(.playing)
        
    }
    
    //the stop button func
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
       stopAudio()
    }

}
