//
//  DetailsViewController.swift
//  Harry-Potter-Characters
//
//  Created by Osman Emre Ömürlü on 18.01.2023.
//

//DetailsViewController.swift
import UIKit
class DetailsViewController: UIViewController {
    
    var characterArray: [CharacterModel]!
    var characterIndex: Int!
        
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var ancestoryLabel: UILabel!
    @IBOutlet weak var yearOfBirthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = URL(string: characterArray[characterIndex].image) {
            characterImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder.svg"))
            
            } else {
                characterImage.image = UIImage(named: "placeholder.svg")
            }
        
        nameLabel.text = "Name: \(characterArray[characterIndex].name)"
        actorLabel.text = "Actor: \(characterArray[characterIndex].actor!)"
        
        if characterArray[characterIndex].ancestry == "" {
            ancestoryLabel.text = "Ancestry: No info"
        } else {
            ancestoryLabel.text = "Ancestry: \(characterArray[characterIndex].ancestry!)"
        }
        
        if let year = characterArray[characterIndex].yearOfBirth {
            yearOfBirthLabel.text = "Year of Birth: \(year)"
        } else {
            yearOfBirthLabel.text = "Year of Birth: No info"

        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "qwe", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Character Details"
    }
}
