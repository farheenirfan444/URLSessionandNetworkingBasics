//
//  ViewController.swift
//  URLSessionandNetworkingBasics
//
//  Created by Faheem Irfan on 16/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    
    let postData = PostViewModel()
    var allPosts = [PostModel]()

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var downloadImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //progressBar.progress = 0.0
//        let params = ["title": "I am example",
//                      "body":  "I am an example body"]
        postData.onWeatherUpdate = { [weak self] in
            guard let self = self else { return }
            self.allPosts = self.postData.posts
            self.tableView.reloadData()

        }
        
        postData.getPosts()
       
        
        //postData.createPost(params: params)
       
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCellTableViewCell
        let post = allPosts[indexPath.row]
        cell.bodyLabel.text = post.body
        cell.titleLabel.text = post.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = allPosts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as? PostDetailViewController
        else {
            return
        }
        detailVC.post = selectedPost
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//extension ViewController: URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        guard let data = try? Data(contentsOf: location)
//        else {
//            print("Data can not be loaded")
//            return
//        }
//        let image = UIImage(data: data)
//        downloadImage.image = image
//    }
//    
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        let progress = ( Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) )
//        print(progress)
//        progressBar.progress = progress
//    }
//    
//    
//}




// ------ the code to download image -----
//    @IBAction func downLoadButtonClicked(_ sender: Any) {
//        let urlString = "https://www.shutterstock.com/image-photo/sun-sets-behind-mountain-ranges-600nw-2479236003.jpg"
//        guard let url = URL(string: urlString) else { return }
//        let session = URLSession(configuration: .default, delegate: self , delegateQueue: .main )
//        session.downloadTask(with: url).resume()
//
//        URLSession.shared.downloadTask(with: url) {
//            fileURL, response, error in
//            if let error = error {
//                print("The error is \(error.localizedDescription)")
//            }
//            else {
//                print("The URL to dowloaded file is \(fileURL)")
//            }
//        }.resume()
