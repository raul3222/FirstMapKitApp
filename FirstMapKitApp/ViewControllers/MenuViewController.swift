////
////  MenuViewController.swift
////  FirstMapKitApp
////
////  Created by Raul Shafigin on 17.05.2022.
////
//
//import UIKit
//
//class MenuViewController: UIViewController {
//
//    var tableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//        configureTableView()
//
//    }
//    
//    func configureTableView() {
//        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseId)
//        view.addSubview(tableView)
//        tableView.frame = view.bounds
//        tableView.separatorStyle = .none
//        tableView.rowHeight = 90
//    }
//
//}
//
//extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseId) as! MenuTableViewCell
//        return cell
//    }
//}
