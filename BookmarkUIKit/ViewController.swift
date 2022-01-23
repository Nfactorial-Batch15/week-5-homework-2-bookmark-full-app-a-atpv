//
//  ViewController.swift
//  BookmarkUIKit
//
//  Created by Алдияр Айтпаев on 20.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var nextView = SecondScreen()
    
    var mainText: UILabel = {
        let textView2 = UILabel()
        textView2.text = "Save all interesting links in one app"
        textView2.textColor = .white
        textView2.font = .systemFont(ofSize: 36, weight: .bold)
        textView2.numberOfLines = 0
        return textView2
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        return imageView
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)


        return button
    }()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .black
            
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview()
            }
            view.addSubview(mainText)
            mainText.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp_bottomMargin)
                make.trailing.equalToSuperview().offset(-16)
                make.leading.equalToSuperview().offset(16)
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
    
    @objc private func buttonDidPress() {
        print("Button was pressed!")
        nextView.modalPresentationStyle = .fullScreen
        Storage.showOnboarding = false
        
        navigationController?.present(nextView, animated: true, completion: {
            
            
        })
    }

}
