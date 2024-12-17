//
//  FamilyMemberCell.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import UIKit
import SDWebImage

class FamilyMemberCell: UICollectionViewCell {
    static let identifier = "FamilyMemberCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private let relationshipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
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
        contentView.addSubview(relationshipLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(accessoryIcon)
        contentView.addSubview(dividerLine)

        // Layout the subviews with the specified dimensions
        imageView.frame = CGRect(x: (contentView.frame.size.width - 90) / 2, y: 10, width: 100, height: 100)

        dividerLine.frame = CGRect(x: 10, y: imageView.frame.maxY + 10, width: contentView.frame.size.width - 20, height: 1)

        nameLabel.frame = CGRect(x: 10, y: dividerLine.frame.maxY + 8, width: contentView.frame.size.width - 40, height: 20)

        accessoryIcon.frame = CGRect(x: contentView.frame.size.width - 25, y: dividerLine.frame.maxY + 8, width: 15, height: 15)

        relationshipLabel.frame = CGRect(x: 10, y: nameLabel.frame.maxY + 5, width: contentView.frame.size.width - 20, height: 18)

        phoneLabel.frame = CGRect(x: 10, y: relationshipLabel.frame.maxY + 5, width: contentView.frame.size.width - 20, height: 18)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func configure(with familyMember: FamilyMember) {
////        imageView.image = UIImage(named: familyMember.imageName)
//        imageView.sd_setImage(with: URL(string: familyMember.imageURL), placeholderImage: UIImage(named: "placeholder"))
//        nameLabel.text = familyMember.name
//        relationshipLabel.text = familyMember.relationship
//        phoneLabel.text = familyMember.phone
//    }
    
    func configure(with familyMember: FamilyMember) {
        nameLabel.text = familyMember.name
        relationshipLabel.text = familyMember.relationship
        phoneLabel.text = familyMember.phone
        
        if let savedImage = UserDefaultsStorageFamilyMember.shared.getFamilyMemberImage(
            for: familyMember.id
        ) {
            imageView.image = savedImage
        } else {
            imageView.image = UIImage(systemName: "person.circle.fill")
        }
    }
}

#Preview(){
    FamilyMemberCell()
}
