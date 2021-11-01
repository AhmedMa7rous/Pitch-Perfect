//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ma7rous on 7/31/21.
//  Copyright © 2021 Ma7rous. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{

    @IBOutlet weak var tabToRecording: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    var recordingSession : AVAudioSession!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configUi(tag: nil)
    
    }

    @IBAction func recording(_ sender: UIButton) {
        
        configUi(tag: sender.tag)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        configUi(tag: sender.tag)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("Recording was Not Successful !")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! playSoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
        }
    }
    
    //Function for configuring UI
    func configUi( tag : Int? ) {
        switch (tag){
        case 0 :
            self.tabToRecording.text = "Recording in Progress"
            self.stopRecordButton.isEnabled = true
            self.recordButton.isEnabled = false
        case 1 :
            tabToRecording.text = "Tab To Record"
            stopRecordButton.isEnabled = false
            recordButton.isEnabled = true
            
        default:
            tabToRecording.text = "Tab To Record"
            stopRecordButton.isEnabled = false
            recordButton.isEnabled = true
        }
    }
}

