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
    
    
    let numRow = 2
    let numCol = 10
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
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        
        let index = indexPath.section * numRow + indexPath.row
        print(theImageCache)
        if theData.count == 0{
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.hidesWhenStopped = true
            cell.backgroundView = spinner
            spinner.startAnimating()
        }
        else if(theData.count > index && theImageCache.count > index) {
//            print(index)
            let title = theData[index].title
            let image = theImageCache[index]
            print(title + " " + image.description)
            let wrapperFrame = CGRect(x: collectionView.frame.minX, y: collectionView.frame.minY, width: collectionView.frame.width, height: collectionView.frame.height)
            let wrapperView = UIView(frame: wrapperFrame)
            cell.backgroundView = wrapperView
            
            let imageFrame = CGRect(x: wrapperView.frame.minX, y: wrapperView.frame.minY, width: wrapperView.frame.width, height: wrapperView.frame.height)
            let imageView: UIImageView = UIImageView(image: image)
            imageView.frame = imageFrame
            wrapperView.addSubview(imageView)
            
           let titleHeight = CGFloat(40)
            let titleFrame = CGRect(x: imageFrame.minX, y: imageFrame.maxY - titleHeight, width: imageFrame.width, height: titleHeight)
            let movieTitle = UITextView(frame: titleFrame)
            movieTitle.text = title
            movieTitle.textColor = .white
            movieTitle.textAlignment = .center
            movieTitle.backgroundColor = .gray
            imageView.addSubview(movieTitle)
        }
        else{
            cell.backgroundView = nil
        }
    return cell
        
    }
    
    //send data to user
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        let index = indexPath.section * numRow + indexPath.row
        if(index >= theData.count){
            return
        }
        detailedVC.image = index < theData.count ? theImageCache[index] : nil
        detailedVC.imageName = index < theData.count ? theData[index].title : nil
        detailedVC.score = index < theData.count ? theData[index].vote_average : nil
        detailedVC.date = index < theData.count ? theData[index].release_date : nil
        detailedVC.numRate = index < theData.count ? theData[index].vote_count : nil
        detailedVC.id = index < theData.count ? theData[index].id : nil
        
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func setupCollectionView(){
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
    }
    
    func fetchMoviesForCollectionView(_ query: String) {
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/movie"
        let queryItem1 = URLQueryItem(name: "api_key", value: "2597d4a74591834f2d63dbe73d13d4fb")
        let queryItem2 = URLQueryItem(name: "query", value: query)
        let queryItem3 = URLQueryItem(name: "sort_by", value: "popularity.desc")
        let queryItem4 = URLQueryItem(name: "page", value: "1") // 2 3 for more movies


        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [queryItem1, queryItem2, queryItem3, queryItem4]

        if let url = urlComponents.url {
            print(url)
            do{
                theData = []
                let data = try Data(contentsOf: url)
                let tempData = try JSONDecoder().decode(APIResults.self, from:data)
                theData = tempData.results
            }
            catch{
                theData = []
                print("Data not found")
            }
        }
        

        
        
    }
   
    //detect change in search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
//        print(theImageCache)
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let query = movieQuery.text{
            clearImageAndData()
            DispatchQueue.global(qos: .userInitiated).async {
                self.fetchMoviesForCollectionView(query)
                self.cacheImages()
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                    print(self.theImageCache.count)
                }
            }
            
        }
    }
    
    func clearImageAndData(){
        theImageCache = []
        theData = []
        movieCollectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let url = URL(string: "https://image.tmdb.org/t/p/w500" + path)
//                print(url!)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                theImageCache.append(image!)
            }
            else{
                let notFound = UIImage(named : "img_not_found")!
                theImageCache.append(notFound)
            }
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    



}

