//
//  ViewController.swift
//  Leeric
//
//  Created by Danny Giap on 1/15/20.
//  Copyright © 2020 Danny Giap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    

    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var songField: UITextField!
    
    var lyricManager = LyricManager()
    var songLyrics = "could not find lyrics"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistField.delegate = self
        songField.delegate = self
        lyricManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        //use search fields to get lyrics
        if let artist = artistField.text, let song = songField.text {
            lyricManager.fetchLyrics(artist, song)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLyrics" {
            let destinationVC = segue.destination as! LyricViewController
            destinationVC.lyrics = songLyrics
        }
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        } else {
//            textField.placeholder = "Type something"
//            return false
//        }
//    }
}

extension ViewController: LyricManagerDelegate {
    func didUpdateLyrics(lyrics: LyricData) {
        songLyrics = lyrics.lyrics
        print(songLyrics)
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ShowLyrics", sender: self)
        }
        
    }
    
    func didFailWithError() {
        print("error")
    }
}

