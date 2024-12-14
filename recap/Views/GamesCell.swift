//
//  GamesCell.swift
//  recap
//
//  Created by Diptayan Jash on 09/11/24.
//

import UIKit

class GamesCell: UICollectionViewCell {
    static let identifier = "GameCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let accessoryIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Set cell size
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 170),
            contentView.heightAnchor.constraint(equalToConstant: 226),
        ])

        // Cell styling
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.backgroundColor = .white

        // Add subviews
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(accessoryIcon)
        contentView.addSubview(dividerLine)
        contentView.addSubview(descriptionLabel)

        // Layout the subviews with the specified dimensions
        imageView.frame = CGRect(x: (contentView.frame.size.width - 90) / 2, y: 10, width: 100, height: 100)

        dividerLine.frame = CGRect(x: 10, y: imageView.frame.maxY + 10, width: contentView.frame.size.width - 20, height: 1)

        nameLabel.frame = CGRect(x: 10, y: dividerLine.frame.maxY + 8, width: contentView.frame.size.width - 40, height: 20)

        accessoryIcon.frame = CGRect(x: contentView.frame.size.width - 25, y: dividerLine.frame.maxY + 8, width: 15, height: 15)

        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.frame.maxY + 5, width: contentView.frame.size.width - 20, height: 20)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with gamesDemo: Games) {
        imageView.image = UIImage(named: gamesDemo.imageName)
        nameLabel.text = gamesDemo.name
        descriptionLabel.text = gamesDemo.description
    }
}
