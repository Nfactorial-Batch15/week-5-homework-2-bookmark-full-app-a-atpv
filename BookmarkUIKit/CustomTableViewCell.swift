//
//  CustomTableViewCell.swift
//  BookmarkUIKit
//
//  Created by Алдияр Айтпаев on 20.01.2022.
//

import UIKit
import SnapKit
import SafariServices


class CustomTableViewCell: UITableViewCell {
    
    private let customView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let linkImage: UIImageView = {
        let linkImage = UIImageView()
        linkImage.isUserInteractionEnabled = true
        linkImage.image = UIImage(named: "link")
        return linkImage
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    func configure(model: LinkModel) {
        self.title.text = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(linkImage)
        linkImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
//        linkImage.addGestureRecognizer(UITapGestureRecognizer(target:self,action:
//        #selector(linkTapped)))
        
    }
//    @objc func linkTapped {
//        print("Hello")
//    }
    

}
