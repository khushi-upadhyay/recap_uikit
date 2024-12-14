import UIKit

protocol CategoryStackViewDelegate: AnyObject {
    func categoryStackView(_ stackView: CategoryStackView, didReceiveDropWith word: String)
}

class CategoryStackView: UIStackView {
    weak var delegate: CategoryStackViewDelegate?
    let category: String
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let wordsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    init(title: String) {
        self.category = title
        super.init(frame: .zero)
        
        titleLabel.text = title
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        axis = .vertical
        spacing = 8
        alignment = .fill
        
        containerView.addSubview(wordsStack)
        wordsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 150),
            
            wordsStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            wordsStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            wordsStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            wordsStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(containerView)
    }
    
    func addWord(_ word: String) {
        let label = UILabel()
        label.text = word
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        wordsStack.addArrangedSubview(label)
    }
}
#Preview(){
    CategoryStackView(title: "George")
}
