//
//  StreaksViewController.swift
//  recap_home
//
//  Created by user@47 on 19/11/24.
//


import UIKit

class StreaksViewController: UIViewController {
    
    private let headerView = UIView()
    private let streakStatsView = UIView()
    private let calendarView = UIView()
    private let calendarCollectionView: UICollectionView!
    private let monthYearLabel = UILabel()
    private let previousMonthButton = UIButton()
    private let nextMonthButton = UIButton()
    
    private var currentMonth = 11
    private var currentYear = 2024
    private let calendarData: [Int: Bool] = [
        1: true, 2: false, 3: true, 4: true, 5: true,
        6: true, 7: false, 8: true, 9: true, 10: false,
        11: false, 12: true, 13: true, 14: true, 15: false,
        16: false, 17: true, 18: false, 19: true, 20: true,
        21: false, 22: true, 23: true, 24: true, 25: false,
        26: true, 27: true, 28: false, 29: true, 30: true
    ]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupGradientBackground()
        setupNavBar()
        setupProfileView()
        setupStreakStatsView()
        setupHeaderView()
        setupCalendarView()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor,
            UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupProfileView() {
        let profileImageView = UIImageView(image: UIImage(named: "profile_placeholder"))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupNavBar() {
        title = "Streaks"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goBack))
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupStreakStatsView() {
        streakStatsView.backgroundColor = .white
        streakStatsView.layer.cornerRadius = 12
        streakStatsView.layer.shadowColor = UIColor.black.cgColor
        streakStatsView.layer.shadowOpacity = 0.1
        streakStatsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        streakStatsView.layer.shadowRadius = 4
        streakStatsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(streakStatsView)
        
        let streakStatsStackView = UIStackView()
        streakStatsStackView.axis = .horizontal
        streakStatsStackView.distribution = .fillEqually // Fill space to prevent overflow
        streakStatsStackView.alignment = .center
        streakStatsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let maxStreakView = createStatView(title: "Max Streak", value: "9")
        let currentStreakView = createStatView(title: "Current Streak", value: "5")
        let activeDaysView = createStatView(title: "Active Days", value: "18")
        
        streakStatsStackView.addArrangedSubview(maxStreakView)
        streakStatsStackView.addArrangedSubview(currentStreakView)
        streakStatsStackView.addArrangedSubview(activeDaysView)
        
        streakStatsView.addSubview(streakStatsStackView)
        
        NSLayoutConstraint.activate([
            streakStatsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            streakStatsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            streakStatsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            streakStatsView.heightAnchor.constraint(equalToConstant: 80),
            
            streakStatsStackView.leadingAnchor.constraint(equalTo: streakStatsView.leadingAnchor, constant: 16),
            streakStatsStackView.trailingAnchor.constraint(equalTo: streakStatsView.trailingAnchor, constant: -16),
            streakStatsStackView.topAnchor.constraint(equalTo: streakStatsView.topAnchor, constant: 16),
            streakStatsStackView.bottomAnchor.constraint(equalTo: streakStatsView.bottomAnchor, constant: -16)
        ])
    }

    
    private func setupHeaderView() {
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 12
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 0.1
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        headerView.layer.shadowRadius = 4
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        let largeFlameImageView = UIImageView(image: UIImage(systemName: "flame.fill"))
                largeFlameImageView.tintColor = .systemOrange
                largeFlameImageView.contentMode = .scaleAspectFit
                largeFlameImageView.translatesAutoresizingMaskIntoConstraints = false
                
        
        let daysStackView = UIStackView()
        daysStackView.axis = .horizontal
        daysStackView.distribution = .equalSpacing
        daysStackView.alignment = .center
        daysStackView.spacing = 8
        daysStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let days = ["M", "T", "W", "Th", "F", "S", "S"]
        for day in days {
            let dayContainer = UIStackView()
            dayContainer.axis = .vertical
            dayContainer.alignment = .center
            dayContainer.spacing = 4
            dayContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let flameImage = UIImageView(image: UIImage(systemName: "flame.fill"))
            flameImage.tintColor = .systemOrange
            flameImage.contentMode = .scaleAspectFit
            flameImage.translatesAutoresizingMaskIntoConstraints = false
            
            let dayLabel = UILabel()
            dayLabel.text = day
            dayLabel.font = UIFont.systemFont(ofSize: 12)
            dayLabel.textAlignment = .center
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            
            dayContainer.addArrangedSubview(flameImage)
            dayContainer.addArrangedSubview(dayLabel)
            daysStackView.addArrangedSubview(dayContainer)
            
            NSLayoutConstraint.activate([
                flameImage.heightAnchor.constraint(equalToConstant: 16),
                flameImage.widthAnchor.constraint(equalToConstant: 16),
            ])
        }
        headerView.addSubview(daysStackView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: streakStatsView.bottomAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            daysStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            daysStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            daysStackView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }

    
    private func setupCalendarView() {
        calendarView.backgroundColor = .white
        calendarView.layer.cornerRadius = 12
        calendarView.layer.shadowColor = UIColor.black.cgColor
        calendarView.layer.shadowOpacity = 0.1
        calendarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        calendarView.layer.shadowRadius = 4
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        
        previousMonthButton.setTitle("<", for: .normal)
        previousMonthButton.setTitleColor(.systemBlue, for: .normal)
        previousMonthButton.addTarget(self, action: #selector(handlePreviousMonth), for: .touchUpInside)
        previousMonthButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextMonthButton.setTitle(">", for: .normal)
        nextMonthButton.setTitleColor(.systemBlue, for: .normal)
        nextMonthButton.addTarget(self, action: #selector(handleNextMonth), for: .touchUpInside)
        nextMonthButton.translatesAutoresizingMaskIntoConstraints = false
        
        monthYearLabel.text = formattedMonthYear()
        monthYearLabel.font = UIFont.boldSystemFont(ofSize: 22)
        monthYearLabel.textAlignment = .center
        monthYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let calendarHeaderStack = UIStackView(arrangedSubviews: [previousMonthButton, monthYearLabel, nextMonthButton])
        calendarHeaderStack.axis = .horizontal
        calendarHeaderStack.alignment = .center
        calendarHeaderStack.distribution = .equalSpacing
        calendarHeaderStack.translatesAutoresizingMaskIntoConstraints = false
        calendarView.addSubview(calendarHeaderStack)
        
        calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "CalendarCell")
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.backgroundColor = .white
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.addSubview(calendarCollectionView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            calendarHeaderStack.topAnchor.constraint(equalTo: calendarView.topAnchor, constant: 16),
            calendarHeaderStack.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 16),
            calendarHeaderStack.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -16),
            
            calendarCollectionView.topAnchor.constraint(equalTo: calendarHeaderStack.bottomAnchor, constant: 16),
            calendarCollectionView.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor, constant: 16),
            calendarCollectionView.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor, constant: -16),
            calendarCollectionView.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func handlePreviousMonth() {
        currentMonth -= 1
        if currentMonth < 1 {
            currentMonth = 12
            currentYear -= 1
        }
        monthYearLabel.text = formattedMonthYear()
    }
    
    @objc private func handleNextMonth() {
        currentMonth += 1
        if currentMonth > 12 {
            currentMonth = 1
            currentYear += 1
        }
        monthYearLabel.text = formattedMonthYear()
    }
    
    private func formattedMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        let components = DateComponents(year: currentYear, month: currentMonth)
        let date = Calendar.current.date(from: components)!
        return dateFormatter.string(from: date)
    }
    
    private func createStatView(title: String, value: String) -> UIView {
        let container = UIView()
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 18)
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(valueLabel)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: container.topAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
}

extension StreaksViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarData.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }
        
        let day = indexPath.item + 1
        cell.dayLabel.text = "\(day)"
        cell.contentView.backgroundColor = calendarData[day] == true ? UIColor.systemOrange.withAlphaComponent(0.5) : .white
        cell.contentView.layer.cornerRadius = cell.contentView.frame.width / 2
        return cell
    }
}

class CalendarCell: UICollectionViewCell {
    let dayLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = frame.width / 2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.clipsToBounds = true
        
        dayLabel.font = UIFont.systemFont(ofSize: 16)
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




#Preview() {
    StreaksViewController()
}
