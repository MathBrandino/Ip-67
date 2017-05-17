//
//  Contato.m
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/20/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

#import "Contato.h"


@implementation Contato

@dynamic nome,telefone, site,endereco,longitude,latitude,foto;

    - (NSString *)description
    {
        return [NSString stringWithFormat:@"Nome: %@ \nTelefone: %@ \nSite: %@ \nEndereço: %@", self.nome, self.telefone, self.site, self.endereco];
    }

    
    -(CLLocationCoordinate2D) coordinate
    {
        return CLLocationCoordinate2DMake(self.latitude.doubleValue,self.longitude.doubleValue);
    }
    
    -(NSString *)title
    {
        return self.nome;
    }
    
    -(NSString *)subtitle
    {
        return self.endereco;
    }
@end
