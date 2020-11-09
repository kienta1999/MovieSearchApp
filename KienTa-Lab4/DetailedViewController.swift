//
//  DetailedViewController.swift
//  InClassDemo2
//
//  Created by Todd Sproull on 6/25/20.
//  Copyright © 2020 Todd Sproull. All rights reserved.
//

import UIKit

//view detail of movies
class DetailedViewController: UIViewController {

    var image: UIImage!
    var imageName: String!
    var score: Double!
    var date: String!
    var numRate: Int!
    var id: Int!
    
    let key = "favouriteMovies"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        if(imageName == nil || score == nil || date == nil || image == nil || numRate == nil){
            navigationController?.popViewController(animated: false)
            return
        }
        let imageRatio = CGFloat(2)
        
        let theImageFrame = CGRect(x: view.frame.midX - image.size.width / imageRatio / 2 , y: 100, width: image.size.width / imageRatio, height: image.size.height / imageRatio)

        let imageView = UIImageView(frame: theImageFrame)
        imageView.image = image
        
        view.addSubview(imageView)
        
        
        let theTextFrame = CGRect(x: 0, y: image.size.height / imageRatio + 110, width: view.frame.width, height: 30)
        let textView = UILabel(frame: theTextFrame)
        textView.text = "Title: " + imageName
        textView.textAlignment = .center
        view.addSubview(textView)
        
        let theScoreFrame = CGRect(x: 0, y: image.size.height / imageRatio + 140, width: view.frame.width, height: 30)
        let scoreView = UILabel(frame: theScoreFrame)
        scoreView.text = "Score: " + String(score)
        scoreView.textAlignment = .center
        view.addSubview(scoreView)
        
        let theDateFrame = CGRect(x: 0, y: image.size.height / imageRatio + 170, width: view.frame.width, height: 30)
        let dateView = UILabel(frame: theDateFrame)
        dateView.text = "Date released: " + String(date)
        dateView.textAlignment = .center
        view.addSubview(dateView)
        
        let numRateFrame = CGRect(x: 0, y: image.size.height / imageRatio + 200, width: view.frame.width, height: 30)
        let numRateView = UILabel(frame: numRateFrame)
        numRateView.text = "Number of rating: " + String(numRate)
        numRateView.textAlignment = .center
        view.addSubview(numRateView)
        
        let addFavFrame = CGRect(x: view.frame.width / 4, y: image.size.height / imageRatio + 230, width: view.frame.width / 2, height: 30)
        let addFav = UIButton(frame: addFavFrame)
        addFav.backgroundColor = .yellow
        addFav.setTitle("Add to Favourite", for: .normal)
        addFav.setTitleColor(.black, for: .normal)
        addFav.addTarget(self, action: #selector(addFavClicked), for: .touchUpInside)

        view.addSubview(addFav)
    }
    
    @objc func addFavClicked(){
        print("fav clicked")
        
        if UserDefaults.standard.array(forKey: self.key) == nil{
            UserDefaults.standard.set([], forKey: self.key)
        }
        var favMoviesClone:[String] = UserDefaults.standard.array(forKey: self.key)! as? [String] ?? []
        if(favMoviesClone.contains(self.imageName!)){
//            print("duplicate!")
//            print(favMoviesClone)
            return
        }
        favMoviesClone.append(self.imageName!)
        UserDefaults.standard.set(favMoviesClone, forKey: self.key)
//        print(favMoviesClone)
        
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
