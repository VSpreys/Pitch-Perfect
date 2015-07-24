//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Vlad Spreys on 17/07/15.
//  Copyright (c) 2015 Vlad Spreys. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{ 
    
    
    

    @IBOutlet weak var recordingInProgress:UILabel!
    
    @IBOutlet weak var stopRecording: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    
    
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        

        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true

    }
    override func viewWillAppear(animated: Bool) {
        stopRecording.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        stopRecording.hidden = false
        //TODO: Record the user's voice
        println("in recordAudio")
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        recordingInProgress.text = "Recording in Progress"
        
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
            //TODO Step 1 - Save the recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
        
            //TODO Step 2 - Move to the next scene aka perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording not successeful")
            recordButton.enabled = true
            stopRecording.hidden = true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data  = sender as! RecordedAudio!
            playSoundsVC.receiveAudio = data
        }
    }
    @IBAction func stopAudio(sender: UIButton) {
        //TODO: Stop recording the user's voice
        println("recordingFinished")
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        recordingInProgress.text = "Tap to Record"
    }

}

