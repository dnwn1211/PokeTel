import UIKit

class AddContactViewController: UIViewController {
    var onSave: ((String, String, UIImage?) -> Void)? // 데이터 저장 콜백
    
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
        imageView.layer.borderWidth = 1
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
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "연락처 추가"
        
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
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            phoneTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            randomImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }
    
    @objc private func generateRandomImage() {
        let randomID = Int.random(in: 1...1000)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                // JSON 디코딩
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // JSON 정보를 콘솔에 출력
                    print("API Response: \(json)")
                    
                    // 필요한 데이터 추출
                    if let sprites = json["sprites"] as? [String: Any],
                       let imageUrlString = sprites["front_default"] as? String,
                       let imageUrl = URL(string: imageUrlString),
                       let imageData = try? Data(contentsOf: imageUrl),
                       let image = UIImage(data: imageData) {
                        // UI 업데이트는 메인 스레드에서 실행
                        DispatchQueue.main.async {
                            self.profileImageView.image = image
                        }
                    } else {
                        print("Image URL not found")
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    @objc private func saveContact() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            print("이름과 전화번호를 입력해주세요.")
            return
        }
        onSave?(name, phoneNumber, profileImageView.image) // 데이터 전달
        navigationController?.popViewController(animated: true) // 이전 화면으로 돌아가기
    }
}
