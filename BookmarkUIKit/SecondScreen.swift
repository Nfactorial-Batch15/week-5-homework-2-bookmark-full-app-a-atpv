//
//  SecondScreen.swift
//  BookmarkUIKit
//
//  Created by Алдияр Айтпаев on 18.01.2022.
//

import UIKit
import SnapKit


class SecondScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var links: [LinkModel] = Storage.linkModels {
        didSet {
            if links.count > 0 {
                checkLinks()
            }
            if links.count == 0 {
                checkLinks()
            }
        }
    }
    
    var bookmarkAppLabel: UILabel = {
        let textView = UILabel()
        textView.text = "Bookmark App"
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 17, weight: .semibold)
        textView.isHidden = false
        return textView
    }()
    
    var linkLabel: UILabel = {
        let textView = UILabel()
        textView.text = "Link"
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 17, weight: .semibold)
        textView.isHidden = true
        return textView
    }()
    
    var mainText: UILabel = {
        let textView2 = UILabel()
        textView2.text = "Save your first bookmark"
        textView2.textColor = .black
        textView2.textAlignment = .center
        textView2.font = .systemFont(ofSize: 36, weight: .bold)
        textView2.numberOfLines = 0
        return textView2
    }()

    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)


        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .white
        
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        checkLinks()
        
        
        view.backgroundColor = .white

        view.addSubview(bookmarkAppLabel)
        bookmarkAppLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        view.addSubview(linkLabel)
        linkLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(mainText)
        mainText.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.width.equalTo(390)
            make.height.equalTo(650)
            make.top.equalTo(view).offset(88)
            make.centerX.equalTo(view)
        }

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(58)
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
            cell.configure(model: links[indexPath.row])
        
//        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            if editingStyle == .delete {

                // remove the item from the data model
                links.remove(at: indexPath.row)
                removeLinkFromArray(index: indexPath.row)
                
                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
    
    
    
    
    @objc func buttonAction(sender: UIButton!) {
        let alert = UIAlertController(title: "Change", message: .none , preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Bookmark title"
            field.returnKeyType = .next
        }
        
        alert.addTextField { field in
            field.placeholder = "Bookmark link"
            field.returnKeyType = .continue
            field.keyboardType = .URL
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 2 else {
                return
            }
            
            let titleField = fields[0]
            let linkFields = fields[1]
            
            guard let title = titleField.text, !title.isEmpty,
                  let link = linkFields.text, !link.isEmpty else {
                      print("Invalid values")
                      return
                  }
            self.addNewLinkToArray(title: title, link: link)
                    
            
        }))
        
        present(alert, animated: true)
        
    }
    
    private func addNewLinkToArray(title: String, link: String) {
        self.links.append(LinkModel(title: title, link: link))
        Storage.linkModels.append(LinkModel(title: title, link: link))
        self.tableView.reloadData()
        
        checkLinks()
    }
    
    private func removeLinkFromArray(index: Int) {
//        self.links.remove(at: index)
        Storage.linkModels.remove(at: index)
//        self.tableView.reloadData()
        
        
    }
    
    
    
    private func checkLinks(){
        if links.isEmpty {
            tableView.isHidden = true
            bookmarkAppLabel.isHidden = false
            linkLabel.isHidden = true
        } else {
            tableView.isHidden = false
            bookmarkAppLabel.isHidden = true
            linkLabel.isHidden = false
        }
    }
}
        
