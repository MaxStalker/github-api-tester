import Controller from 0x02
import NewOperators from 0x03

transaction {
  prepare(acct: AuthAccount) {

  }

  execute {
    log("start")
    let subtract = NewOperators.Subtract();
    Controller.setOperator(newOp: subtract)    

    if let operator = Controller.operator as? NewOperators.Subtract{
        log(operator.name)

        let sum = operator.operate(operands: [5,3])
        log(sum)
        }
    }
}
