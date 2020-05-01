import ChainController from 0x03

transaction {

  let chainRef: &ChainController.ChainLink
  let add: ((&ChainController.ChainLink): AnyStruct)

  prepare(acct: AuthAccount) {

    self.chainRef = acct.borrow<&ChainController.ChainLink>(from: /storage/ChainLink)!

    self.add = fun (link: &ChainController.ChainLink): ((Int, Int): Int) {
      return fun(a: Int, b: Int): Int{
        return a + b
      }
    }
    
  }

  execute {
    let a = 132
    self.chainRef.setItem(item: a)
    self.chainRef.changeOperator(ref: self.chainRef, newOperator: self.add)
    log(self.chainRef.item)
  }
}
