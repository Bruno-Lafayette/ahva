//
//  OptionEditAvatar.swift
//  ahva
//
//  Created by Bruno Lafayette on 09/02/23.
//

import SwiftUI

struct OptionEditAvatar: View {
    @State private var styles: [String:Any] = [:]
    @State private var invalidUrlError: Bool = false
    @State private var unkownError: Bool = false
    private var type: String
    
    init(type: String) {
        self.type = type
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(0..<styles.count) {option in
                    
                    Button {
                        print("funciono \(styles.keys)")
                    } label: {
                        ButtonStyle(text: "Item \(styles.keys)")
                    }
                }
            }.task {
                do {
                    //dentro da vm
                    let request = try HTTPRequestFactory(path: "https://databaseavatar.vercel.app/api/character/\(type)", method: .GET).createRequest()
                    let (data, response) = try await request.send()
                    print(response)
                    
                    if let data, let json = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                       let styles: [String:Any] = json["styles"] as? [String:Any] {
                        self.styles = styles
                        print(styles.keys)
                    }
                    
                    
                    // deixar parte da trataiva aqui mesmo
                } catch URLError.badURL {
                    self.invalidUrlError = true
                } catch {
//                    print(error)
//                    print(error.localizedDescription)
                    self.unkownError = true
                }
            }
            
        }
        
    }
}


struct ButtonStyle: View{
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View{
        Text(text)
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(.red)
    }
}
