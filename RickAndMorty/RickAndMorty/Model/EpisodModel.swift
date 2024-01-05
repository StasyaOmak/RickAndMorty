//
//  EpisodModel.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 02/01/2024.
//

import Foundation

struct EpisodModel {
    let id: Int
    let episode: String
    let name: String
    let character: String
    
    
    init(object: Episode){
        self.id = object.id
        self.episode = object.episode
        self.name = object.name
        self.character = object.characters.randomElement() ?? ""
    }
}
