//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 02/01/2024.
//

import Foundation

typealias Descr = (title: String, subTitle: String)

struct CharacterModel: Decodable {
    let name: String
    let image: String
    let gender: String
    let species: String
    let status: String
    let origin: UrlModel
    let location: UrlModel
    let type: String
    
    func getArray() -> [Descr] {
        return [
            Descr("Gender", self.gender),
            Descr("Status", self.status),
            Descr("Species", self.species),
            Descr("Origin", self.origin.name),
            Descr("Type", self.type),
            Descr("Location", self.location.name)
        ].filter { !$0.subTitle.isEmpty }
    }
}

struct UrlModel: Decodable {
    let name: String
    let url: String
}

