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
    
    @IBAction func stopPlaying(sender: UIButton) {
        audioPlayer.stop()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
