//
//  FormularioContatoViewControllerDelegate.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/21/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegate {
    func contatoAtualizado(_ contato:Contato)
    func contatoAdicionado(_ contato:Contato)
    
}
