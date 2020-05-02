pub contract Controller {

    pub struct interface Operator {
        pub fun operate(operands: [AnyStruct]): Int
    }

    pub struct AddOperator: Operator {
        pub fun operate(operands: [AnyStruct]): Int {
          let items = operands as [Int]
          return items[0] + items[1]
        }
    }

    pub var operator: {Operator}?

    pub fun setOperator(newOp: AnyStruct{Operator}){
      self.operator = newOp
    }

    init() {
        self.operator = AddOperator()
    }
}