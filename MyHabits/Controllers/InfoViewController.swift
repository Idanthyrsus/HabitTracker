//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Alexander Korchak on 25.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var paragraphStyle: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 0
        return paragraph
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")
        self.navigationItem.title = "Информация"
       
        
        let firstString = NSAttributedString(string: "Привычка за 21 день\n\n", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20, weight: .semibold), NSAttributedString.Key.paragraphStyle: paragraphStyle])

        
        let secondString = NSAttributedString(string: "Привычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21Привычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21Привычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21 день\n\nПривычка за 21", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
      
        let result = NSMutableAttributedString()
        result.append(firstString)
        result.append(secondString)
        
    
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.attributedText = result
            textView.textAlignment = .left
            self.view.addSubview(textView)
        
        textView.textContainerInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
        
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            
        ])
       
    }


}
