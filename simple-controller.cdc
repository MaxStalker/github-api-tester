pub contract Controller {

    pub struct interface Operator {
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
          self.name = "hello"
        }
    }

    pub struct BaseStruct{
      pub let name: String

      init(){
        self.name = "bazinga"
      }
    }

    pub var operator: {Operator}?
    pub let baseStruct: BaseStruct
    pub let name: String

    pub fun setOperator(newOp: {Operator}){
      self.operator = newOp
    }

    init() {
        self.operator = AddOperator()
        self.baseStruct = BaseStruct()
        self.name = "controller"
    }
}