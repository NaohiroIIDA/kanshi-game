//
//  ViewController.swift
//  fon
//
//  Created by Naohiro Iida on 2017/04/27.
//  Copyright © 2017年 Naohiro Iida. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dataList:[String] = []
    var userPath:String!
    let fileManager = FileManager()
    
    
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
        
        readTextFile()
        
        print(self.delegate.result as Any)
   
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var resultData = self.delegate.result
        
        if( resultData == nil){
            resultData = 999
        }
        
        
        print("表示間データ: \(resultData)")
        
        gameResult = resultData!
        
        if gameResult == 999 {
            GameLabel.text = " "
        
        }else{
            GameLabel.text = String("記録　\(gameResult / 10)s")
        }
        
        ranking_data[5] = gameResult
        ranking_data.sort{ $0 < $1 }
        
        rankingLinst.reloadData()
        
        saveFile()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return ranking_array.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 50
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPcell", for: indexPath as IndexPath)
        
        let label1 = cell.viewWithTag(1) as! UILabel
        let label2 = cell.viewWithTag(2) as! UILabel
        
        label1.text = ranking_array[indexPath.row]
        label2.text = String("\(ranking_data[indexPath.row] / 10)s")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ranking_title[section]
    }
    
    func saveFile() {
        
        let textFileName = "ranking.txt"
       // let initialText = "999,999,999,999,999,999"
        
        let initialText = String(ranking_data[0]) + "," + String(ranking_data[1]) + "," + String(ranking_data[2]) + "," + String(ranking_data[3]) + "," + String(ranking_data[4]) + "," + String(ranking_data[5])
        
        if let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            
            let targetTextFilePath = documentDirectoryFileURL.appendingPathComponent(textFileName)
            
            print("書き込むファイルのパス: \(targetTextFilePath)")
            print("書き込むデータ: \(initialText)")
            
            do {
                try initialText.write(to: targetTextFilePath, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("failed to write: \(error)")
            }
        }
    }
    
    
    
    func readTextFile() {
        
        let textFileName = "ranking.txt"
        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let targetTextFilePath = documentDirectoryFileURL?.appendingPathComponent(textFileName)
        
        do {
            let saveData = try String(contentsOf: targetTextFilePath!, encoding: String.Encoding.utf8)
             print("読み込むデータ: \(saveData)")
            
            //カンマでデータを分割して配列に格納する。
            let loadDataCell = saveData.components(separatedBy: ",")
            
            ranking_data[0] = atof(loadDataCell[0])
            ranking_data[1] = atof(loadDataCell[1])
            ranking_data[2] = atof(loadDataCell[2])
            ranking_data[3] = atof(loadDataCell[3])
            ranking_data[4] = atof(loadDataCell[4])
            ranking_data[5] = atof(loadDataCell[5])
                        
            
        } catch let error as NSError {
            print("failed to read: \(error)")
        }
    }

    


}
