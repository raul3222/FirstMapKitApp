////
////  MenuTableViewCell.swift
////  FirstMapKitApp
////
////  Created by Raul Shafigin on 17.05.2022.
////
//
//import UIKit
//
//class MenuTableViewCell: UITableViewCell {
//
//    static let reuseId = "MenuTableViewCell"
//
//    let myLabel: UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Текст"
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textColor = .black
//        return label
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        addSubview(myLabel)
//        backgroundColor = .clear
//
//        myLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
