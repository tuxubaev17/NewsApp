//
//  TableViewController.swift
//  NewsApp
//
//  Created by Alikhan Tuxubayev on 26.05.2021.
//

import UIKit

class TableViewController: UITableViewController {

    private var viewModel = [NewsTableViewCellViewModel]()
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
                self.viewModel = articles.compactMap(){ NewsTableViewCellViewModel(title: $0.title, imgUrl: URL(string: $0.urlToImage ?? "")) }
                self.tableView.reloadData()
            }
        }

    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else{  fatalError() }
        
        cell.configure(with: viewModel[indexPath.row])
        
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
