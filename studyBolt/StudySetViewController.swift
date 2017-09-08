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
    
    var selectedStudySet: StudySet?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayStudySetInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func displayStudySetInfo() {
        titleLabel.text = selectedStudySet?.title
        let cards = realm.objects(Card.self).filter("studySetID = %@", selectedStudySet?.studySetID)
        
        totalCardLabel.text = String(cards.count)
    }
    

}


extension StudySetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cards = realm.objects(Card.self).filter("studySetID = %@", selectedStudySet?.studySetID)
        
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardsCell") as! CardCellInStudySet
        
        let cards = realm.objects(Card.self).filter("studySetID = %@", selectedStudySet?.studySetID)
        print("kkkkkkk")
        
        cell.termInStudySet.text = cards[indexPath.row].term
        cell.definitionInStudySet.text = cards[indexPath.row].definition
        
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
}
