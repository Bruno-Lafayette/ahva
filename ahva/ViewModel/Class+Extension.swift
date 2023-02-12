//
//  Class+Extension.swift
//  ahva
//
//  Created by Bruno Lafayette on 10/02/23.
//

import Foundation

extension Array{
    func getElementAtIndex(_ index: Int)-> Element?{
        if index < self.endIndex{
            return self[index]
        }
        return nil
    }
}


