//
//  DetailViewController.swift
//  CodeRedStore
//
//  Created by denisok on 10/12/2019.
//  Copyright © 2019 denisok. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, CoreDataStackDelegate {
    
    var presenter: DetailViewPresenterProtocol?
    var tableView = UITableView()
    var indicatorLoad: IndicatorLoad?
    private let detailDelegateDatasource = DetailDelegateDatasource()
    var footerView = FooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailDelegateDatasource.presenter = presenter
        indicatorLoad = IndicatorLoad()
        setupTableView()
        setupConstraint()
        detailDelegateDatasource.footerView = footerView
        
        CoreDataStack.shared.delegate = self
        
        checkCoreData()
        
        footerView.action = { [weak self] in
            self?.presenter?.createBasket()
        }
        
        indicatorLoad?.showIndicator(view: self.view)
    }
    
    func checkCoreData() {
        let context = CoreDataStack.shared.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Basket")
        
        do {
            let result = try context.fetch(fetchRequest)
            for item in result as! [NSManagedObject] {
                print(item.value(forKey: "name"))
                print(item.value(forKey: "price"))
                print(item.value(forKey: "size"))
            }
        } catch  {
            print("Error fetch data")
        }
    }
    
    func dataDidChanged() {
        showMessage("Ok", "Товар успешно добавлен")
    }
    
    func setupTableView() {
        tableView.delegate = detailDelegateDatasource
        tableView.dataSource = detailDelegateDatasource
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .white
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.id)
        tableView.register(AnotherColorTableViewCell.self, forCellReuseIdentifier: AnotherColorTableViewCell.id)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.id)
        tableView.register(SizeTableViewCell.self, forCellReuseIdentifier: SizeTableViewCell.id)
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    deinit {
        print("deinit detailVC")
    }
}

extension DetailViewController: DetailViewProtocol {
  
    func showError(error: String) {
        self.indicatorLoad?.hideIndicator(view: self.view)
        showAlert("Ok", error)
    }
    
    func dataChanged() {
        self.indicatorLoad?.hideIndicator(view: self.view)
        self.tableView.reloadData()
    }
}
