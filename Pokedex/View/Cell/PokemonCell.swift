//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Hugo Andreassa Amaral (P) on 08/07/22.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTypes: UILabel!
    @IBOutlet weak var imgSprit: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainer()
    }
    
    func setupDetails(detailURL: String, service: PokemonService) {
        service.getPokemonDetail(url: detailURL, completion: { result in
            switch result {
            case .success(let pokemonDetail):
                DispatchQueue.main.async {
                    self.loadImage(spritUrl: pokemonDetail.sprite?.frontSpritUrl ?? "")
                    self.setupTypes(types: pokemonDetail.types?.compactMap({ $0.nameType }) ?? [])
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.loadImage(spritUrl: "")
                }
            }
        })
    }
    
    private func loadImage(spritUrl: String) {
        do {
            guard let url = URL(string: spritUrl) else {
                self.imgSprit.image = UIImage(named: "pokebola")
                return
            }
            let data = try Data(contentsOf: url)
            self.imgSprit.image = UIImage(data: data)
        } catch {
            self.imgSprit.image = UIImage(named: "pokebola")
        }
    }
    
    private func setupTypes(types: [String]) {
        if types.isEmpty {
            self.lblTypes.isHidden = true
        }
        
        lblTypes.text = types.joined(separator: ", ")
    }
    
    private func setupContainer() {
        // corner radius
        viewBackground.layer.cornerRadius = 10

        // border
        viewBackground.layer.borderWidth = 1.0
        viewBackground.layer.borderColor = UIColor.black.cgColor

        // shadow
        viewBackground.layer.shadowColor = UIColor.black.cgColor
        viewBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewBackground.layer.shadowOpacity = 0.7
        viewBackground.layer.shadowRadius = 4.0
    }
}
