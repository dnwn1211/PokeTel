import UIKit

class MainViewController: UIViewController {
    private let tableView = UITableView()
    let viewModel = ContactListViewModel() // ViewModel 인스턴스
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.sortContacts() // 이름순 정렬
        tableView.reloadData()   // 데이터 리로드
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "PokeTel 연락처"
        
        // Add Button
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addContact))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.rowHeight = 80
    }
    
    @objc private func addContact() {
        let addContactVC = PhoneBookViewController()
        addContactVC.onSave = { [weak self] name, phoneNumber, profileImage in
            self?.viewModel.addContact(name: name, phoneNumber: phoneNumber, profileImage: profileImage)
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(addContactVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let contact = viewModel.contacts[indexPath.row]
        cell.configure(name: contact.name, phoneNumber: contact.phoneNumber, profileImage: contact.profileImage)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 연락처 가져오기
        let selectedContact = viewModel.contacts[indexPath.row]

        // PhoneBookViewController로 이동
        let editContactVC = PhoneBookViewController()
        editContactVC.contactName = selectedContact.name
        editContactVC.contactPhone = selectedContact.phoneNumber
        editContactVC.contactImage = selectedContact.profileImage

        // 수정 후 저장하는 콜백 설정
        editContactVC.onSave = { [weak self] name, phoneNumber, profileImage in
            guard let self = self else { return }
            self.viewModel.updateContact(at: indexPath.row, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
            self.tableView.reloadData()
        }

        navigationController?.pushViewController(editContactVC, animated: true)
    }
}



