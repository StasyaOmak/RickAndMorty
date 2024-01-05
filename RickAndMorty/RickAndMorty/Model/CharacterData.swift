//
//  CharacterData.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 02/01/2024.
//

import Foundation

struct CharacterData: Decodable {
    
    let info: Info
    let results: [Character]

    struct Info: Decodable {
        let pages: Int
        let next: String?
        let prev: String?
    }
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}
