import Controller from 0x01

pub contract NewOperators {
    pub struct Subtract: Controller.Operator {
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

        init(){
          self.name = "Operator: Subtract"
        }
    }

    pub struct NewRandom: Controller.Operator {
      pub let name: String
      pub fun operate(operands: [AnyStruct]): AnyStruct{
        // let's pretend this is new random function
        return 2
      }
      init(){
        self.name = "Operator: Subtract"
      }
    }
}