//
//  APIManager.swift
//
//  Created by JMD on 17/01/19.
//  Copyright © 2019 JMD. All rights reserved.
//
import UIKit
import Foundation


//Request Type
public protocol RequestType {
    associatedtype ResponseType: Codable
    var dataRequest: RequestData { get }
}

//MARK: Request
public extension RequestType {
    
    @discardableResult
    func execute (dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                  onSuccess: @escaping (ResponseType) -> Void,
                  onError: @escaping (Error?) -> Void) -> URLSessionDataTask? {
        
        return dispatcher.dispatch(request: self.dataRequest,
                                   onSuccess: { (responseData: Data) in
                                    do {
                                        let result = try responseData.decode(model: ResponseType.self)
                                        if result != nil {
                                            onSuccess(result!)
                                        } else {
                                            Log.print("API Response is nil ====>❗️")
                                            onError(nil)
                                        }
                                    } catch let error {
                                        Log.print("API Response Error ====>❗️ \n", error)
                                        onError(error)
                                    }
        }, onError: { (error: Error) in
            Log.print("Server Error ====>❗️ \n", error)
            onError(error)
        })
    }
}

//MARK: Create Network Dispatcher
public protocol NetworkDispatcher {
    
    func dispatch(request: RequestData,
                  onSuccess: @escaping (Data) -> Void,
                  onError: @escaping (Error) -> Void) -> URLSessionDataTask?
}

public struct URLSessionNetworkDispatcher: NetworkDispatcher {
    public static let instance = URLSessionNetworkDispatcher()
    private init() {}
    
    ///- Note: Post request
    @discardableResult
    public func dispatch(request: RequestData,
                         onSuccess: @escaping (Data) -> Void,
                         onError: @escaping (Error) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: request.path) else {
            onError(ErrorType.invalidURL)
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return nil
        }
        if let headers = request.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            guard let _data = data else {
                onError(ErrorType.noData)
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: _data, options: []) {
                Log.print("API Response ====> 🇮🇳 \n", getPrintableJSON(json))
            }
            onSuccess(_data)
        }
        dataTask.resume()
        return dataTask
    }
}

//######################################################
//----------------- WITHOUT CODABLE -------------------
//######################################################
//Request Type
public protocol DataRequestType {
    var dataRequest: RequestData { get }
}

//MARK: API Call without Codable
public func execute(request: RequestData,
                     onSuccess: @escaping ([String: Any]) -> (),
                     onError: @escaping (Error) -> ()) -> () {
    guard let url = URL(string: request.path) else {
        onError(ErrorType.invalidURL)
        return
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    do {
        if let params = request.params {
            Log.print("Request Params======> ", params)
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }
    } catch let error {
        onError(error)
        return
    }
    if let headers = request.headers {
        urlRequest.allHTTPHeaderFields = headers
    }
    let dataTask = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
        if let error = error {
            onError(error)
            return
        }
        guard let _data = data else {
            onError(ErrorType.noData)
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: _data, options: []) {
            Log.print("url Response ====> 🇮🇳\(url) \n ", json)
            onSuccess(json as! [String : Any])
        } else {
            onError(ErrorType.noData)
        }
    }
    dataTask.resume()
}
///- Note: Printable Json
private func getPrintableJSON(_ json: AnyObject) -> NSString {
    return JSONStringify(json, prettyPrinted: true) as NSString
}

public func getPrintableJSON(_ json: Any) -> NSString {
    return getPrintableJSON(json as AnyObject)
}

/// - Note: Print Formatted Json
public func JSONStringify(_ value: AnyObject, prettyPrinted:Bool = false) -> String{
    let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
    
    if JSONSerialization.isValidJSONObject(value) {
        do{
            let data = try JSONSerialization.data(withJSONObject: value, options: options)
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                return string as String
            }
        }catch {
            Log.print("error")
        }
    }
    return ""
}
