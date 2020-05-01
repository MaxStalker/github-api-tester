import ChainController from 0x03

transaction {

  let chainRef: &ChainController.ChainLink
  let add: ((&ChainController.ChainLink): ((Int, Int): Int))

  prepare(acct: AuthAccount) {

    self.chainRef = acct.borrow<&ChainController.ChainLink>(from: /storage/ChainLink)!

    self.add = fun (link: &ChainController.ChainLink): ((Int, Int): Int) {
      log(link.testMe)
      return fun(a: Int, b: Int): Int{
        return a + b
      }
    }
    
  }

  execute {
    let a = 777
    self.chainRef.setItem(item: a)
    log(self.chainRef.item)

    let add = self.add(link: self.chainRef)
    log(add(3,5))

    // self.chainRef.changeOperator(ref: self.chainRef, newOperator: self.add)
  }
}
