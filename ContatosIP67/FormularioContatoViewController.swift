//
//  ViewController.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/20/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    @IBOutlet  var campoNome: UITextField!
    @IBOutlet  var campoTelefone: UITextField!
    @IBOutlet  var campoSite: UITextField!
    @IBOutlet  var campoEndereco: UITextField!
    @IBOutlet  var campoFoto: UIImageView!
    @IBOutlet  var buscarCoordenadas: UIButton!
    @IBOutlet  var latitude: UITextField!
    @IBOutlet  var longitude: UITextField!
    @IBOutlet  var loading: UIActivityIndicatorView!
    
    var delegate:FormularioContatoViewControllerDelegate?

    
    var contato:Contato!;

    var dao:ContatoDao!;
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance();
        super.init(coder: aDecoder);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if let contato = self.contato {
            campoNome.text = contato.nome;
            campoSite.text = contato.site;
            campoTelefone.text = contato.telefone;
            campoEndereco.text = contato.endereco;
            latitude.text = contato.latitude?.description;
            longitude.text = contato.longitude?.description;
            
            if let foto = contato.foto{
                self.campoFoto.image = foto;
            }
         
             self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(alterar));
        }
        
        let tapFoto = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto(sender:)));
        
        campoFoto.addGestureRecognizer(tapFoto);
        
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.campoFoto.image = imageSelecionada;
            picker.dismiss(animated: true, completion: nil);
        }
    }
    
    
    func selecionaFoto(sender: AnyObject){
        let imagePicker = UIImagePickerController()
       
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let alert = UIAlertController(title: "O que você deseja ? ", message: "Escolha sua opção", preferredStyle: .actionSheet);
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel);
            let camera = UIAlertAction(title: "Tirar Foto ", style: .default){(action) in
            imagePicker.sourceType = .camera };
            let galeria = UIAlertAction(title: "Usar Galeria ", style: .default){(action) in
                imagePicker.sourceType = .photoLibrary };

            
            
            alert.addAction(camera);
            alert.addAction(cancelar);
            alert.addAction(galeria);
            
            
            imagePicker.sourceType = .camera
            
            self.present(alert, animated: true, completion: nil);

        }else {
            imagePicker.sourceType = .photoLibrary

        }
        
        self.present(imagePicker, animated: true, completion: nil)
        
    
        
    }
    
    func pegaDadosDoFormulario() {
        if contato == nil {
            self.contato = dao.novoContato();
        }
        
        self.contato.nome = self.campoNome.text!;
        self.contato.telefone = self.campoTelefone.text!
        self.contato.site = self.campoSite.text!
        self.contato.endereco = self.campoEndereco.text!
        self.contato.foto = self.campoFoto.image;
    
        
        if let lat = Double(self.latitude.text!){
            self.contato.latitude = lat as NSNumber;
        }
        
        if let lon = Double(self.longitude.text!){
            self.contato.longitude = lon as NSNumber;
        }
    }
    
    func alterar(){
        self.pegaDadosDoFormulario()
        
        self.delegate?.contatoAtualizado(contato);
        
        self.retornaParaTelaAnterior();
    }
    
    @IBAction
    func criaContato(){
        self.pegaDadosDoFormulario()
        dao.adiciona(contato!);
        
        self.delegate?.contatoAdicionado(contato);
        
        self.retornaParaTelaAnterior();
    }
    
    @IBAction
    func buscaCoordenadas(sender: UIButton){
        self.loading.startAnimating();
        sender.isEnabled = false;
        
        let geocoder:CLGeocoder = CLGeocoder();
        
        geocoder.geocodeAddressString(self.campoEndereco.text!){(resultado, error)  in
        
            if error == nil && (resultado?.count)! > 0{
                let placemark = resultado![0];
                let coordenada = placemark.location!.coordinate;
                
                self.latitude.text = coordenada.latitude.description
                self.longitude.text = coordenada.longitude.description
                
                self.loading.stopAnimating();
                sender.isEnabled = true;
                
            }
           
            
        }
    }
    
    
    func retornaParaTelaAnterior()  {
        _ = self.navigationController?.popViewController(animated: true);

    }
}

