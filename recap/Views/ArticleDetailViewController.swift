//
//  ArticleDetailViewController.swift
//  Recap
//
//  Created by admin70 on 05/11/24.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    private let article: Article

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .label
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = article.title
        setupLayout()

        imageView.image = UIImage(named: article.image)
        titleLabel.text = article.title
        contentTextView.text = article.content
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissView))

        scrollView.addSubview(imageView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(contentTextView)

        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // ImageView constraints for full width
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            // ContentStackView constraints
            contentStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
}

#Preview(){
    ArticleDetailViewController(article: Article(image: "article", title: "Caregiver Stress", subtitle: "The demands of caregiving can be exhausting and overwhelming ...", content: """
        Being a caregiver for a loved one with a chronic illness or condition like Alzheimer's can be incredibly rewarding but also mentally and physically demanding. Caregivers often face overwhelming stress due to the constant emotional and physical demands placed upon them.

        It's important to recognize the signs of caregiver stress, such as:
        - **Physical Exhaustion:** Constant caregiving without adequate rest can lead to burnout and health problems.
        - **Emotional Strain:** Feelings of frustration, sadness, or guilt are common among caregivers.
        - **Isolation:** Caregivers often neglect their own social needs due to time constraints.

        To manage stress, caregivers should focus on self-care strategies like:
        - **Taking Breaks:** It's essential to schedule regular time off, even if it’s just for a short walk or a moment of relaxation.
        - **Seeking Support:** Whether it’s from family, friends, or professional support groups, talking to others can reduce the feeling of isolation.
        - **Setting Realistic Expectations:** Acknowledge that it's okay to ask for help and not do everything alone.

        Recognizing caregiver stress early and taking steps to reduce it is key to ensuring that both the caregiver and the person they care for can thrive.
    """))
}
