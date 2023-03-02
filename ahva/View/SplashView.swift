//
//  SplashView.swift
//  ahva
//
//  Created by Bruno Lafayette on 16/02/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActivite: Bool = false
    
    var body: some View {
        
        ZStack{
            if isActivite{
                MainView()
            } else {
                
                Image("MeuAvatar")
                
            }
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 ){
                withAnimation {
                    isActivite = true
                }
            }
        }
        
    }
    
    
}

