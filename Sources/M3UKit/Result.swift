//
//  Result.swift
//  M3UKit
//
//  Created by Александр Алгашев on 12/12/2025.
//

extension Result where Failure == Error {
     /**
      Возвращает ошибку, если `Result` находится в состоянии `.failure`, иначе возвращает `nil`.
      */
    var error: Error? {
        if case let .failure(error) = self {
            return error
        }
        return nil
    }
    
    
 }
