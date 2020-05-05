import Controller from 0x01
import NewOperators from 0x03

transaction {
  prepare(acct: AuthAccount) {

  }

  execute {
    let subtract = NewOperators.Subtract();
    Controller.addAction(name: "subtract", op: subtract)    
    log(Controller.actions.length)
    log(Controller.actions.keys)
    log(Controller.actions["subtract"])
    
    if let action = Controller.actions["subtract"] as? NewOperators.Subtract{
      // log(sub.name)

      let sum = action.operate(operands: [8,3])
      log(sum)
    }
    /*
    if let add = Controller.actions["add"] as? Controller.AddOperator{
      // log(add.name)

      let sum = add.operate(operands: [5,3])
      log(sum)
    }
    */
  }
}
