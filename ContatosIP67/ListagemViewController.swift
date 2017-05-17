//
//  ListagemViewController.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/20/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ListagemViewController: UITableViewController, FormularioContatoViewControllerDelegate {

    let dao:ContatoDao;
    var linhaDestaque: IndexPath?
    
    
    required init?(coder aDecor:NSCoder){
        self.dao = ContatoDao.sharedInstance();
        
        super.init(coder : aDecor);

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.dao.removeNaPosicao(indexPath.row);
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade);
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contato:Contato =  dao.buscaNaPosicao(indexPath.row);
    
        self.exibeFormulario(contato);
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.carregaLista()
        
        if let linha = linhaDestaque {
            self.tableView.selectRow(at: linha, animated: true, scrollPosition: .middle);
            
             DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
              self.tableView.deselectRow(at: linha, animated: true);
              self.linhaDestaque = Optional.none;
            }
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.lista().count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contato:Contato = dao.buscaNaPosicao(indexPath.row);
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell");
        
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
        }
        
        cell!.textLabel?.text = contato.nome;
        cell!.imageView?.image = contato.foto;
        cell!.imageView?.layer.cornerRadius = 22.0;
        cell!.imageView?.clipsToBounds = true;
        return cell!;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormularioContato" {
            
            if let formulario = segue.destination as? FormularioContatoViewController {
                formulario.delegate = self;
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let gesto = UILongPressGestureRecognizer(target: self, action: #selector(exibeAcoes(sender:)));
    
        self.tableView.addGestureRecognizer(gesto);
    }
    
    
    func exibeAcoes(sender: UIGestureRecognizer) {
        if sender.state == .began {
           
            let point: CGPoint = sender.location(in: self.tableView);
            
            if let indexPath : IndexPath = self.tableView.indexPathForRow(at: point){
            
                let contato = dao.buscaNaPosicao(indexPath.row);
                
                let acoes: GerenciadorDeAcoes = GerenciadorDeAcoes(do: contato)
                
                acoes.exibeAcoes(no: self);
                
                
            }
        }
    }
    
    
    func exibeFormulario(_ contato : Contato){
        
        let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        
        if let form : FormularioContatoViewController = board.instantiateViewController(withIdentifier: "FormularioContato") as? FormularioContatoViewController  {

            form.delegate = self;

            form.contato = contato;
            
            
            self.navigationController?.pushViewController(form, animated: true);
        }
    }
    
   
    private func carregaLista(){
        self.tableView.reloadData()

    }
    
    
    func contatoAdicionado(_ contato: Contato) {
        let posicao = dao.buscaPosicaoDoContato(contato);
        self.linhaDestaque = IndexPath(row: posicao, section: 0);
        
    }
    
    func contatoAtualizado(_ contato: Contato) {
        let posicao = dao.buscaPosicaoDoContato(contato);
        self.linhaDestaque = IndexPath(row: posicao, section: 0);
        
    }
}
