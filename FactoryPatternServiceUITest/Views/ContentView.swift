//
//  ContentView.swift
//  FactoryPatternServiceUITest
//
//  Created by Michelle Grover on 3/21/23.
//

import SwiftUI

struct ContentView: View {
    @State var list:[String] = []
    @State private var searchTerm: String = ""
        
        let networkingService = NetworkingServiceFactory.makeNetworkingService()
        
    var body: some View {
        VStack {
                    TextField("Enter acronym", text: $searchTerm, onCommit: {
                        fetchAcronyms()
                    })
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                        
                    HStack {
                        Button {
                            fetchAcronyms(for: "al")
                        } label: {
                            Text("al")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }

                        Button {
                            fetchAcronyms(for: "az")
                        } label: {
                            Text("az")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Button {
                            fetchAcronyms(for: "io")
                        } label: {
                            Text("io")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Button {
                            fetchAcronyms(for: "il")
                        } label: {
                            Text("il")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
            
                    Spacer()
                        .frame(height:20)
            if !list.isEmpty {
                List(list, id: \.self) { item in
                    Text(item)
                }
                .listStyle(PlainListStyle())
            }
        }
        Spacer()
    }
    
    internal func displayList(acronymObject:AcronymObject, completion:@escaping(_ list:[String]) -> ()) {
        var localList = [String]()
        if !acronymObject.isEmpty {
            for acronym in acronymObject {
                for item in acronym.lfs {
                    localList.append(item.lf)
                }
            }
            completion(localList)
        } else {
            completion([String]())
        }
    }
    
    private func fetchAcronyms() {
            networkingService.fetchAcronyms(for: searchTerm) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let acronyms):
                        displayList(acronymObject: acronyms) { list in
                            self.list = list
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
    
    private func fetchAcronyms(for searchVal:String) {
        networkingService.fetchAcronyms(for: searchVal) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let acronyms):
                    displayList(acronymObject: acronyms) { list in
                        self.list = list
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
