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
    let charsctersVM = CharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTV.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        charactersTV.dataSource = self
        defineViewModel()
        charsctersVM.getCharacters()
        
    }
    
    
    func defineViewModel() {
        
        charsctersVM.reloadTableView = {
            self.charactersTV.reloadData()
        }
    }
    
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charsctersVM.charcterProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.characterProfile = charsctersVM.charcterProfiles[indexPath.row]
        return cell
    }
    
    
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == charsctersVM.charcterProfiles.count {
            charsctersVM.getCharacters()
        }
    }
}



