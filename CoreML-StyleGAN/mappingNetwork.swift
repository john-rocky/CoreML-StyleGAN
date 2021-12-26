//
// mappingNetwork.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class mappingNetworkInput : MLFeatureProvider {

    /// var as 1 by 512 matrix of floats
    var var_: MLMultiArray

    var featureNames: Set<String> {
        get {
            return ["var"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "var") {
            return MLFeatureValue(multiArray: var_)
        }
        return nil
    }
    
    init(var_: MLMultiArray) {
        self.var_ = var_
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    convenience init(var_: MLShapedArray<Float>) {
        self.init(var_: MLMultiArray(var_))
    }

}


/// Model Prediction Output Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class mappingNetworkOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// var_134 as multidimensional array of floats
    lazy var var_134: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "var_134")!.multiArrayValue
    }()!

    /// var_134 as multidimensional array of floats
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    var var_134ShapedArray: MLShapedArray<Float> {
        return MLShapedArray<Float>(self.var_134)
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(var_134: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["var_134" : MLFeatureValue(multiArray: var_134)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class mappingNetwork {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "mappingNetwork", withExtension:"mlmodelc")!
    }

    /**
        Construct mappingNetwork instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of mappingNetwork.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `mappingNetwork.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct mappingNetwork instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct mappingNetwork instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct mappingNetwork instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<mappingNetwork, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct mappingNetwork instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> mappingNetwork {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct mappingNetwork instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<mappingNetwork, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(mappingNetwork(model: model)))
            }
        }
    }

    /**
        Construct mappingNetwork instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> mappingNetwork {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return mappingNetwork(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as mappingNetworkInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as mappingNetworkOutput
    */
    func prediction(input: mappingNetworkInput) throws -> mappingNetworkOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as mappingNetworkInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as mappingNetworkOutput
    */
    func prediction(input: mappingNetworkInput, options: MLPredictionOptions) throws -> mappingNetworkOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return mappingNetworkOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - var_ as 1 by 512 matrix of floats

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as mappingNetworkOutput
    */
    func prediction(var_: MLMultiArray) throws -> mappingNetworkOutput {
        let input_ = mappingNetworkInput(var_: var_)
        return try self.prediction(input: input_)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - var_ as 1 by 512 matrix of floats

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as mappingNetworkOutput
    */

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    func prediction(var_: MLShapedArray<Float>) throws -> mappingNetworkOutput {
        let input_ = mappingNetworkInput(var_: var_)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [mappingNetworkInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [mappingNetworkOutput]
    */
    func predictions(inputs: [mappingNetworkInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [mappingNetworkOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [mappingNetworkOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  mappingNetworkOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
