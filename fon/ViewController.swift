//
//  ViewController.swift
//  fon
//
//  Created by Naohiro Iida on 2017/04/27.
//  Copyright © 2017年 Naohiro Iida. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var ranking_title:[String] = ["ランキング"]
    var ranking_array:[String] = ["１位","２位","３位","４位","５位"]
    var ranking_data:[Double] = [999,999,999,999,999,999]
    
    
    var gameResult:Double = 999
    
    
    @IBOutlet weak var GameLabel: UILabel!
    @IBOutlet weak var rankingLinst: UITableView!
    @IBAction func returnTop(segue:UIStoryboardSegue){
        
    }

    @IBAction func resetRanking(_ sender: Any) {
        
        ranking_data[0] = 999
        ranking_data[1] = 999
        ranking_data[2] = 999
        ranking_data[3] = 999
        ranking_data[4] = 999
        ranking_data[5] = 999
        ranking_data.sort{ $0 < $1 }
        rankingLinst.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if gameResult == 999 {
            GameLabel.text = "0"
        
        }else{
            GameLabel.text = String("\(gameResult / 10)")
        }
        
        ranking_data[5] = gameResult
        ranking_data.sort{ $0 < $1 }
        
        rankingLinst.reloadData()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    //return ranking_array.count
    return 5 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 50
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPcell", for: indexPath as IndexPath)
        
        let label1 = cell.viewWithTag(1) as! UILabel
        let label2 = cell.viewWithTag(2) as! UILabel
        
        label1.text = ranking_array[indexPath.row]
        label2.text = String("\(ranking_data[indexPath.row] / 10)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ranking_title[section]
    }
    
    
}

