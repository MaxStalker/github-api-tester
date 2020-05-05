import LikeSystem from 0x03

transaction{
    prepare(acct: AuthAccount){
        let vault <- LikeSystem.createEmptyVault()

        acct.save<@LikeSystem.LikeVault>(<-vault, to: /storage/LikeVault)
        log("Empty Vault created")

        let ReceiverRef = acct
            .link<&LikeSystem.LikeVault>(
                /public/LikeVault, 
                target: /storage/LikeVault)
        log("References created") 
    }

    /*
    execute(){

    }
    */

    post{
        getAccount(0x01).getCapability(/public/LikeVault)!
            .check<&LikeSystem.LikeVault>():  
            "Vault Receiver Reference was not created correctly"
    }
}