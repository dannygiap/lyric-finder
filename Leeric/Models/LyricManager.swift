//
//  LyricManager.swift
//  Leeric
//
//  Created by Danny Giap on 1/16/20.
//  Copyright © 2020 Danny Giap. All rights reserved.
//

import Foundation

protocol LyricManagerDelegate {
    func didUpdateLyrics(lyrics: LyricData)
    func didFailWithError()
}

struct LyricManager {
    var delegate: LyricManagerDelegate?
    
    let apiURL = "https://api.lyrics.ovh/v1"
    
    func fetchLyrics(_ artist: String, _ song: String) {
        let url = "\(apiURL)/\(artist)/\(song)".addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
        self.performRequest(urlString: url!)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            print(url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, res, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let lyrics = self.parseJSON(lyricData: safeData) {
                        self.delegate?.didUpdateLyrics(lyrics: lyrics)
                        
                        //print(lyrics.lyrics)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(lyricData: Data) -> LyricData?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(LyricData.self, from: lyricData)
            let lyrics = decodedData.lyrics
            let lyricData = LyricData(lyrics: lyrics)
            return lyricData
        } catch {
            print(error)
            return nil
        }
    }
}
