//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/22/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes : NSObject {
    
    let contato:Contato;
    var controller:UIViewController!
    
    init(do contato:Contato) {
        self.contato = contato;
    }
    
    func exibeAcoes(no controller : UIViewController)  {
        self.controller = controller;
        
        
        let alert : UIAlertController = UIAlertController(title: "\(contato.nome!)", message: nil, preferredStyle: .actionSheet);
        
        let cancelar : UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil);
        
        let ligar :UIAlertAction = UIAlertAction(title: "Ligar", style: .default){action in self.ligar();}
        
        let mostrarNoMapa : UIAlertAction =  UIAlertAction(title: "Exibir no Map", style: .default){action in self.mostrarMapa();}
        
        let mostraSite : UIAlertAction = UIAlertAction(title: "Exibe Site", style: .default){action in self.abrirSite();}
        
        let exibeTemperatura : UIAlertAction = UIAlertAction(title: "Exibir Temperatura", style: .default){action in self.exibirTemperatura();};
        
        alert.addAction(ligar);
        alert.addAction(cancelar);
        alert.addAction(mostraSite);
        alert.addAction(exibeTemperatura);
        alert.addAction(mostrarNoMapa);
        
        
        self.controller.present(alert, animated: true, completion: nil);
    }
    
    private func exibirTemperatura(){
        
        let temperaturaViewController = self.controller.storyboard?.instantiateViewController(withIdentifier: "temperaturaViewController") as! TemperaturaViewController
        
        temperaturaViewController.contato = self.contato;
        controller.navigationController?.pushViewController(temperaturaViewController, animated: true)
    }

    
    private func ligar(){
        let device = UIDevice.current;
        
        if device.model == "iPhone"{
         
            abrirCom(url: "tel:\(self.contato.telefone))")
            
        } else {
            let error = UIAlertController(title: "Não deu certo", message: "Aparelho não suporta", preferredStyle: .alert);
            
            self.controller.present(error, animated: true, completion: nil);
        }
    }
    
    private func abrirSite() {
        var url = contato.site!
        
        if !url.hasSuffix("http://"){
            url = "http://\(url)";
        }
        
        abrirCom(url: url)
    }
    
    private func mostrarMapa() {
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!;
        abrirCom(url: url);
    }
    
    private func abrirCom(url : String){
        UIApplication.shared.open(URL(string: url)! , options: [:], completionHandler: nil);
    }

}
