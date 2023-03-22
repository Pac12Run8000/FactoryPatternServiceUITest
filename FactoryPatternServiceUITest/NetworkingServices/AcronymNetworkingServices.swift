//
//  AcronymNetworkingServices.swift
//  FactoryPatternServiceUITest
//
//  Created by Michelle Grover on 3/21/23.
//

import Foundation


class AcronymNetworkingService: NetworkingService {
    private let baseURLString = "http://nactem.ac.uk/software/acromine/dictionary.py"
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchAcronyms(for searchTerm: String, completion: @escaping (Result<AcronymObject, Error>) -> Void) {
        guard let url = makeURL(for: searchTerm) else {
            completion(.failure(NSError(domain: "NetworkingServiceErrorDomain", code: 1, userInfo: nil)))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkingServiceErrorDomain", code: 1, userInfo: nil)))
                return
            }
            
            do {
                let acronyms = try JSONDecoder().decode(AcronymObject.self, from: data)
                completion(.success(acronyms))
//                print(acronyms)
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func makeURL(for searchTerm: String) -> URL? {
        var components = URLComponents(string: baseURLString)!
        components.queryItems = [URLQueryItem(name: "sf", value: searchTerm)]
        return components.url
    }
}


class MockAcronymNetworkingService:NetworkingService {
    
    
    func fetchAcronyms(for searchTerm: String, completion: @escaping (NetworkingResult<AcronymObject>) -> Void) {
        let acronymObject = [FactoryPatternServiceUITest.AcronymElement(sf: "XM", lfs: [FactoryPatternServiceUITest.LF(lf: "X chromosome", freq: 7, since: 1979, vars: Optional([FactoryPatternServiceUITest.LF(lf: "X chromosome", freq: 6, since: 1979, vars: nil), FactoryPatternServiceUITest.LF(lf: "X-chromosome", freq: 1, since: 2005, vars: nil)])), FactoryPatternServiceUITest.LF(lf: "maternal X", freq: 3, since: 1988, vars: Optional([FactoryPatternServiceUITest.LF(lf: "maternal X", freq: 3, since: 1988, vars: nil)])), FactoryPatternServiceUITest.LF(lf: "The maximum adsorption values", freq: 3, since: 2004, vars: Optional([FactoryPatternServiceUITest.LF(lf: "The maximum adsorption values", freq: 3, since: 2004, vars: nil)])), FactoryPatternServiceUITest.LF(lf: "We compared our standard NIH (extended incubation) crossmatch", freq: 2, since: 1990, vars: Optional([FactoryPatternServiceUITest.LF(lf: "We compared our standard NIH (extended incubation) crossmatch", freq: 2, since: 1990, vars: nil)]))])]
        
        completion(.success(acronymObject))
    }
    
    
}

