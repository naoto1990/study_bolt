//
//  HomeViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/10.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import Foundation


class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let testCards = ["1", "2", "3"]
    var testDecks: Any?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let unwrappedTestDecks = jsonLoad() {
            testDecks = unwrappedTestDecks
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func jsonLoad () -> Optional<Any> {
        var decks: Any? = nil
        
        let path = Bundle.main.url(forResource: "testDeck", withExtension: "json")
        do {
            if path != nil {
                let data = try Data(contentsOf: path!)
                decks = try JSONSerialization.jsonObject(with: data, options: [])
                
            } else {
                print("file not found")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return decks
    }

    

}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySetsCell") as! StudySetsCell
        
        cell.titleLabel.text = "テスト"
        cell.numOfCardsLabel.text = "23"
        cell.updateDateLabel.text = "08/18/2017"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
