

import Foundation

final class ApiService{
    
    static let shared = ApiService()
    
    func getTopStories(completion: @escaping (Result<[Article],Error>) -> Void){

        
        guard let url = URL( string: "https://newsapi.org/v2/everything?q=apple&from=2023-01-17&to=2023-01-17&sortBy=popularity&apiKey=74719dc78392479691eeaacb5a160221") else { return }
        
        let task = URLSession.shared.dataTask(  with: url){   data, _, error  in
            print("aaa")
            if let error = error {
                           completion(.failure(error))
                       }
                       else if let data = data {
                           do {
                               let result = try JSONDecoder().decode(APIResponse.self, from: data)
                               print ("Articles: \(result.articles.count)")
                               completion(.success(result.articles))
                               print("BBB")
                           }
                           catch {
                               completion(.failure(error))
                           }
                       }
                       
        }
        
        task.resume()
    }
    
    
}


struct APIResponse: Codable{
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
