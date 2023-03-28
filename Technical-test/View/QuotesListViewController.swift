//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit
import Combine

final class QuotesListViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel: QuotesViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SMI"
        bindViewModel()
        viewModel.getQuotes()
        setupTableView()
        setupAutoLayout()
    }
}

extension QuotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quoteFavourite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as! TableViewCell
        let quote = viewModel.quoteFavourite[indexPath.row]
        cell.configureWith(quote: quote)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let quote = viewModel.quoteFavourite[indexPath.row]
        let detailsVC = QuoteDetailsViewController(quote: quote)
        detailsVC.updateCallBack = { [weak self] in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

private extension QuotesListViewController {
    func bindViewModel() {
        viewModel = QuotesViewModel()
        viewModel.$quoteFavourite
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] _ in
                        self?.tableView.reloadData()
                    }
                    .store(in: &cancellables)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
