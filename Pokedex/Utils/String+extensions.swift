//
//  String+extensions.swift
//  Pokedex
//
//  Created by Hugo Andreassa Amaral (P) on 11/07/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
