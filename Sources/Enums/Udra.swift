//
//  PArser.swift
//  IBAnimatable
//
//  Created by phimage on 06/05/2019.
//  Copyright © 2019 IBAnimatable. All rights reserved.
//

import Foundation

/// User defined runtime attributes parsing.
class Udra { //swiftlint:disable:this type_body_length
  // MARK: - Token

  /// User defined runtime attributes Tokens.
  enum Token {
    case identifier(String, CountableRange<Int>)
    case number(Double, CountableRange<Int>)
    case comma(CountableRange<Int>)
    case parenthesisOpen(CountableRange<Int>)
    case parenthesisClose(CountableRange<Int>)
    case bracketOpen(CountableRange<Int>)
    case bracketClose(CountableRange<Int>)
    case `operator`(Operator, CountableRange<Int>)
    case undefined(String, CountableRange<Int>)
  }

  enum Operator: String {
    case plus = "+"

    var precedence: Int {
      switch self {
      case .plus:
        return 10
      }
    }
  }

  // MARK: - Lexer

  /// User defined runtime attributes Lexer.
  class Lexer {

    typealias TokenBuilder = (String, CountableRange<Int>) -> Token? //swiftlint:disable:this nesting

    static let tokenStringList: [String: TokenBuilder] = [
      "[ \t\n]": { _, _ in nil }, // trim
      "[a-zA-Z][a-zA-Z0-9]*": ({ .identifier($0, $1) }),
      "\\-?[0-9.]+": ({ .number(Double($0)!, $1) }),
      "\\(": ({ .parenthesisOpen($1) }),
      "\\)": ({ .parenthesisClose($1) }),
      "\\[": ({ .bracketOpen($1) }),
      "\\]": ({ .bracketClose($1) }),
      "\\+": ({ .operator(Operator(rawValue: $0)!, $1) }),
      ",": ({ .comma($1) })
    ]

    typealias TokenRegularExpression = (NSRegularExpression, TokenBuilder) //swiftlint:disable:this nesting

    static let tokenList: [TokenRegularExpression] = tokenStringList.map {
      (try! NSRegularExpression(pattern: "^\($0.0)", options: []), $0.1) //swiftlint:disable:this force_try
    }

    /// Split input string to tokens
    static func tokenize(_ input: String) -> [Token] {
      var tokens = [Token]()
      var content = input
      while !content.isEmpty {
        var found = false
        for (regex, builder) in tokenList {
          if let (matched, range) = regex.matched(content) {
            if let token = builder(matched, range) {
              tokens.append(token)
            }
            // next content
            content = String(content[content.index(content.startIndex, offsetBy: matched.count)...])
            found = true
            break
          }
        }

        if !found {
          let index = content.index(content.startIndex, offsetBy: 1)
          let intIndex = content.distance(from: content.startIndex, to: index)
          tokens.append(.undefined(String(content[..<index]), intIndex..<intIndex + 1))
          content = String(content[index...])
        }
      }
      return tokens
    }
  }

  // MARK: - Nodes

  class Node: CustomStringConvertible, Equatable {
    var range: CountableRange<Int> = 0..<0
    let name: String

    init(name: String) {
      self.name = name
    }

    var description: String {
      return "\(type(of: self))(name: \"\(name)\")"
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
      return lhs.description == rhs.description
    }

  }

  class VariableNode: Node {}

  class NumberNode: Node {
    let value: Double

    init(value: Double) {
      self.value = value
      super.init(name: "\(value)")
    }

    override var description: String {
      return "\(type(of: self))(value: \(value))"
    }

    static func + (lhs: NumberNode, rhs: NumberNode) -> NumberNode {
      return NumberNode(value: lhs.value + rhs.value)
    }
  }

  class ArrayNode: Node {
    let elements: [Node]

    init(elements: [Node]) {
      self.elements = elements
      super.init(name: "array")
    }

    override var description: String {
      return "\(elements))"
    }
  }

  class BinaryOperatorNode: Node {
    let `operator`: Operator
    let lhs: Node
    let rhs: Node

    init(operator: Operator, lhs: Node, rhs: Node) {
      self.operator = `operator`
      self.lhs = lhs
      self.rhs = rhs
      super.init(name: `operator`.rawValue)
    }

    override var description: String {
      return "\(type(of: self))(name: \"\(name)\", lhs: \(lhs), rhs: \(rhs))"
    }

    func evaluate() -> Any? {
      return self.operator.evaluate(lhs: lhs, rhs: rhs)
    }
  }

  class CallNode: Node {
    let arguments: [Node]

    init(name: String, arguments: [Node]) {
      self.arguments = arguments
      super.init(name: name)
    }

    override var description: String {
      return "\(type(of: self))(name: \"\(name)\", arguments: \(arguments))"
    }
  }

  // MARK: - Parser

  enum ParseError: Error {
    case unexpectToken
    case expectCharacter(Character)
    case expectExpression(Token)
    case expectExpressionList
    case undefinedOperator(String)
  }

  /// User defined runtimes attribues parser.
  class Parser {

    let tokens: [Token]
    var currentIndex = 0

    init(tokens: [Token]) {
      self.tokens = tokens
    }

    // MARK: current token

    func currentToken() -> Token {
      if currentIndex >= tokens.count {
        return .undefined("", 0..<0)
      }
      return tokens[currentIndex]
    }

    @discardableResult
    func popCurrentToken() -> Token {
      defer { currentIndex += 1 }
      return tokens[currentIndex]
    }

    // MARK: parse

    func parse() throws -> [Node] {
      currentIndex = 0
      var nodes = [Node]()
      while currentIndex < tokens.count {
        let expr = try parseExpression()
        nodes.append(expr)
      }
      return nodes
    }

    func parseExpression() throws -> Node {
      let node = try parsePrimary()
      return try parseBinaryOperator(node: node)
    }

    func parsePrimary() throws -> Node {
      let currentToken = self.currentToken()
      switch currentToken {
      case .identifier:
        return try parseIdentifier()
      case .number:
        return try parseNumber()
      case .parenthesisOpen:
        return try parseParenthesis()
      case .bracketOpen:
        return try parseIdentifier()
      default:
        throw ParseError.expectExpression(currentToken)
      }
    }

    func parseNumber() throws -> Node {
      guard case let .number(value, _) = popCurrentToken() else {
        throw ParseError.unexpectToken
      }
      return NumberNode(value: value)
    }

    func parseParenthesis() throws -> Node {
      guard case .parenthesisOpen = popCurrentToken() else {
        throw ParseError.expectCharacter("(")
      }

      let exp = try parseExpression()

      guard case .parenthesisClose = popCurrentToken() else {
        throw ParseError.expectCharacter(")")
      }

      return exp
    }

    func parseBracket() throws -> Node {
      guard case .bracketOpen = currentToken() else {
        throw ParseError.expectCharacter("[")
      }

      let exp = try parseExpression()

      guard case .bracketClose = popCurrentToken() else {
        throw ParseError.expectCharacter("]")
      }

      return exp
    }

    func parseIdentifier() throws -> Node {
      let firstToken = popCurrentToken()
      switch firstToken {
      case .identifier(let name, _):
        guard case .parenthesisOpen = currentToken() else {
          return VariableNode(name: name)
        }
        popCurrentToken()
        var arguments = [Node]()
        if case .parenthesisClose = currentToken() {
        } else {
          while true {
            let argument = try parseExpression()
            arguments.append(argument)

            if case .parenthesisClose = currentToken() {
              break
            }

            guard case .comma = popCurrentToken() else {
              throw ParseError.expectCharacter(",")
            }
          }
        }
        popCurrentToken()
        return CallNode(name: name, arguments: arguments)
      case .bracketOpen:
        var elements = [Node]()
        if case .bracketClose = currentToken() {
        } else {
          while true {
            let node = try parseExpression()
            elements.append(node)

            if case .bracketClose = currentToken() {
              break
            }

            guard case .comma = popCurrentToken() else {
              throw ParseError.expectExpressionList
            }
          }
        }

        popCurrentToken()
        return ArrayNode(elements: elements)
      default:
        throw ParseError.unexpectToken
      }
    }

    func currentTokenPrecedence() throws -> Int {
      guard currentIndex < tokens.count else {
        return -1
      }

      if case let .undefined(op, _) = currentToken() {
        throw ParseError.undefinedOperator(op)
      }

      guard case let .operator(op, _) = currentToken() else {
        return -1
      }

      return op.precedence
    }

    func parseBinaryOperator(node: Node, exprPrecedence: Int = 0) throws -> Node {
      var lhs = node
      while true {
        let tokenPrecedence = try currentTokenPrecedence()
        if tokenPrecedence < exprPrecedence {
          return lhs
        }

        guard case let .operator(op, _) = popCurrentToken() else {
          throw ParseError.unexpectToken
        }

        var rhs = try parsePrimary()
        let nextPrecedence = try currentTokenPrecedence()

        if tokenPrecedence < nextPrecedence {
          rhs = try parseBinaryOperator(node: rhs, exprPrecedence: tokenPrecedence + 1)
        }
        lhs = BinaryOperatorNode(operator: op, lhs: lhs, rhs: rhs)
      }
    }

  }

}

// MARK: node extensions

extension Udra {
  typealias ParentNode = UdraParentNode
}

protocol UdraParentNode {
  var children: [Udra.Node] { get }
}

extension Udra.CallNode: UdraParentNode {
  var children: [Udra.Node] {
    return arguments
  }
}

extension Udra.ArrayNode: UdraParentNode {
  var children: [Udra.Node] {
    return elements
  }
}

extension Udra.BinaryOperatorNode: UdraParentNode {
  var children: [Udra.Node] {
    return [lhs, rhs]
  }
}

extension Udra.Operator {
  func evaluate(lhs: Udra.Node, rhs: Udra.Node) -> Any? {
    if let lhs = lhs as? Udra.NumberNode, let rhs = rhs as? Udra.NumberNode {
      switch self {
      case .plus:
        return lhs + rhs
      }
    }
    return nil
  }
}
