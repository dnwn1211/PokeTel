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
    var contacts: [Contact]

    // 초기화 시 데이터를 주입받도록 수정
    init(contacts: [Contact] = []) {
        self.contacts = contacts
    }

    // 새로운 연락처 추가
    func addContact(name: String, phoneNumber: String, profileImage: UIImage?) {
        let newContact = Contact(id: UUID(), name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        contacts.append(newContact)
    }
}

