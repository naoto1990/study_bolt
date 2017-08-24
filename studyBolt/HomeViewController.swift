//
//  HomeViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/10.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift


class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var studySetsObject = List()
    
    let testCards = ["1", "2", "3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let studySets = realm.objects(StudySet.self)
        
        // demoデータの総数を返却
        return studySets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySetsCell") as! StudySetsCell
        
        let studySets = realm.objects(StudySet.self)
        
        let studySet = studySets[indexPath.row]
        cell.titleLabel.text = studySet.title
        cell.numOfCardsLabel.text = "23"
        cell.updateDateLabel.text = studySet.createdAt
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let studySets = realm.objects(StudySet.self)
                try! realm.write() {
                    realm.delete(studySets[indexPath.row])
                }
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            } catch {
                // TODO: 例外クラスを作成し、それを返却する必要あり
            }
            tableView.reloadData()
        }
    }

}
