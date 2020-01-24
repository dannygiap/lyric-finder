//
//  LyricView.swift
//  Leeric
//
//  Created by Danny Giap on 1/16/20.
//  Copyright © 2020 Danny Giap. All rights reserved.
//

import UIKit

class LyricViewController: UIViewController {
    
    @IBOutlet weak var lyricLabel: UILabel!
    
    var lyrics: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lyricLabel.text = lyrics
    }
}
