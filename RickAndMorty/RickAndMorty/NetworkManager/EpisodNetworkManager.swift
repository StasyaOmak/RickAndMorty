//
//  EpisodNetworkManager.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 02/01/2024.
//

import UIKit

class EpisodNetworkManager {
    
    private let episodeUrl = "https://rickandmortyapi.com/api/episode"
    private let characterUrl = "https://rickandmortyapi.com/api/character"
    
    func fetchEpisode(completion: @escaping (Result<[EpisodModel], Error>) -> () ) {
        guard let url = URL(string: episodeUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error)
            in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let jsonData = try JSONDecoder().decode(EpisodData.self, from: data)
                let model: [EpisodModel] = jsonData.results.map { EpisodModel(object: $0) }
                
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchImage(url: String, completion: @escaping (Result<UIImage, Error>) -> ()){
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) {
            (data,response,err) in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            completion(.success(image))
        }.resume()
    }
    
    func fetchCharacter(url: String, completion: @escaping (Result<CharacterModel, Error>) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) {
            (data,response,err) in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(CharacterModel.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
