//
//  GameViewController.swift
//  fon
//
//  Created by Naohiro Iida on 2017/04/27.
//  Copyright © 2017年 Naohiro Iida. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var playTime:Double = 0
    var gameCount:Int = 8
    var onoffFlug:Bool = false
    
    
    var timer: Timer!

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var StopWatch: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    @IBAction func startButtonPush(_ sender: Any) {
        if onoffFlug == true {
            onoffFlug = false
        }else{
            onoffFlug = true
            playTime = 0
            gameCount = 8
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
        
        playTime = 0
        gameCount = 8
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer.invalidate()
    }
    
    func update(tm: Timer) {
        
        if onoffFlug == true {

            playTime += 0.1
        }
        
        StopWatch.text = String("\(playTime)")
        numLabel.text = "あと" + String(gameCount)+"個"
        // do something
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
