pub contract VaultSupervisor{

    pub resource Vault{
        pub var balance: UInt;
        init(balance: UInt){
            self.balance = balance
        }

        pub fun withdraw(amount: UInt)
    }


    pub resource VaultMinter{

    }

    init(){
      // here we probably need to handle
    }
}