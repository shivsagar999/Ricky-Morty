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
    
    @IBOutlet weak var connectingView: UIView!
    
    let charsctersVM = CharactersViewModel()
    let networkHandler = RAMNetworkHandler()
    var initiatedAPICall = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTV.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        charactersTV.dataSource = self
        defineViewModel()
        networkHandler.initiateNetworkStatusCheck { isConnected in
            if isConnected {
                self.performInitialAPICall()
            }
            self.networkHandler.networkStatusChanged = { connected in
                if connected && !self.initiatedAPICall {
                    self.performInitialAPICall()
                } else if !connected {
                    DispatchQueue.main.async {
                        self.connectingView.isHidden = false
                    }
                } else if connected {
                    DispatchQueue.main.async {
                        self.connectingView.isHidden = true
                    }
                }
            }
        }
        
        
    }
    
    
    func performInitialAPICall() {
        initiatedAPICall = true
        self.charsctersVM.getCharacters()
    }
    
    
    func defineViewModel() {
        
        charsctersVM.reloadTableView = {
            self.charactersTV.reloadData()
        }
    }
    
    func presentViewController(nibName: String) {
        
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



