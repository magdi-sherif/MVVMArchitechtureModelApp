//
//  HomeVC.swift
//  MVVMModelApp
//
//  Created by magdi sherif on 27/09/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setupTableView()
    }
    
    private func setView() {
        title = "Home"
        view.backgroundColor = .link
    }


}
