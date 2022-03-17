import Alamofire
import PromiseKit

public class Http {
    
    private static let api = "https://www.metaweather.com/api"
    
    private init() {}
    
    /// Retorna una URL con todos los componentes necesarions `protocol`://`domain`:`port`/`path`
    ///
    /// - Parameter url: URL de entrada
    /// - Returns: Si la url no tiene un protocolo se agrega el (protocolo, host y puerto) del api de adivantus
    public static func unwrapurl(route url: String) -> String {
        if url.starts(with: "http") {
            return url
        }
        return "\(Http.api)\(url)"
    }
    
    public static func request<Element: Codable>(_ method: HTTPMethod, _ url:String, parameters: Parameters? = nil) -> Promise<Element?> {
        Promise { seal in
            AF.request(unwrapurl(route: url), method: method, parameters: parameters)
                .responseDecodable(of: Element.self) { response in
                    switch response.result {
                    case .success(let result):
                        seal.fulfill(result)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
            
        }
    }
    
    public static func request<Element: Codable>(_ method: HTTPMethod, _ url:String, parameters: Parameters? = nil) -> Promise<[Element]> {
        Promise { seal in
            AF.request(unwrapurl(route: url), method: method, parameters: parameters)
                .responseDecodable(of: [Element].self) { response in
                    switch response.result {
                    case .success(let result):
                        seal.fulfill(result)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }
            
        }
    }
}
