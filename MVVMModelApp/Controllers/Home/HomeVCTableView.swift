//
//  HomeVCTableView.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        registerCells()
        productsTableView.backgroundColor = .clear
    }
    
    func registerCells() {
        productsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    
}
