pub contract Composable{

    // pub var taxOperator: TaxOperator

    pub resource Vault{
        pub var balance: UInt;
        init(balance: UInt){
            self.balance = balance
        }
    }



    pub resource TaxOperator{

        pub let vault: @Vault 
        pub var taxAmount: UInt // 13% of the total

        init(){
            // some initialization logic
            self.taxAmount = UInt(13)
            self.vault <- create Vault(UInt(0))
        }

        pub var taxVaultIncome(vault: @Vault): @Vault{
            return <- create Vault(balance: UInt(42))
        }
    }

    init(){
        // let vault <- create Vault();
        // self.account.save(<- vault, to: /storage/vault)
        log("Create basic composable contract")
    
        /*
            self.taxOperator = create
        */
    }
}