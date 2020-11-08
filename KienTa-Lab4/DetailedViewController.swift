//
//  DetailedViewController.swift
//  InClassDemo2
//
//  Created by Todd Sproull on 6/25/20.
//  Copyright © 2020 Todd Sproull. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var image: UIImage!
    var imageName: String!
    var score: Double!
    var date: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        let theImageFrame = CGRect(x: view.frame.midX - image.size.width/1.5 / 2, y: 100, width: image.size.width / 1.5, height: image.size.height / 1.5)

        let imageView = UIImageView(frame: theImageFrame)
        imageView.image = image
        
        view.addSubview(imageView)
        
        
        let theTextFrame = CGRect(x: 0, y: image.size.height / 1.5 + 110, width: view.frame.width, height: 30)
        let textView = UILabel(frame: theTextFrame)
        textView.text = "Title: " + imageName
        textView.textAlignment = .center
        view.addSubview(textView)
        
        let theScoreFrame = CGRect(x: 0, y: image.size.height / 1.5 + 140, width: view.frame.width, height: 30)
        let scoreView = UILabel(frame: theScoreFrame)
        scoreView.text = "Score: " + String(score)
        scoreView.textAlignment = .center
        view.addSubview(scoreView)
        
        let theDateFrame = CGRect(x: 0, y: image.size.height / 1.5 + 170, width: view.frame.width, height: 30)
        let dateView = UILabel(frame: theDateFrame)
        dateView.text = "Date released: " + String(date)
        dateView.textAlignment = .center
        view.addSubview(dateView)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
