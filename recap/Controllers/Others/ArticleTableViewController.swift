//
//  ArticleTableViewController.swift
//  Recap
//
//  Created by admin70 on 05/11/24.
//

import UIKit

class ArticleTableViewController: UITableViewController {
    private var articles = sampleArticles
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        
        setupTableView()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradientBackground()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: articles[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 260
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let detailVC = ArticleDetailViewController(article: article)
        let navController = UINavigationController(rootViewController: detailVC)
//        navigationController?.pushViewController(detailVC, animated: true)
        present(navController, animated: true, completion: nil)
    }
}

#Preview(){
    ArticleTableViewController()
}
