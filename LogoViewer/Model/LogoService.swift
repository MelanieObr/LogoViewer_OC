//
//  LogoService.swift
//  LogoViewer
//
//  Created by Mélanie Obringer on 30/08/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class LogoService {
    // create singleton patternstatic let shared = LogoService()
    static var shared = LogoService()
    private init() {}
    
    private var logoSession = URLSession(configuration: .default)
    init(logoSession: URLSession) {
        self.logoSession = logoSession
    }
    
    private var task: URLSessionTask?
    private let logoUrl = "https://logo.clearbit.com/"
    
    func getLogo(domain: String, callback: @escaping (Bool, Logo?) -> Void) {
        let completeUrl = "\(logoUrl)\(domain)?size=400"
        let request = URLRequest(url: URL(string: completeUrl)!)
        task?.cancel()
        task = logoSession.dataTask(with: request, completionHandler: { (data, response, error) in
            // manage multi-threading with DispatchQueue
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }
                callback(true, Logo(imageData: data))
            }
        })
        task?.resume()
    }
}


