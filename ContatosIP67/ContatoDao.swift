//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/20/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ContatoDao: CoreDataUtil {
    
    static private var defaultDAO: ContatoDao!;
    private var contatos: Array<Contato>;
    
    static func sharedInstance() -> ContatoDao{
        if defaultDAO == nil {
            defaultDAO = ContatoDao();
        }
        
        return defaultDAO;
    }
    
    override private init(){
        contatos = Array<Contato>();
       
        super.init()
        
        self.cargaInicial()
        
        self.loadDB();
        
    }
    
    func novoContato() -> Contato {
        
        return NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
    }
    
    func loadDB(){
        
        let busca = NSFetchRequest<Contato>(entityName: "Contato");
        let ordem = NSSortDescriptor(key: "nome", ascending: true);
        
        busca.sortDescriptors = [ordem];
        
        do {
            self.contatos = try self.persistentContainer.viewContext.fetch(busca);
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
    func cargaInicial(){
        let config = UserDefaults.standard;
        
        let jahInserido = config.bool(forKey: "dado_cadastrado");
        
        
        if !jahInserido {
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato",into: self.persistentContainer.viewContext) as! Contato;
            
            caelumSP.nome = "Caelum SP"
            caelumSP.endereco = "Rua Vergueiro, 3185";
            caelumSP.latitude = -23.5883034;
            caelumSP.longitude = -46.632369;
                                                               
            
            self.saveContext();
            config.set(true, forKey: "dado_cadastrado");
            config.synchronize();
        }
        
    }
    
    func adiciona(_ contato:Contato){
        contatos.append(contato);
    }

    func lista() -> Array<Contato> {
        return self.contatos;
    }
    
    func buscaNaPosicao(_ pos : Int) -> Contato{
        return contatos[pos];
    }
    
    func removeNaPosicao(_ pos :Int)  {
        contatos.remove(at: pos);
    }
    
    func buscaPosicaoDoContato(_ contato : Contato) -> Int{
        return contatos.index(of: contato)!;
    }
    
}
