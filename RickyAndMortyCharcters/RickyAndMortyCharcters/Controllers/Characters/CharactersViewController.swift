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
    
    var selectedCellIndexPath: IndexPath!
    
    let charactersVM = CharactersViewModel()
    let networkHandler = RAMNetworkHandler()
    var initiatedAPICall = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersTV.automaticallyAdjustsScrollIndicatorInsets = false
        charactersTV.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        charactersTV.dataSource = self
        defineViewModel()
        //navigationController?.navigationBar.prefersLargeTitles = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        if !self.initiatedAPICall && networkHandler.isConnected {
            performInitialAPICall()
            DispatchQueue.main.async {
                self.connectingView.isHidden = true
            }
        }
        
        //if selectedCellIndexPath = charactersTV.indexPathForSelectedRow
        if selectedCellIndexPath != nil {
            charactersTV.deselectRow(at: selectedCellIndexPath, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !self.initiatedAPICall && !networkHandler.isConnected  {
            self.presentViewController(nibName: "NoNetworkViewController")
        }
    }
    
    func performInitialAPICall() {
        initiatedAPICall = true
        self.charactersVM.getCharacters()
    }
    
    
    func defineViewModel() {
        
        charactersVM.reloadTableView = {
            self.charactersTV.reloadData()
        }
    }
    
    func presentViewController(nibName: String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        var VC = storyBoard.instantiateViewController(withIdentifier: nibName)
        
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .crossDissolve
        
        present(VC, animated: true)
    }
    
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersVM.charcterProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.characterProfile = charactersVM.charcterProfiles[indexPath.row]
        return cell
    }
    
    
}

extension CharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndexPath = indexPath
        performSegue(withIdentifier: "CharacterProfileViewController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacterProfileViewController" {
            let destinationVC = segue.destination as! CharacterProfileViewController
            destinationVC.profile = charactersVM.charcterProfiles[selectedCellIndexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == charactersVM.charcterProfiles.count {
            charactersVM.getCharacters()
        }
    }
    
    
}



