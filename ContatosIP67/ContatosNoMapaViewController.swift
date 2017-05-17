//
//  ContatosNoMapaViewController.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/22/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var contatos:Array<Contato> = Array();
    
    let dao:ContatoDao = ContatoDao.sharedInstance();
    let locationManager = CLLocationManager()
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil;
        }
        
        let pinImg = #imageLiteral(resourceName: "gps");
        
        let identifier:String = "pino";
        
        var pino : MKAnnotationView;
        
        if let reusablePin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)  {
            pino = reusablePin;
        } else {
            pino = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier);
        }
        
        if let contato = annotation as? Contato {
            
            pino.canShowCallout = true
            pino.image = pinImg;
            
            let frame = CGRect( x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            
            let imagemContato = UIImageView(frame: frame )
            
            imagemContato.image = contato.foto;
            
            pino.leftCalloutAccessoryView = imagemContato
        }
        
        
        return pino;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapa.delegate = self;
        
        self.locationManager.requestWhenInUseAuthorization();
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: mapa);
        
        self.navigationItem.rightBarButtonItem = botaoLocalizacao;
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.contatos = dao.lista();
        self.mapa.addAnnotations(self.contatos);
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(self.contatos);
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
