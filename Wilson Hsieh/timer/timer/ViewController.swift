//
//  ViewController.swift
//  timer
//
//  Created by Wilson Hsieh on 2017/8/7.
//  Copyright © 2017年 Wilson Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDataSource{

    
    var pickerDataSource : [String: Int] = ["熱身":120, "低強度訓練":150, "高強度訓練":80 , "休息":60];
    var componentArray:[String]!
    var pickerSelectValue:String! {
        didSet {
            initViewValue()

        }
    }
    var timer = Timer()
    var isTimerRun:Bool = false

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var customerPicker: UIPickerView!
    var timerNumber:Int!
    
    @IBAction func startActionBtn(_ sender: Any) {
        if self.isTimerRun{
            self.isTimerRun = false
            startBtn.setTitle("開始", for: .normal)
        }else{
            self.isTimerRun = true
            startBtn.setTitle("暫停", for: .normal)
            
        }
        timerProcess()
        
    }
    
    @IBAction func resetActionBtn(_ sender: Any) {
        self.isTimerRun = false
        timerProcess()
        initViewValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerPicker.delegate=self
        customerPicker.dataSource = self
        timerNumber = 60
        componentArray = Array(pickerDataSource.keys)
        self.customerPicker.reloadAllComponents()

    }
    
    func timerProcess(){
        if self.isTimerRun{
            timer =  Timer.scheduledTimer(
                    timeInterval: TimeInterval(1),
                    target      : self,
                    selector    : #selector(ViewController.decredTime),
                    userInfo    : nil,
                    repeats     : true)
            
            decredTime()
            timer.fire()
        }else{
           
            timer.invalidate()
            
        }
        
    }
    
    func updateTimerView(){
        let min = timerNumber / 60
        let sec = timerNumber % 60
        timerLabel.text = String(format: "%02i:%02i", min, sec)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func decredTime(){
        if (timerNumber > 0){
            timerNumber! -= 1
            updateTimerView()
        }else{
            self.isTimerRun = false
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        pickerSelectValue = componentArray[self.customerPicker.selectedRow(inComponent:0)]
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
         return pickerDataSource.count
    }
    
    
    func initViewValue(){
        timerNumber = pickerDataSource[pickerSelectValue]
        updateTimerView()

    }
}


extension ViewController:UIPickerViewDelegate {
  
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return componentArray[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pickerSelectValue = componentArray[row]
        
    }
}
