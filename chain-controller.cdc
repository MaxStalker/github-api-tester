pub contract ChainController{

  // Below here you can find a ChainLink
  pub resource ChainLink{
    pub let next: @ChainLink?
    pub var operator: AnyStruct?
    pub let testMe: Int
    
    pub fun changeOperator(newOperator: ((&ChainLink):AnyStruct) ): Void{
      log("let's spicy things up")
      let ref: &ChainLink = &self as &ChainLink
      self.operator = newOperator(ref) 
    }

    init(){
      self.operator = nil
      self.next <- nil
      self.testMe = 42
    }

    destroy(){
      destroy self.next
    }
  }
  

  // Ths is contract init function
  init(){  
    log("Chain Controller created")
    let chain <- create ChainLink()
    self.account.save(<-chain, to: /storage/ChainLink)
    // self.account.link<&ChainLink>(/private/ChainLink, target: /storage/ChainLink)

/*
    // maybe
    let ref:&ChainLink = &chain as &ChainLink
    
    let addExposed = addition(ref)
    let result = addExposed(2,5)
    log(result)
    
    log("it works!")
    */
  }
}