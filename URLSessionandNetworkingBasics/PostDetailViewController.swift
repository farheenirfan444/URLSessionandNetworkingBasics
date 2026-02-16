//
//  PostDetailViewController.swift
//  URLSessionandNetworkingBasics
//
//  Created by Faheem Irfan on 16/02/2026.
//

import UIKit

class PostDetailViewController: UIViewController {
    var post: PostModel?
    
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyLabel.text = post?.body
        titleLabel.text = post?.title
    }
}

