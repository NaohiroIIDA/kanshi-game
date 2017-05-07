//
//  GameViewController.swift
//  fon
//
//  Created by Naohiro Iida on 2017/04/27.
//  Copyright © 2017年 Naohiro Iida. All rights reserved.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController{

    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
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
    
    var ag_x:Int = 0
    var ag_y:Int = 0
    var bg_x:Int = 0
    var bg_y:Int = 0
    
    let shld:Double = 25
    
    let ol1 = CAShapeLayer()
    let ol2 = CAShapeLayer()
    let ol3 = CAShapeLayer()
    let ol4 = CAShapeLayer()
    
    let rect1 = CAShapeLayer()
    let rect2 = CAShapeLayer()
    
    var no = 0
    var touchPos :[CGPoint] = []
    

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var StopWatch: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var GameView: UIImageView!
    
    @IBAction func startButtonPush(_ sender: Any) {
        if onoffFlug == true {
            onoffFlug = false
        }else{
            onoffFlug = true
            playTime = 0
            gameCount = 8
           
            setGoal()
             drowRect()
            
           
            
        }
    }

    
    @IBAction func stopButtonPush(_ sender: Any) {
        
        self.delegate.result = 999
        // NavigationControllerを使ったページの遷移
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.layer.addSublayer(ol1)
        self.view.layer.addSublayer(ol2)
        self.view.layer.addSublayer(ol3)
        self.view.layer.addSublayer(ol4)
        
        self.view.layer.addSublayer(rect1)
        self.view.layer.addSublayer(rect2)
        
        
        ol1.strokeColor = UIColor.black.cgColor  // 輪郭
        ol2.strokeColor = UIColor.black.cgColor  // 輪郭
        ol3.strokeColor = UIColor.blue.cgColor  // 輪郭
        ol4.strokeColor = UIColor.blue.cgColor  // 輪郭
        rect1.strokeColor = UIColor.red.cgColor
        rect2.strokeColor = UIColor.red.cgColor
        
        
        ol1.fillColor = UIColor.black.cgColor  // 塗り
        ol2.fillColor = UIColor.black.cgColor  // 塗り
        ol3.fillColor = UIColor.blue.cgColor  // 塗り
        ol4.fillColor = UIColor.blue.cgColor  // 塗り
        
        rect1.fillColor = UIColor.clear.cgColor
        rect2.fillColor = UIColor.clear.cgColor

        
        
        ol1.lineWidth = 2.0
        ol2.lineWidth = 2.0
        ol3.lineWidth = 2.0
        ol4.lineWidth = 2.0
        
        rect1.lineWidth = 5.0
        rect2.lineWidth = 5.0
        
       GameView.isMultipleTouchEnabled = true
       // gameScreen.isUserInteractionEnabled = true
        
        
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        old_ap_x = ap_x
        old_ap_y = ap_y
        old_bp_x = bp_x
        old_bp_y = bp_y

        
        for t in touches {
            let touch = t as UITouch
            let location = touch.location(in: self.view)

            touchPos.append(location)
            
            print(touchPos.count,location)
            
        }
        
        
        if (touchPos.count >= 2) {
            
            ap_x = Int(touchPos[0].x) - 25
            ap_y = Int(touchPos[0].y) - 25
        
            bp_x = Int(touchPos[1].x) - 25
            bp_y = Int(touchPos[1].y) - 25
            
            touchPos.removeAll()
        
        
            drowPoint()
            
            if (onoffFlug == true){
            
                drowRect()
            
                if checkGoal(){
                    gameCount -= 1
                
                
                    if (gameCount == 0 ){
                        playSound2()
                    
                        // AppDelegateのmessageに押されたボタンのtagを代入
                        self.delegate.result = playTime
                        // NavigationControllerを使ったページの遷移
                        self.dismiss(animated: true, completion: nil)
                    
                    }else{
                        playSound()
                    }
                    setGoal()
                }
            }
        }
    }
    
    
/*
    
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
        
            drowPoint()
            drowRect()
            
            if checkGoal(){
                gameCount -= 1
                
                
                if (gameCount == 0 ){
                    playSound2()
                    
                    // AppDelegateのmessageに押されたボタンのtagを代入
                    self.delegate.result = playTime
                    // NavigationControllerを使ったページの遷移
                    self.dismiss(animated: true, completion: nil)
                    
                }else{
                    playSound()
                }
                setGoal()
            }
            
        
        }
    }
 */
 
 
    func drowPoint(){
        
        ol1.path = UIBezierPath(ovalIn: CGRect(x:old_ap_x, y:old_ap_y, width:50, height:50)).cgPath
        ol2.path = UIBezierPath(ovalIn: CGRect(x:old_bp_x, y:old_bp_y, width:50, height:50)).cgPath
        ol3.path = UIBezierPath(ovalIn: CGRect(x:ap_x, y:ap_y, width:50, height:50)).cgPath
        ol4.path = UIBezierPath(ovalIn: CGRect(x:bp_x, y:bp_y, width:50, height:50)).cgPath

        //  self.view.layer.display()
    }
    
    func drowRect(){
        
        rect1.path = UIBezierPath(rect:CGRect(x:ag_x,y:ag_y,width:50,height:50)).cgPath
        rect2.path = UIBezierPath(rect:CGRect(x:bg_x,y:bg_y,width:50,height:50)).cgPath
        
    }
    
    func setGoal(){
        let gx   = Int(arc4random(lower: 50, upper: 300))
        let gy   = Int(arc4random(lower: 200, upper: 400))
        
        let gq   = Double(arc4random(lower: 0, upper: 360))
        
        let sn = Double(gq) * 3.1415/180
        
        ag_x = gx + Int(40 * cos(sn))
        bg_x = gx - Int(40 * cos(sn))
        
        ag_y = gy + Int(40 * sin(sn))
        bg_y = gy - Int(40 * sin(sn))
        
    }
    
    
    func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        
        return arc4random_uniform(upper - lower) + lower
    }
    
    
    func checkGoal() ->Bool {
        
        let diff_ax = abs(ap_x - ag_x)
        let diff_bx = abs(bp_x - bg_x)
        let diff_cx = abs(ap_x - bg_x)
        let diff_dx = abs(bp_x - ag_x)
        
        let diff_ay = abs(ap_y - ag_y)
        let diff_by = abs(bp_y - bg_y)
        let diff_cy = abs(ap_y - bg_y)
        let diff_dy = abs(bp_y - ag_y)
        
        
        
        if (((diff_ax < 10) && (diff_bx < 10) && (diff_ay < 10) && (diff_by < 10))||((diff_cx < 10) && (diff_dx < 10) && (diff_cy < 10) && (diff_dy < 10))){
            
            return true
        }else{
            return false
        }
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "goal", withExtension: "wav")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
    func playSound2() {
        let url = Bundle.main.url(forResource: "finish", withExtension: "wav")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
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
