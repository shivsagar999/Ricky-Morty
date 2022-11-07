//
//  CharacterProfileViewController.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 06/11/22.
//

import UIKit

class CharacterProfileViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusAndSpeciesLabel: UILabel!
    @IBOutlet weak var lastKnownLocation: UILabel!
    @IBOutlet weak var firstSeenInLabel: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    var profile: Profile?
    var profileId: Int?
    let characterProfileVM = CharacterProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defineViewModel()
        if let stringURL = profile?.episode[0] {
            characterProfileVM.getEpisodeName(url: stringURL)
        }
        let url = URL(string: self.profile?.image ?? "")!
        if let image = ImageCache.shared.image(for: url) {
            self.characterImageView.image = image
        }
        nameLabel.text = profile?.name
        statusAndSpeciesLabel.text = profile?.statusAndSpecies
        statusView.backgroundColor = profile?.status == "Alive" ? UIColor.systemGreen : UIColor.systemRed
        lastKnownLocation.text = profile?.location.name
    }
    
    func defineViewModel() {
        
        characterProfileVM.updateEpisode = { episode in
            DispatchQueue.main.async {
                self.firstSeenInLabel.text = episode.name
            }
            
        }
    }

}
