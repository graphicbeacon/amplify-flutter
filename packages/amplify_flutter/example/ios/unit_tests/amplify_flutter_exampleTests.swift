/*
 * Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import XCTest
import Amplify
import amplify_core
@testable import amplify_flutter

class amplify_flutter_exampleTests: XCTestCase {
    
    var plugin: SwiftAmplify = SwiftAmplify()

    func test_configuring_multiple_times_throws() throws {
        let _args = ["version": "1", "configuration": "{}"]
        let call = FlutterMethodCall(methodName: "configure", arguments: _args)
        plugin.handle(call, result: {(result)->Void in
            if (result as? Bool) != nil {} else {
                XCTFail("First time should be a success")
            }
        })
        plugin.handle(call, result: {(result)->Void in
            
            if let exception = result as? FlutterError {
                XCTAssertEqual(exception.code, "AmplifyAlreadyConfigured")
                XCTAssertEqual(exception.message, ErrorMessages.defaultFallbackErrorMessage)
                XCTAssertEqual(exception.details as? [String: String], ["underlyingException": "nil",
                                                                        "recoverySuggestion": "Remove the duplicate call to `Amplify.configure()`",
                                                                        "message": "Amplify has already been configured."])
            } else {
                XCTFail("Second time configure should be an exception")
            }
        })
    }

}
