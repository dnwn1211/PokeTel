//
//  PhoneBookViewModal.swift
//  pokeTel
//
//  Created by 김석준 on 12/12/24.
//

import UIKit

class PhoneBookViewModel {
    // Input Properties
    var contactName: String?
    var contactPhone: String?
    var contactImage: UIImage?
    
    // Callback for saving contact data
    var onSave: ((String, String, UIImage?) -> Void)?
    
    // 랜덤 이미지 생성
    func generateRandomImage(completion: @escaping (UIImage?) -> Void) {
        let randomID = Int.random(in: 1...1000)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                if let imageUrl = URL(string: pokemon.sprites.frontDefault),
                   let imageData = try? Data(contentsOf: imageUrl),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // 연락처 저장
    func saveContact(name: String, phone: String, image: UIImage?) {
        onSave?(name, phone, image)
    }
}
