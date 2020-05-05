// Deposit to account from minter
// Instructions : Use account 0x02

import FungibleToken from 0x02

transaction{
    let minterRef: &FungibleToken.ProgVaultMinter
    let receiverRef: &FungibleToken.ProgrammableVault{FungibleToken.Receiver}

    prepare(acct: AuthAccount){
        self.minterRef = acct.borrow<&FungibleToken.ProgVaultMinter>(from: /storage/ProgVaultMinter) 
                         ?? panic("No Vault minter stored there...")
        
        let recipient = getAccount(0x01)
        let capability = recipient.getCapability(/public/ProgVault)!
        
        self.receiverRef = capability.borrow<&FungibleToken.ProgrammableVault{FungibleToken.Receiver}>()!
    }

    execute{
        self.minterRef.mintTokens(amount: UInt64(100), recipient: self.receiverRef)
        log("100 tokens were deposited to account 0x01")
    }
}