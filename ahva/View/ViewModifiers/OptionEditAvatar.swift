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
                ForEach(Array(styles), id: \.key) { style in
                    Button {
                        print(style.value)
                    } label: {
                        ButtonStyle(text: style.key)
                    }
                }
            }
            .task {
                await createOptions(type)
            }
            
            
        }
        
    }
}


extension OptionEditAvatar{
    func createOptions(_ type: String) async {
        do {
            //dentro da vm
            let request = try HTTPRequestFactory(path: "https://databaseavatar.vercel.app/api/character/\(type)", method: .GET).createRequest()
            let (data, _) = try await request.send()
            
            if let data, let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
               self.styles = json
                print(styles)
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
