//
//  CharacterCell.swift
//  RickyAndMortyCharcters
//
//  Created by MEP LAB 01 on 28/10/22.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    //Image View
    @IBOutlet weak var characterImageView: UIImageView!
    //Labels
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var statusAndSpecies: UILabel!
    //UIView
    @IBOutlet weak var lifeIndicator: UIView!
    
    var characterProfile: Profile? {
        didSet {
            let id = characterProfile?.id
            self.name.text = characterProfile?.name
            self.statusAndSpecies.text = characterProfile?.statusAndSpecies
            self.lifeIndicator.backgroundColor = characterProfile?.status == "Alive" ? UIColor.systemGreen : UIColor.systemRed
            let url = URL(string: self.characterProfile?.image ?? "")!
            
            if let image = ImageCache.shared.image(for: url) {
                self.characterImageView.image = image
                self.characterImageView.isHidden = false
            } else {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            if id == self.characterProfile?.id {
                                self.characterImageView?.image = image
                                self.characterImageView.isHidden = false
                            }
                        }
                        ImageCache.shared[url] = image
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.characterImageView.image = nil
    }
    
}
