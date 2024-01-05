//
//  EpisodeData.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 02/01/2024.
//

import Foundation

struct EpisodData: Decodable {
    let info: Info
    let results: [Episode]
    
    struct Info: Decodable {
        let pages: Int
        let next: String?
        let prev: String?
    }
}

struct Episode: Decodable {
    let id: Int
    let name: String
    let episode: String
    let characters: [String]
}

