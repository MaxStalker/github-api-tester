// Create Empty Vault for account

import FungibleToken from 0x02

transaction{
    prepare(acct: AuthAccount){
        let progVault <- FungibleToken.createEmptyVault()

        acct.save<@FungibleToken.ProgrammableVault>(<-progVault, to: /storage/ProgVault)
        log("Empty Vault created")

        let ReceiverRef = acct
            .link<&FungibleToken.ProgrammableVault{FungibleToken.Receiver, FungibleToken.Balance}>(
                /public/ProgVault, 
                target: /storage/ProgVault)
        log("References created") 
    }

    /*
    execute(){

    }
    */

    post{
        getAccount(0x01).getCapability(/public/ProgVault)!
            .check<&FungibleToken.ProgrammableVault{FungibleToken.Receiver}>():  
            "Vault Receiver Reference was not created correctly"
    }
}