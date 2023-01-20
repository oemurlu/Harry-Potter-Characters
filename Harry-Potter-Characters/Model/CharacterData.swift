//
//  CharacterData.swift
//  Harry-Potter-Characters
//
//  Created by Osman Emre Ömürlü on 18.01.2023.
//

import Foundation

struct CharacterDatum: Codable {
    let name: String
    let image: String
    let ancestry: String?
    let yearOfBirth: Int?
    let actor: String?
}

//typealias gecici isim demek
typealias CharacterData = [CharacterDatum]

// mesela parseJSON da CharacterData.self dedik ya onun yerine [CharacterDatum].self de diyebiliriz.



