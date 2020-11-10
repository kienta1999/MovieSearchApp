//
//  FavViewController.swift
//  KienTa-Lab4
//
//  Created by Kien Ta on 11/9/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let keyMovies = "favouriteMovies"
    let keyID = "favouriteID"
    var movie: ViewController.Movie!
    var image: UIImage!
    
    
    var favMoviesClone:[String]! {
        didSet{
            favouriteMoviesTable.reloadData()
        }
    }
    var favIDClone:[Int]!
    
    @IBOutlet weak var favouriteMoviesTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMoviesClone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        
        
        myCell.textLabel!.text = favMoviesClone[indexPath.row]
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        let index = indexPath.row
        fetchData(index)
//        print(index)
         detailedVC.imageName = favMoviesClone[index]
        detailedVC.id = favIDClone![index]
        if(movie == nil){
            detailedVC.image = UIImage(named: "img_not_found")
            detailedVC.score = 0
            detailedVC.date = ""
            detailedVC.numRate = 0
        }
        else{
            detailedVC.image = getImage(movie.poster_path!)
            detailedVC.score = movie.vote_average
            detailedVC.date = movie.release_date
            detailedVC.numRate = movie.vote_count
        }
        
       
        
        

        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let title = tableView.cellForRow(at: indexPath)?.textLabel!.text
            for i in 0 ..< self.favMoviesClone.count {
                if(self.favMoviesClone[i] == title){
                    self.favMoviesClone.remove(at: i)
                    self.favIDClone.remove(at: i)
                    UserDefaults.standard.set(favMoviesClone!, forKey: self.keyMovies)
                    UserDefaults.standard.set(favIDClone!, forKey: self.keyID)
                    break
                }
            }
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func fetchData(_ index: Int){
        do{
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(favIDClone[index])?api_key=2597d4a74591834f2d63dbe73d13d4fb")
            let data = try Data(contentsOf: url!)
            movie = try JSONDecoder().decode(ViewController.Movie.self, from:data)
        }
        catch{
            print("id not found")
        }
        
    }
    
    func getImage(_ path: String) -> UIImage{
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + path)
        let data = try? Data(contentsOf: url!)
        if(data == nil){
            return UIImage(named: "img_not_found")!
        }
        image = UIImage(data: data!)
        return image
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.array(forKey: self.keyMovies) == nil{
            UserDefaults.standard.set([], forKey: self.keyMovies)
        }
        if UserDefaults.standard.array(forKey: self.keyID) == nil{
            UserDefaults.standard.set([], forKey: self.keyID)
        }
        favMoviesClone = UserDefaults.standard.array(forKey: "favouriteMovies")! as? [String] ?? []
        favIDClone = UserDefaults.standard.array(forKey: "favouriteID")! as? [Int] ?? []
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        favouriteMoviesTable.register(UITableViewCell.self, forCellReuseIdentifier: "theCell")
        favouriteMoviesTable.dataSource = self
        favouriteMoviesTable.delegate = self

        // Do any additional setup after loading the view.
        
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
