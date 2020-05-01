pub contract VaultSupervisor{
    pub resource Vault{
        pub var balance: UInt;

        init(balance: UInt){
            self.balance = balance
        }

        pub fun withdraw(amount: UInt): @Vault{
          self.balance = self.balance - amount
          return <- create Vault(balance: amount)
        }
    }
    
    pub fun createEmptyVault(): @Vault{
      return <- create Vault(balance: UInt(0))
    }
    
    init(){
      // here we probably need to handle
      log("hello world")
    }
}