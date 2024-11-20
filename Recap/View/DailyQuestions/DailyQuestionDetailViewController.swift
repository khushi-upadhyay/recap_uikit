////
////  DailyQuestionCollectionViewCell.swift
////  Recap
////
////  Created by admin70 on 05/11/24.


import UIKit

class DailyQuestionDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var question: Question?

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Answer your loved one's daily questions anytime to support their memory journey."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // TableView
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        return table
    }()
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }

    // Use the data model to fetch the questions
    let questions = QuestionData

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Daily Question"

        // Set up the plus icon on the top-right corner
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addQuestion)
        )

        view.addSubview(captionLabel)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)

        setupConstraints()
    }

    // MARK: - Layout Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Add Question Action
//    @objc private func addQuestion() {
//        let addQuestionVC = AddQuestionViewController()
//        let navController = UINavigationController(rootViewController: addQuestionVC)
//        navController.modalPresentationStyle = .automatic
//        present(navController, animated: true, completion: nil)
//    }
    
    
    @objc private func addQuestion() {
        let addQuestionVC = AddQuestionViewController()
        let navController = UINavigationController(rootViewController: addQuestionVC)

        // Configure the sheet presentation for the navigation controller
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // Allows the sheet to appear in medium and large sizes
            sheet.prefersGrabberVisible = true // Adds a grabber for better user experience
            sheet.prefersEdgeAttachedInCompactHeight = true // Makes it appear from the bottom in compact height
        }

        present(navController, animated: true, completion: nil)
    }



    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: QuestionCell.identifier,
            for: indexPath
        ) as? QuestionCell else {
            return UITableViewCell()
        }
        
        let question = questions[indexPath.row]
        cell.configure(with: question)
        
        cell.contentView.preservesSuperviewLayoutMargins = false
        cell.preservesSuperviewLayoutMargins = false

        return cell
    }

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Handle selection
        let selectedQuestion = questions[indexPath.row]
        let detailVC = QuestionDetailViewController()
        detailVC.question = selectedQuestion
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

#Preview(){
    DailyQuestionDetailViewController()
}
