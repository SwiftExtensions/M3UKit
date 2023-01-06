//
//  Result.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

extension Result {
    /**
     A result Success value.
     */
    var success: Success? { self.output.success }
    /**
     A result Failure value.
     */
    var failure: Failure? { self.output.failure }
    private var output: (success: Success?, failure: Failure?) {
        switch self {
        case let .success(result):
            return (result, nil)
        case let .failure(error):
            return (nil, error)
        }
    }
    
    
}
