//
//  HeadLinesViewController.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit

class HeadLinesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var newsData = HomeData()
    var pageNum = 1
    var isLoadMore : Bool = false
    var searchActive = true

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "HeadLines"

    }

    override func viewWillAppear(_ animated: Bool) {
        isLoadMore = false
        pageNum = 1
        getNewsWithPaggination()
        getHeadLinesData(searchText: "")
    }
    func getNewsWithPaggination(){
        newsCollectionView.addInfiniteScroll { (collectionView) -> Void in
            if self.isLoadMore{
                if self.pageNum != 0{
                    self.isLoadMore = true
                    self.getHeadLinesData(searchText: self.searchBar.text ?? "")
                }
            }
            self.newsCollectionView.finishInfiniteScroll()
        }
    }
}
extension HeadLinesViewController: UISearchBarDelegate{
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
            getHeadLinesData(searchText: searchBar.text!)
        }else{
            getHeadLinesData(searchText: "")
        }
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  //      getAllNews(searchText: searchText)
    }
}



extension HeadLinesViewController: HeadLinesAPIsProtocol{
    
    func getHeadLinesData(searchText: String) {
        self.showSpinner(onView: self.view)
        let headLinesObject = HeadLinesAPIs()
        headLinesObject.headLinesDelegate = self
        if searchBar.text == ""{
            headLinesObject.getHeadLinesApis(pageNumber: pageNum, searchText: "news")
        }else{
            headLinesObject.getHeadLinesApis(pageNumber: pageNum, searchText: searchText)
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
        
            newsCollectionView.reloadData()
        }else{
            Alert.show(message: response.message ?? "Error")
        }
    }
    
    func APi_Failed(errorMessage: String) {
        self.removeSpinner()
        Alert.show(message: errorMessage)
    }
    
}

extension HeadLinesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsData.articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadLinesCollectionViewCell", for: indexPath) as! HeadLinesCollectionViewCell
        cell.setUpView(data: (newsData.articles?[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let webViewVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        
        webViewVC.newURL = newsData.articles?[indexPath.row].url ?? ""
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let headLinesCollectionsize = newsCollectionView.frame.size

        return CGSize(width: headLinesCollectionsize.width - 20, height: 234)
    }
    
}
