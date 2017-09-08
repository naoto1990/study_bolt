//
//  studySetViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/09/08.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class StudySetViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalCardLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var selectedStudySet: StudySet?
    var cardsInselectedStudySet: Results<Card>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        fetchCardData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayStudySetInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Tabバーのボタンを非表示
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        hidesBottomBarWhenPushed = true
    }
    
    func fetchCardData() {
        if let selectedStudySet = selectedStudySet {
            cardsInselectedStudySet = realm.objects(Card.self).filter("studySetID = %@", selectedStudySet.studySetID)
        }
        
    }
    
    func displayStudySetInfo() {
        titleLabel.text = selectedStudySet?.title
        
        totalCardLabel.text = String(cardsInselectedStudySet.count)
        
    }

}


extension StudySetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cardsInselectedStudySet.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardsCell") as! CardCellInStudySet
        
        cell.termInStudySet.text = cardsInselectedStudySet[indexPath.row].term
        cell.definitionInStudySet.text = cardsInselectedStudySet[indexPath.row].definition
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

}


extension StudySetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let card = cardsInselectedStudySet[indexPath.row]
                
                try! realm.write() {
                    realm.delete(card)
                }
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            } catch {
                // TODO: 例外クラスを作成し、それを返却する必要あり
            }
            
            tableView.reloadData()
            fetchCardData()
            displayStudySetInfo()

        }
    }
}
