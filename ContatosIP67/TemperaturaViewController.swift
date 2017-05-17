//
//  TemperaturaViewController.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/24/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class TemperaturaViewController: UIViewController {

    
    @IBOutlet weak var labelCondicaoAtual: UILabel!
    
    @IBOutlet weak var labelTemperaturaMinima: UILabel!
    
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?APPID=4fdd8f81cde46506466b01fb9ddec87d&units=metric"
    let URL_BASE_IMAGE = "http://openweathermap.org/img/w/"
    
    var contato : Contato?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data : DataRequest = Alamofire.request(URL(string: URL_BASE + "&lat=\(self.contato!.latitude ?? 0)&lon=\(self.contato!.longitude ?? 0)")!);
        
        data.responseObject{(response: DataResponse<Weather> ) in
      
            if let weather: Weather = response.result.value {

            
           
                self.labelCondicaoAtual.text = weather.cond
                self.labelTemperaturaMinima.text = weather.min.description + "º"
                self.labelTemperaturaMaxima.text = weather.max.description + "º"
                self.pegaImagem(weather.icon)
                self.labelCondicaoAtual.isHidden = false
                self.labelTemperaturaMinima.isHidden = false
                self.labelTemperaturaMaxima.isHidden = false
            }
        }
        
    }
    
    func pegaImagem(_ icon : String){
        
        
        Alamofire.request(URL_BASE_IMAGE + icon + ".png").responseImage { response in
            
            self.imageView.image = response.result.value;
            
            
        }
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
