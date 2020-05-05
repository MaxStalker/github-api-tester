pub contract Operators {

    pub struct interface Operator {
      pub let name: String
      pub var nextOp: AnyStruct
      
      pub fun operate(operands: [AnyStruct]): AnyStruct
      pub fun setNext(next: AnyStruct)
    }

    pub struct Notify: Operator {
      pub let name: String
      pub var nextOp: AnyStruct

      pub fun setNext(next: AnyStruct){
        self.nextOp = next
      }

      pub fun operate(operands: [AnyStruct]): AnyStruct{
        if let deposit = operands[0] as? UInt64{
          log("New deposit arrived:")
          log(deposit);
        }

        if let next = self.nextOp as? {Operator}{
          next.operate(operands: operands)
        }

        return nil
      }

      init(next: AnyStruct){
        self.nextOp = next
        self.name = "Operator: Notify"
      }
    }

    /*
    pub struct Subtract: Operator {
        pub let name: String
        pub fun operate(operands: [AnyStruct]): AnyStruct {
          
          if let first = operands[0] as? Int{
            if let second = operands[1] as? Int{
              return first - second
            }
            return nil
          }
          return nil
        }

        init(next: AnyStruct){
          self.name = "Operator: Subtract"
          self.nextOp = next
        }
    }

    pub struct NewRandom: Operator {
      pub let name: String
      pub fun operate(operands: [AnyStruct]): AnyStruct{
        // let's pretend this is new random function
        return 2
      }
      init(next: AnyStruct){
        self.nextOp = next
        self.name = "Operator: Subtract"
      }
    }
    */
}