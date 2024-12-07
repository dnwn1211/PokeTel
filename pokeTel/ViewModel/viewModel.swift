//
//  viewModel.swift
//  pokeTel
//
//  Created by 김석준 on 12/7/24.
//

import Foundation
import UIKit

class ContactListViewModel {
    // Output: 연락처 리스트를 View에 전달
    var contacts: [Contact] = [
        Contact(id: UUID(), name: "John Doe", phoneNumber: "123-456-7890", profileImage: UIImage(systemName: "person.fill")),
        Contact(id: UUID(), name: "Jane Smith", phoneNumber: "987-654-3210", profileImage: UIImage(systemName: "person.fill")),
        Contact(id: UUID(), name: "Alice Brown", phoneNumber: "555-123-4567", profileImage: UIImage(systemName: "person.fill"))
    ]
    
    // 새로운 연락처 추가
    func addContact(name: String, phoneNumber: String, profileImage: UIImage?) {
        let newContact = Contact(id: UUID(), name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        contacts.append(newContact)
    }
}
