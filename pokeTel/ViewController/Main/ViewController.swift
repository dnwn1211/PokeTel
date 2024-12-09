import UIKit

class MainViewController: UIViewController {
    private let tableView = UITableView()
    let viewModel = ContactListViewModel() // ViewModel 인스턴스
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
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
        let addContactVC = AddContactViewController()
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
}
