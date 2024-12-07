import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "pokeTel 친구" // 네비게이션 바 타이틀 설정
    }
}
