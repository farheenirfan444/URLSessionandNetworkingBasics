//
//  PostViewModel.swift
//  URLSessionandNetworkingBasics
//
//  Created by Faheem Irfan on 16/02/2026.
//

import Foundation

class PostViewModel {
    var posts = [PostModel]()
    var onWeatherUpdate: (()->Void)?
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else { return }
        
        let session: Void = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
            else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                //print(jsonRes ?? "No json response")
                let jsonString = String(data: data!, encoding: .utf8)
                //print("Response is \(jsonString ?? "No json response")" )
                guard let res = try? JSONDecoder().decode([PostModel].self, from: data!)
                else {
                    print("can not decode.")
                    return
                }
                self.posts = res
                DispatchQueue.main.async {
                    self.onWeatherUpdate?()
                }
            }
        }.resume()
 }
    func createPost(params: [String: String]) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else { return }
       var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session: Void = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                //print("Response is \(jsonRes ?? "No json response")" )
            }
        }.resume()
        
    }
}

