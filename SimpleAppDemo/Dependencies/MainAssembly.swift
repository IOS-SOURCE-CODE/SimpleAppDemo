//
//  MainAssembly.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import Swinject

class MainAssembly {
  
  lazy var resolver: Resolver = {
    return assembler!.resolver
  }()
  
  private var assembler: Assembler!
  
  
  init() {
    
    assembler = Assembler()
    assembler.apply(assembly: DependencyRegistry())
    
  }
  
}
