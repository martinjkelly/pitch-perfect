//
//  RecordViewController.swift
//  Pitch Perfect
//
//  Created by Martin Kelly on 08/08/2015.
//  Copyright (c) 2015 Scriptable. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        pauseButton.enabled = true
        resumeButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if (flag) {
            recordedAudio = RecordedAudio(url:recorder.url, fileTitle:recorder.url.lastPathComponent!)
            performSegueWithIdentifier("stopRecordingSegue", sender: recordedAudio)
        } else {
            println("Failed to save audio")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecordingSegue") {
            let playbackVC:PlaybackViewController = segue.destinationViewController as! PlaybackViewController
            let data = sender as! RecordedAudio
            playbackVC.receivedAudio = data
        }
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.text = "Recording..."
        pauseButton.hidden = false
        resumeButton.hidden = false
        stopButton.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        // Fix volume bug on iPhone 6
        // ref: https://discussions.udacity.com/t/extremely-low-volume-when-playing-the-recording-on-my-iphone-6-plus/22061
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
        
        audioRecorder = AVAudioRecorder(URL:filePath, settings:nil,error:nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func pauseRecording(sender: UIButton) {
        resumeButton.enabled = true
        pauseButton.enabled = false
        recordingInProgress.text = "Recording Paused"
        audioRecorder.pause()
    }
    
    @IBAction func resumeRecording(sender: UIButton) {
        pauseButton.enabled = true
        resumeButton.enabled = false
        recordingInProgress.text = "Recording..."
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.text = "Tap to Record"
        stopButton.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

