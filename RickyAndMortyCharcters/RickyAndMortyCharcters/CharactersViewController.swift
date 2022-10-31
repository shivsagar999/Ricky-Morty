//
//  ViewController.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import UIKit

class CharactersViewController
: UIViewController {

    @IBOutlet weak var charactersTV: UITableView!
    let charctersVM = CharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTV.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        charactersTV.dataSource = self
        defineViewModel()
        charctersVM.getCharacters()
        
    }
    
    
    func defineViewModel() {
        
        charctersVM.reloadTableView = {
            self.charactersTV.reloadData()
        }
    }
    
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charctersVM.charcterProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.characterProfile = charctersVM.charcterProfiles[indexPath.row]
        return cell
    }
    
    
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
}




//struct CharacterProfile {
//    let name: String
//    let status: String
//    let species: String
//    let imageUrl: String
//    var statusAndSpecies: String {
//        return "\(status) - \(species)"
//    }
//
//    init(name: String, status: String, species: String, imageUrl: String) {
//        self.imageUrl = imageUrl
//        self.species = species
//        self.status = status
//        self.name = name
//    }
//}

