//
//  ArticlesListViewController.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    @IBOutlet var articlesListView: ArticlesListView!
    
    var viewModel: ArticlesListViewModel
    
    init?(coder: NSCoder, viewModel: ArticlesListViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:image:)` to initialize an `ImageViewController` instance.")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesListView.tableview.dataSource = self
        viewModel.fetchArtciles { articles in
            print("Success")
        }
    }
    
}

extension ArticlesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListTableViewCell", for: indexPath) as! ArticleListTableViewCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
