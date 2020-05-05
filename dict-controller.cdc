pub contract Controller {

    pub struct interface Operator {
      pub let name: String
      pub fun operate(operands: [AnyStruct]): AnyStruct
    }

    pub struct AddOperator: Operator {
        pub let name: String
        pub fun operate(operands: [AnyStruct]): AnyStruct {
          
          if let first = operands[0] as? Int{
            if let second = operands[1] as? Int{
              return first + second
            }
            return nil
          }
          return nil
        }

        init(){
          self.name = "Operator: Add"
        }
    }

    pub var actions: {String: AnyStruct}
    pub var strings: {String: Int}
    pub let name: String

    pub fun addAction(name: String, op: {Operator}){
      self.actions[name] = op
    }

    init() {
        self.actions = {"add": AddOperator()}
        self.strings = {"test": 42}
        self.name = "controller"
    }
}