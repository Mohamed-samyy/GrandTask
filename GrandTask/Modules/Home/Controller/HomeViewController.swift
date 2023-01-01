//
//  ViewController.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView!
    
    var newsData = HomeData()
    var pageNum = 1
    var isLoadMore : Bool = false
    var searchActive = true

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Home"
        newsTableView.estimatedRowHeight = 70
        newsTableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        isLoadMore = false
        pageNum = 1
        getNewsWithPaggination()
        getAllNews(searchText: "")
    }
    func getNewsWithPaggination(){
        newsTableView.addInfiniteScroll { (tableView) -> Void in
            if self.isLoadMore{
                if self.pageNum != 0{
                    self.isLoadMore = true
                    self.getAllNews(searchText: self.searchBar.text ?? "")
                }
            }
            self.newsTableView.finishInfiniteScroll()
        }
    }
}
extension HomeViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.isLoadMore = false
        self.pageNum = 1
        if searchBar.text != ""{
            getAllNews(searchText: searchBar.text!)
        }else{
            getAllNews(searchText: "")
        }
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  //      getAllNews(searchText: searchText)
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.setUpCell(data: (newsData.articles?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isLoadMore = false
        self.pageNum = 1
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        detailsVC.newData = (newsData.articles?[indexPath.row])!
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension HomeViewController: HomeAPIsProtocol{
    
    func getAllNews(searchText: String) {
        self.showSpinner(onView: self.view)
        let homeNewsObject = HomeAPIs()
        homeNewsObject.homeDelegate = self
        if searchBar.text == ""{
            homeNewsObject.getNewsApis(pageNumber: pageNum, searchText: "news")
        }else{
            homeNewsObject.getNewsApis(pageNumber: pageNum, searchText: searchText)
        }

    }
    func APi_Success(response: HomeData) {
        self.removeSpinner()
        if response.status != "error"{
            if isLoadMore {
                self.newsData.articles?.append(contentsOf: (response.articles)!)
            }else{
                self.newsData.articles?.removeAll()
                newsData = response
                isLoadMore = true
            }
            self.isLoadMore =  self.pageNum < 6
            self.pageNum += 1
        
        newsTableView.reloadData()
        }else{
            Alert.show(message: response.message ?? "Error")
        }
    }
    
    func APi_Failed(errorMessage: String) {
        self.removeSpinner()
        Alert.show(message: errorMessage)
    }
    
}
