//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Vlad Spreys on 17/07/15.
//  Copyright (c) 2015 Vlad Spreys. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receiveAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

//        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//        var filePathUrl = NSURL.fileURLWithPath(filePath)
//        audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
//        audioPlayer.enableRate = true
//        }else{
//            println("the file path is empty")
//        }
//    }
        
    audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    

    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }


    @IBAction func stopPlaying(sender: UIButton) {
        audioPlayer.stop()
    }
}

