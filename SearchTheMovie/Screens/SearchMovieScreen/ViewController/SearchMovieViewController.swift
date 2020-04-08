//
//  ViewController.swift
//  SearchTheMovie
//
//  Created by Alex Chernokun on 08.04.2020.
//  Copyright © 2020 Alex Chernokun. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {
    
    // MARK: - Properties
    let model = SearchMovieModel()
    let networkService = NetworkService()
    var movies: Movies?
    let textField = UITextField()
    let tableView = UITableView()
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextField()
        setupTableView()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = model.navTitle
        view.backgroundColor = .white
    }

    private func setupTextField() {
        textField.placeholder = model.textFieldPlaceholder
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        view.addSubview(textField)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let safeArea = view.safeAreaLayoutGuide
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.centerXAnchor.constraint(equalToSystemSpacingAfter: safeArea.centerXAnchor, multiplier: 0),
                                     textField.topAnchor.constraint(equalToSystemSpacingBelow: safeArea.topAnchor, multiplier: 0),
                                     textField.widthAnchor.constraint(equalToConstant: 250),
                                     textField.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeArea.leadingAnchor, multiplier: 0),
                                     tableView.trailingAnchor.constraint(equalToSystemSpacingAfter: safeArea.trailingAnchor, multiplier: 0),
                                     tableView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 0),
                                     tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: safeArea.bottomAnchor, multiplier: 0)])
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let title = textField.text, title.count > 3, let correctTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        networkService.getMovieFromSearch(with: correctTitle) { result in
            switch result {
            case .success(let data):
                self.movies = Movies.instance(from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// MARK: - TableView conformance
extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: model.cellIdentifier)
        guard let movies = movies?.movies else { return cell }
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.year
        return cell
    }
    
}

//MARK: - Textfield conformance
extension SearchMovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

