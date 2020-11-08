//
//  ViewController.swift
//  KienTa-Lab4
//
//  Created by Kien Ta on 11/8/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    struct APIResults:Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Movie]
    }
    
    struct Movie: Decodable {
        let id: Int!
        let poster_path: String?
        let title: String
        let release_date: String
        let vote_average: Double
        let overview: String
        let vote_count:Int!
    }

    var theData: [Movie] = []
    var theImageCache: [UIImage] = []
    
    let numRow = 3
    let numCol = 7

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    
    @IBOutlet weak var movieQuery: UISearchBar!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width / CGFloat(numRow) - 10, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numRow;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numCol;
    }
    
    func createMovieView(_ collectionView: UICollectionView, _ title: String, _ image: UIImage) -> UIImageView{
        let movieViewFrame = CGRect.init(x: collectionView.frame.minX, y: collectionView.frame.minY, width: image.accessibilityFrame.width, height: image.accessibilityFrame.height)
        let imageView: UIImageView = UIImageView(image: image)
        imageView.frame = movieViewFrame
        return imageView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        
        let index = indexPath.section * numRow + indexPath.row
        if(theData.count > index) {
//            print(index)
            let title = theData[index].title
            let image = theImageCache[index]
            cell.backgroundView = createMovieView(collectionView, title, image)
        }
        
        
//        if(index % 2 == 1){
//            cell.backgroundColor = UIColor.blue
//        } else {
//            cell.backgroundColor = UIColor.red
//        }
        /*
         let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
               cell.textLabel!.text = theData[indexPath.row].name
               cell.imageView?.image = theImageCache[indexPath.row]
               
               return cell
         */
        
        return cell
        
    }
    
    func setupCollectionView(){
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
    }
    
    func fetchMoviesForCollectionView(_ query: String) {
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=2597d4a74591834f2d63dbe73d13d4fb&query=" + query)
        do{
            let data = try Data(contentsOf: url!)
            let tempData = try JSONDecoder().decode(APIResults.self, from:data)
            theData = tempData.results
//            print("the data is \(String(describing: theData))")
            for i in 0..<theData.count{
                if i == theData.count{
                    break
                }
//                print(String(i) + " " + String(theData.count))
                let data = theData[i]
                if data.poster_path == nil{
                    theData.remove(at: i)
                }
            }
        }
        catch{
            theData = []
            print("Data not found")
        }
        
        
    }
   
    //detect change in search bar
    var query: String?
    var timer = Timer()
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if let query = searchBar.text{
//                    print(query)
                    fetchMoviesForCollectionView(query)
                    movieCollectionView.reloadData()
                    cacheImages()
                }
//        print(theImageCache)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        movieQuery.delegate = self
        
    }
    
    func cacheImages() {
          //URL
          //Data
          //UIImage
        theImageCache = []
//        print(theData)
        for item in theData {
            if let path = item.poster_path{
                let url = URL(string: "https://image.tmdb.org/t/p/w1280" + path)
//                print(url!)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                theImageCache.append(image!)
            }
            
        }
    }


}

