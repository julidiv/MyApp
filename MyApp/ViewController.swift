//
//  ViewController.swift
//  MyApp
//
//  Created by Alexander Golub on 9.08.22.
//

import UIKit

enum TwoButton: String {
    case education = "https://resheto.net/images/mater/kartinka_motivatsiya_tsitata_9.jpg"
    case educacionUrl = "https://github.com/public-apis/public-apis.git"
    
}
class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var userReady: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func getReadyButton(_ sender: UIButton) {
        guard let url = URL(string: TwoButton.educacionUrl.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let educate = try JSONDecoder().decode(Education.self, from: data)
                print(educate)
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
    private func fethcImage() {
        
        guard let url = URL(string: TwoButton.education.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data, let _ = response else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
            
        }.resume()
    }
    
}

