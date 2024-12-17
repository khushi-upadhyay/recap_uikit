//
//  FamilyMemberDetailViewController.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import SDWebImage
import UIKit

class FamilyMemberDetailViewController: UIViewController {
    var member: FamilyMember
    private var stackView: UIStackView!

    init(member: FamilyMember) {
        self.member = member
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.updateLayout(for: size)
        })
    }

    private func setLayout() {
        view.backgroundColor = .systemBackground
        navigationItem.title = member.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissView))

        let imageView = createProfileImageView()

        let nameLabel = createNameLabel()
        let relationshipLabel = createRelationshipLabel()
        let phoneStack = createInfoStack(withIcon: "phone.fill", text: member.phone, color: .green)
        let emailStack = createInfoStack(withIcon: "envelope.fill", text: "\(member.name.lowercased().replacingOccurrences(of: " ", with: ""))@example.com", color: .blue)

        let callButton = createCallButton()
        callButton.widthAnchor.constraint(equalToConstant: 200).isActive = true

        let detailsStack = UIStackView(arrangedSubviews: [nameLabel, relationshipLabel, phoneStack, emailStack, callButton])
        detailsStack.axis = .vertical
        detailsStack.spacing = 10
        detailsStack.alignment = .center

        stackView = UIStackView(arrangedSubviews: [imageView, detailsStack])
        stackView.axis = .vertical // Start in portrait mode
        stackView.spacing = 20
        stackView.alignment = .center

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        updateLayout(for: view.bounds.size)
    }

    private func updateLayout(for size: CGSize) {
        if size.width > size.height {
            // Landscape: Horizontal layout
            stackView.axis = .horizontal
            stackView.alignment = .center
        } else {
            // Portrait: Vertical layout
            stackView.axis = .vertical
            stackView.alignment = .center
        }
    }

    private func createProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        if let savedImage = UserDefaultsStorageFamilyMember.shared.getFamilyMemberImage(for: member.id) {
               imageView.image = savedImage
           } else {
               imageView.image = UIImage(systemName: "person.circle.fill")
           }
//        imageView.image = UIImage(named: member.imageName)
//        imageView
//            .sd_setImage(
//                with: URL(string: member.imageURL),
//                placeholderImage: UIImage(named: "placeholder")
//            )
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return imageView
    }

    private func createNameLabel() -> UILabel {
        let label = UILabel()
        label.text = member.name
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }

    private func createRelationshipLabel() -> UILabel {
        let label = UILabel()
        label.text = member.relationship
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }

    private func createInfoStack(withIcon iconName: String, text: String, color: UIColor) -> UIStackView {
        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = color
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)

        let stackView = UIStackView(arrangedSubviews: [iconImageView, label])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }

    private func createCallButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Call \(member.name)", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.addTarget(self, action: #selector(callPhoneNumber), for: .touchUpInside)
        return button
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func callPhoneNumber() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        guard let url = URL(string: "tel://\(member.phone)"), UIApplication.shared.canOpenURL(url) else {
            print("This device does not support phone calls.")
            return
        }
        UIApplication.shared.open(url)
    }
}
