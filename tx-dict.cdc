import Controller from 0x01
import NewOperators from 0x03

transaction {
  prepare(acct: AuthAccount) {

  }

  execute {
    let subtract = NewOperators.Subtract();
    Controller.addAction(name: "subtract", op: subtract)    

    if let action = Controller.actions["subtract"]{
      if let op = action as? NewOperators.Subtract{
        log(op.name)
        let res = op.operate(operands: [8,3])
        log(res)
      }
    }

    if let action = Controller.actions["add"]{
      if let op = action as? Controller.AddOperator{
        log(op.name)
        let res = op.operate(operands: [8,3])
        log(res)
      }
    }
  }
}
