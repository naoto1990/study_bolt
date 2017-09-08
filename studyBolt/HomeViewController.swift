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
    
    var studySetCollection: Results<StudySet>!
    var cardCollection: Results<Card>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchStudySets()
        print(cardCollection)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func fetchStudySets() {
        do{
            studySetCollection = realm.objects(StudySet.self)
            tableView.reloadData()
            
            cardCollection = realm.objects(Card.self)
        }catch{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toStudySet") {
            let studySetViewController = segue.destination as! StudySetViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow
            
            if let indexPath = indexPath {
                studySetViewController.selectedStudySet = studySetCollection?[(indexPath[1])]
            }
            
        }
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
        
        let studySet = studySetCollection[indexPath.row]
        // TODO: 各studySet毎に所属するカードを検索して表示するのが処理速度的に問題ないか検討する必要あり
        // studySet自体のプロパティにカードを配列として持たせれば検索処理自体を省ける
        let cards = realm.objects(Card.self).filter("studySetID = %@", studySet.studySetID)
        
        cell.titleLabel.text = studySet.title
        cell.numOfCardsLabel.text = String(cards.count)
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
                let studySet = studySetCollection[indexPath.row]
                
                let cards = realm.objects(Card.self).filter("studySetID = %@", studySet.studySetID)

                try! realm.write() {
                    realm.delete(studySet)
                    realm.delete(cards)
                }
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            } catch {
                // TODO: 例外クラスを作成し、それを返却する必要あり
            }
            tableView.reloadData()
        }
    }

}
