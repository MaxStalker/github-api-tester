import Operators from 0x01

pub contract LikeSystem {
  
  pub struct Minter: Operators.Operator {
    pub let name: String
    pub var vaultRef: &LikeVault?
    pub var nextOp: AnyStruct
    
    pub fun operate(data: {String: AnyStruct}): AnyStruct {
      if let sender = data["sender"]{
        log("Send some love to address")
        log(sender);

        // try to mint something here...
        if let vault = self.vaultRef{
          vault.mockMint();
        } 
      }

      // return nothing
      return nil
    }

    pub fun setNext(next: AnyStruct){
      self.nextOp = next
    }

    init(next: AnyStruct, ref: &LikeVault){
      self.nextOp = next
      self.vaultRef = ref
      self.name = "Operator: Like Minter"
    }
  }
  
  pub resource LikeVault {
    pub var balance: UInt64
    pub var mintOperator: Minter?

    pub fun deposit(from: @LikeVault){
      self.balance = self.balance + from.balance
      destroy from
    }
    
    pub fun withdraw(amount: UInt64):@LikeVault{
      self.balance = self.balance - amount
      return <- create LikeVault(balance: amount)
    }

    pub fun mockMint(){
      log("Here we will mint a token of appreciation for user")
    }

    pub fun initMintOperator(next: AnyStruct, ref: &LikeVault){
      self.mintOperator = Minter(next: next, ref: ref)
    }
    
    init(balance: UInt64){
      self.balance = balance
      self.mintOperator = nil
    }
  }

  pub fun createEmptyVault(): @LikeVault {
      return <-create LikeVault(balance: UInt64(10))
  }

  init(){
    // self.account.save(<-create LikeVault(balance))
  }
}
