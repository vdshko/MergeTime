//
//  Logger.swift
//  DebugTools
//
//  Created by Vlad Shkodich on 24.04.2021.
//

public enum Logger {
    
    static let currentLogLevel = LogLevel.test
    
    private static func log(_ level: LogLevel, _ string: () -> String, file: String = #file, line: Int = #line) {
        #if DEBUG
            if currentLogLevel.rawValue > level.rawValue {
                return
            }
            let startIndex = file.range(of: "/", options: .backwards)?.upperBound
            let fileName = file[startIndex!...]
            print(" \(level.glyph()) [\(NSDate())] \(fileName)(\(line)) | \(string())")
        #endif
    }
}

extension Logger {
    
    enum LogLevel: Int {
        
        case test, verbose, success, warn, fail
        
        func glyph() -> String {
            switch self {
            case .test: return "💜"
            case .verbose: return "💙"
            case .success: return "💚"
            case .warn: return "💛"
            case .fail: return "💔"
            }
        }
    }
}

// MARK: - Strings

extension Logger {
    
    public static func success(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.success, string, file: file, line: line)
    }
    
    public static func error(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.fail, string, file: file, line: line)
    }
    
    public static func test(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.test, string, file: file, line: line)
    }
    
    public static func verbose(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.verbose, string, file: file, line: line)
    }
    
    public static func warn(_ string: @autoclosure () -> String, file: String = #file, line: Int = #line) {
        log(.warn, string, file: file, line: line)
    }
}

// MARK: - Errors

extension Logger {
    
    public static func error(_ error: Error, file: String = #file, line: Int = #line) {
        self.error("\(error)", file: file, line: line)
    }
    
    public static func warn(_ error: Error, file: String = #file, line: Int = #line) {
        self.warn("\(error)", file: file, line: line)
    }
}

// MARK: - Assert

extension Logger {
    
    public static func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        #if DEBUG
        Swift.assert(condition(), message(), file: file, line: line)
        #endif
    }
}
