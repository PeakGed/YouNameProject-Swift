import Foundation
import Alamofire
import Mockable

enum ChannelRouterService: AlamofireBaseRouterProtocol {    
    case fetchChannels
    case fetchChannel(request: ChannelServiceRequest.FetchChannel)
    case createChannel(request: ChannelServiceRequest.CreateChannel)
    case updateChannel(request: ChannelServiceRequest.UpdateChannel)
    case deleteChannel(request: ChannelServiceRequest.DeleteChannel)
    case createSubChannel(request: ChannelServiceRequest.CreateSubChannel)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchChannels:
            return "/api/v4/channels"
        case .fetchChannel(let request):
            return "/api/v4/channels/\(request.id)"
        case .createChannel:
            return "/api/v4/channels"
        case .updateChannel(let request):
            return "/api/v4/channels/\(request.id)"
        case .deleteChannel(let request):
            return "/api/v4/channels/\(request.id)"
        case .createSubChannel(let request):
            return "/api/v4/channels/\(request.channelId)/sub-channels"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchChannels, .fetchChannel:
            return .get
        case .createChannel, .createSubChannel:
            return .post
        case .updateChannel:
            return .put
        case .deleteChannel:
            return .delete
        }
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
     
    var body: Data? {
        switch self {
        case .createChannel(let request):
            return try? JSONEncoder().encode(request)
        case .updateChannel(let request):
            return try? JSONEncoder().encode(request)
        case .createSubChannel(let request):
            return try? JSONEncoder().encode(request)
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request,
                                   with: parameters)
    }

} 
