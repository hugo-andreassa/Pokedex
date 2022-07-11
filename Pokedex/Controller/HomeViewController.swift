//
//  ViewController.swift
//  Pokedex
//
//  Created by Hugo Andreassa Amaral (P) on 08/07/22.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let service = PokemonService()
    var pokemonList: [PokemonItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        getPokemonList()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Pokemon Solid", size: 30)!]
        self.view.layoutSubviews()
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
    }
    
    func getPokemonList() {
        SVProgressHUD.show()
        service.getPokemonList { result in
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self.pokemonList = pokemonList.pokemons ?? []
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("Erro ao chamar API")
            }
            
            SVProgressHUD.dismiss()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
        let item = self.pokemonList[indexPath.row]
        
        cell.lblName.text = item.name?.capitalizingFirstLetter() ?? ""
        cell.setupImage(detailURL: item.url ?? "", service: service)
        
        return cell
    }
}


