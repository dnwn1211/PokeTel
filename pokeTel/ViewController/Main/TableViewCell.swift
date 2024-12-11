import UIKit

class TableViewCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // 프로필 이미지 설정
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.contentMode = .scaleAspectFill

        // 이름과 전화번호 라벨 설정
        nameLabel.font = .boldSystemFont(ofSize: 16)
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .gray
        
        // StackView를 가로로 설정
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fill

        // StackView에 이름과 전화번호 라벨 추가
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(phoneLabel)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // 프로필 이미지 설정
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),

            // StackView (이름, 전화번호) 설정
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(name: String, phoneNumber: String, profileImage: UIImage?) {
        nameLabel.text = name
        phoneLabel.text = phoneNumber
        profileImageView.image = profileImage
    }

    // 비동기 이미지 로딩 (옵션)
    func loadProfileImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.profileImageView.image = image
            }
        }
        task.resume()
    }
}
