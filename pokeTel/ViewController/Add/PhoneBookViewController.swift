import UIKit

class PhoneBookViewController: UIViewController {
    var viewModel: PhoneBookViewModel? // ViewModel을 받을 프로퍼티
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    private let randomImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.addTarget(self, action: #selector(generateRandomImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let contactName = viewModel?.contactName {
            nameTextField.text = contactName
        }
        if let contactPhone = viewModel?.contactPhone {
            phoneTextField.text = contactPhone
        }
        if let contactImage = viewModel?.contactImage {
            profileImageView.image = contactImage
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveContact))
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, randomImageButton, nameTextField, phoneTextField])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            phoneTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            randomImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }
    
    @objc private func generateRandomImage() {
        viewModel?.generateRandomImage { [weak self] image in
            if let image = image {
                self?.profileImageView.image = image
            } else {
                self?.showAlert(message: "이미지를 불러오지 못했습니다.")
            }
        }
    }
    
    @objc private func saveContact() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            showAlert(message: "이름과 전화번호를 입력해주세요.")
            return
        }
        
        viewModel?.saveContact(name: name, phone: phoneNumber, image: profileImageView.image)
        navigationController?.popViewController(animated: true)
    }
}
