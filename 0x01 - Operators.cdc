pub contract Operators {

    pub struct interface Operator {
      pub let name: String
      pub var nextOp: AnyStruct
      
      pub fun operate(data: {String: AnyStruct}): AnyStruct
      pub fun setNext(next: AnyStruct)
    }

    pub struct Notify: Operator {
      pub let name: String
      pub var nextOp: AnyStruct

      pub fun setNext(next: AnyStruct){
        self.nextOp = next
      }

      pub fun operate(data: {String: AnyStruct}): AnyStruct{
        if let amount = data["amount"]{
          log("New deposit arrived:")
          log(amount);
        }

        // add as PublicAccount
        if let sender = data["sender"]{
          log("Depositor address:")
          log(sender);
        }

        if let next = self.nextOp as? {Operator}{
          next.operate(data: data)
        }

        return nil
      }

      init(next: AnyStruct){
        self.nextOp = next
        self.name = "Operator: Notify"
      }
    }
}