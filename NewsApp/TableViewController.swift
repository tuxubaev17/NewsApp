//
//  TableViewController.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 26.05.2021.
//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func refreshAction(_ sender: Any) {
        newsLoad {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsLoad {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOneNews", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOneNews" {
            if let indexPath = tableView.indexPathForSelectedRow {
            (segue.destination as? DetailNewsController)?.article = articles[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            }
        }

    }

}
