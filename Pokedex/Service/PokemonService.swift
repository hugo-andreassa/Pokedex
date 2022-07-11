//
//  PokemonService.swift
//  Pokedex
//
//  Created by Hugo Andreassa Amaral (P) on 08/07/22.
//

import Foundation
import ObjectMapper

enum ApiError: String, Error  {
    case apiError = "Ocorreu um erro desconhecido ao chamar a API."
}

class PokemonService {
    
    private let pokemonsListApi = "https://pokeapi.co/api/v2/pokemon/?limit=100"
    
    func getPokemonList(completion: @escaping (Result<PokemonList, ApiError>) -> ()) {
        guard let url = URL(string: pokemonsListApi) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.apiError))
                return
            }
            
            if (response as! HTTPURLResponse).statusCode > 299 {
                completion(.failure(.apiError))
                return
            }
            
            if let safeData = data {
                let json = try! JSONSerialization.jsonObject(with: safeData, options: []) as! [String: Any]
                let pokemonList = Mapper<PokemonList>().map(JSON: json)
                completion(.success(pokemonList!))
            }
        }.resume()
    }
    
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, ApiError>) -> ()) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.apiError))
                return
            }
            
            if (response as! HTTPURLResponse).statusCode > 299 {
                completion(.failure(.apiError))
                return
            }
            
            if let safeData = data {
                let json = try! JSONSerialization.jsonObject(with: safeData, options: []) as! [String: Any]
                let pokemonDetail = Mapper<PokemonDetail>().map(JSON: json)
                completion(.success(pokemonDetail!))
            }
        }.resume()
    }
}
