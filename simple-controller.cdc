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
          self.name = "Operator: Add"
        }
    }

    pub var operator: AnyStruct{Operator}
    pub let name: String

    pub fun setOperator(newOp: {Operator}){
      self.operator = newOp
    }

    init() {
        self.operator = AddOperator()
        self.name = "controller"
    }
}