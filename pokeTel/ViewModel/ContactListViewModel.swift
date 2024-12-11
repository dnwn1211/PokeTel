//
//  viewModel.swift
//  pokeTel
//
//  Created by 김석준 on 12/7/24.
//
import Foundation
import UIKit

class ContactListViewModel {
    var contacts: [(name: String, phoneNumber: String, profileImage: UIImage?)] = []

    func addContact(name: String, phoneNumber: String, profileImage: UIImage?) {
        contacts.append((name, phoneNumber, profileImage))
    }
    
    func updateContact(at index: Int, name: String, phoneNumber: String, profileImage: UIImage?) {
        guard index < contacts.count else { return }
        contacts[index] = (name, phoneNumber, profileImage)
    }
    
    func sortContacts() {
        contacts.sort { $0.name < $1.name }
    }
}

