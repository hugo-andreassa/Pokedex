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
    @IBOutlet weak var imgSprit: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    func setupImage(detailURL: String, service: PokemonService) {
        service.getPokemonDetail(url: detailURL, completion: { result in
            do {
                switch result {
                case .success(let pokemonDetail):
                    let url = URL(string: pokemonDetail.sprite?.frontSpritUrl ?? "")!
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imgSprit.image = UIImage(data: data)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.imgSprit.image = UIImage(named: "pokebola")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.imgSprit.image = UIImage(named: "pokebola")
                }
            }
        })
    }
}
