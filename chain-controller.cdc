pub contract ChainController{

  pub resource ChainLink{
    pub let next: @ChainLink?
    pub var operator: AnyStruct?
    
    pub fun changeOperator(newOperator: ((&ChainLink):AnyStruct) ): Void{
      log("let's spicy things up")
      let ref: &ChainLink = &self as &ChainLink
      self.operator = newOperator(ref) 
    }

    init(){
      self.operator = nil
      self.next <- nil
    }

    destroy(){
      destroy self.next
    }
  }
  

  init(){
    log("Chain Controller created")
  }
}