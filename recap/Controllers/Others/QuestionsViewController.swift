//
//  QuestionsViewController.swift
//  recap
//
//  Created by Diptayan Jash on 09/11/24.
//

import UIKit

class QuestionsViewController: UITableViewController {
    
    private var randomQuestions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView()

        title = "Questions"
        navigationController?.navigationBar.prefersLargeTitles = true
        randomQuestions = Array(questionsDemo.shuffled().prefix(5))
    }
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradientBackground()
    }

    private func tableView() {
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
    }

    // MARK: - Table view data source & delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomQuestions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: QuestionCell.identifier,
            for: indexPath
        ) as? QuestionCell else {
            return UITableViewCell()
        }

        let question = randomQuestions[indexPath.row]
        cell.configure(with: question)

        cell.contentView.preservesSuperviewLayoutMargins = false
        cell.preservesSuperviewLayoutMargins = false

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
            let selectedQuestion = randomQuestions[indexPath.row]
            let answerVC = AnswerViewController(question: selectedQuestion)
            
            answerVC.onAnswerSubmitted = { [weak self] in
                guard let self = self else { return }
                self.randomQuestions[indexPath.row].isAnswered = true
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }

            let navController = UINavigationController(rootViewController: answerVC)
            navController.modalPresentationStyle = .pageSheet
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.prefersEdgeAttachedInCompactHeight = true
            }
            present(navController, animated: true, completion: nil)
    }
}

extension UIView {
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemOrange.withAlphaComponent(0.1).cgColor,
            UIColor.systemBackground.cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.6)
        gradientLayer.frame = bounds

        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

#Preview() {
    QuestionsViewController()
}
