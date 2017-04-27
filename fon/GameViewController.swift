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
    
    var rects: [CGRect]?
    
    var timer: Timer!
    
    var ap_x:Int = 0
    var ap_y:Int = 0
    var bp_x:Int = 0
    var bp_y:Int = 0
    
    
    var old_ap_x:Int = 0
    var old_ap_y:Int = 0
    var old_bp_x:Int = 0
    var old_bp_y:Int = 0
    
    let ol1 = CAShapeLayer()
    let ol2 = CAShapeLayer()
    let ol3 = CAShapeLayer()
    let ol4 = CAShapeLayer()
    

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var StopWatch: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var gameScreen: UIImageView!
    
    @IBAction func startButtonPush(_ sender: Any) {
        if onoffFlug == true {
            onoffFlug = false
        }else{
            onoffFlug = true
            playTime = 0
            gameCount = 8
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let topSc = segue.destination as! ViewController
        topSc.gameResult = playTime
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.layer.addSublayer(ol1)
        self.view.layer.addSublayer(ol2)
        self.view.layer.addSublayer(ol3)
        self.view.layer.addSublayer(ol4)
        
        
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

            playTime += 1
        }
        
        StopWatch.text = String("\(playTime / 10)")
        numLabel.text = "あと" + String(gameCount)+"個"
        // do something
    }
    
    @IBAction func TouchEvent(_ sender: UIPinchGestureRecognizer) {
   
        if sender.numberOfTouches >= 2 {
            
        
        let AP:CGPoint =  sender.location(ofTouch: 0, in: gameScreen)
        let BP:CGPoint =  sender.location(ofTouch: 1, in: gameScreen)
    
            old_ap_x = ap_x
            old_ap_y = ap_y
            old_bp_x = bp_x
            old_bp_y = bp_y
        
        ap_x = Int(AP.x) - 25
        ap_y = Int(AP.y) - 25
        bp_x = Int(BP.x) - 25
        bp_y = Int(BP.y) - 25
        
        
        
        
        ol1.strokeColor = UIColor.black.cgColor  // 輪郭
        ol2.strokeColor = UIColor.black.cgColor  // 輪郭
        ol3.strokeColor = UIColor.blue.cgColor  // 輪郭
        ol4.strokeColor = UIColor.blue.cgColor  // 輪郭
        
        ol1.fillColor = UIColor.black.cgColor  // 塗り
        ol2.fillColor = UIColor.black.cgColor  // 塗り
        ol3.fillColor = UIColor.blue.cgColor  // 塗り
        ol4.fillColor = UIColor.blue.cgColor  // 塗り
        
        ol1.lineWidth = 2.0
        ol2.lineWidth = 2.0
        ol3.lineWidth = 2.0
        ol4.lineWidth = 2.0
        
        
        ol1.path = UIBezierPath(ovalIn: CGRect(x:old_ap_x, y:old_ap_y, width:50, height:50)).cgPath
        ol2.path = UIBezierPath(ovalIn: CGRect(x:old_bp_x, y:old_bp_y, width:50, height:50)).cgPath
        ol3.path = UIBezierPath(ovalIn: CGRect(x:ap_x, y:ap_y, width:50, height:50)).cgPath
        ol4.path = UIBezierPath(ovalIn: CGRect(x:bp_x, y:bp_y, width:50, height:50)).cgPath
        
        self.view.layer.display()
        
        }
        
        
        
       // numLabel.text = NSString(format: "%.2f", AP.x) as String
       // numLabel.text = NSString(format: "%.2f", BP.x) as String
    
        
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
