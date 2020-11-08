//
//  FavViewController.swift
//  KienTa-Lab4
//
//  Created by Kien Ta on 11/9/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let key = "favouriteMovies"
    var favMoviesClone:[String] = UserDefaults.standard.array(forKey: "favouriteMovies")! as? [String] ?? []{
        didSet{
            favouriteMoviesTable.reloadData()
        }
    }
    
    
    @IBOutlet weak var favouriteMoviesTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMoviesClone.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "theCell")! as UITableViewCell
        
        
        myCell.textLabel!.text = favMoviesClone[indexPath.row]
        
        return myCell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        favMoviesClone = UserDefaults.standard.array(forKey: "favouriteMovies")! as? [String] ?? []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouriteMoviesTable.register(UITableViewCell.self, forCellReuseIdentifier: "theCell")
        favouriteMoviesTable.dataSource = self

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
