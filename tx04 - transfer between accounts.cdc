import FungibleToken from 0x02

transaction{
    let senderRef: &FungibleToken.ProgrammableVault{FungibleToken.Depositor}
    let receiverRef: &FungibleToken.ProgrammableVault{FungibleToken.Receiver}

    prepare(acct: AuthAccount){
        
        let recipient = getAccount(0x02)
                .getCapability(/public/ProgVault)!
                .borrow<&FungibleToken.ProgrammableVault{FungibleToken.Receiver}>()!
    }

    execute{
        self.minterRef.mintTokens(amount: UInt64(100), recipient: self.receiverRef)
        log("100 tokens were deposited to account 0x02")
    }
}