//
//  ViewController.swift
//  Harry-Potter-Characters
//
//  Created by Osman Emre Ömürlü on 17.01.2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var characterArray: [CharacterModel] = []
    //characterArray static yaparak, baska controllerden de erisebiliyorum artik.
    
    var selectedIndex: Int = 0
    var selectedCharacterName = ""
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
        tableView.dataSource = self
        tableView.delegate = self
        getResults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Character List"
    }
  
    //MARK: - Functions
    func getResults() {
        if let url = URL(string: "https://hp-api.onrender.com/api/characters") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil || data == nil {
                    print("Error fetching data: \(error!)")
                    fatalError("error1")
                }
                if let safeData = data {
                    if let _ = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ resultData: Data) -> [CharacterModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CharacterData.self, from: resultData)
            
            for character in decodedData {
                SearchViewController.characterArray.append(CharacterModel(name: character.name, image: character.image, ancestry: character.ancestry, yearOfBirth: character.yearOfBirth, actor: character.actor))
            }
            return SearchViewController.characterArray
        } catch {
            print("parseJSON error: \(error)")
            return nil
        }
    }
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchViewController.characterArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = SearchViewController.characterArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! TableViewCell
        cell.characterNameLabel.text = character.name
        cell.thumbnailImageView.sd_setImage(with: URL(string: character.image), placeholderImage: UIImage(named: "placeholder.svg"))
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsVC" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.characterArray = SearchViewController.characterArray
            detailsVC.characterIndex = selectedIndex
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDetailsVC", sender: self)
    }
}

