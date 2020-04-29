//
//  BasketViewController.swift
//  CodeRedStore
//
//  Created by denisok on 17/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class BasketViewController: UITableViewController {
    
    var presenter: BasketPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Корзина"
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter = BasketPresenter()
        
        tableView.reloadData()
        print("view will apear in basket view controlelr")
    }
    
    
//    func checkProductInBasket() {
//        if presenter?.basketMdoel.datasource.isEmpty {
//            print("Ваша корзина пуста")
//        }
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getBasketCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.id, for: indexPath) as! BasketTableViewCell
        let item = presenter!.getBasket(for: indexPath.row)
        
        let fileManagerStore = FileManagerStore()
        
        if let imgName = item.imageName {
            cell.loadImage(fileManagerStore.fetchImage(imageName: imgName)!)
            print(imgName)
        }
        
        cell.configureCell(basket: item)
        return cell
    }
    
}

extension BasketViewController: BasketViewPresenter {
    func updateView() {
        DispatchQueue.main.async {
            print("realod tabel view")
            self.tableView.reloadData()
        }
    }
    
    
}

