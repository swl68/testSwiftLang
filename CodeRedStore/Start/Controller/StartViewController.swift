//
//  StartViewController.swift
//  CodeRedStore
//
//  Created by denisok on 26/01/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    let startModel = StartModel()
    let tableView = UITableView()
    
    var typeClothes: [String] = []
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Мужское", "Женское"])
        segmentedControl.isSelected = true
        segmentedControl.tintColor = .black
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(switchSegmented), for: .valueChanged)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       // navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Главная"
   
        setupTableView()
        setupStackView(views: setViews())
    }
    
    func setViews() -> [UIView] {
        var views: [UIView] = []
        views = [segmentedControl, tableView]
        return views
    }
    
    func setupStackView(views: [UIView]) {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        typeClothes = startModel.getTypeClothes()
    }

    @objc func switchSegmented(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 0:
            startModel.isMan = true
            typeClothes = startModel.getTypeClothes()
        default:
            startModel.isMan = false
            typeClothes = startModel.getTypeClothes()
        }
        tableView.reloadData()
    }

}


extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeClothes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell {
            cell.setupCell(text: typeClothes[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVc = MainViewController()
        let presenter = MainViewPresenter(view: mainVc, typeKey: startModel.getKeyClothesFromDict(for: typeClothes[indexPath.row]) )
        mainVc.presenter = presenter
        navigationController?.pushViewController(mainVc, animated: true)
    }
}
