import LikeSystem from 0x04

// This script reads the Vault balances of two accounts.
pub fun main() {
    // Get the accounts' public account objects
    let acct1 = getAccount(0x01)

    // Get references to the account's receivers
    // by getting their public capability
    // and borrowing a reference from the capability
    let vaultRef = acct1.getCapability(/public/LikeVault)!
                            .borrow<&LikeSystem.LikeVault>()!

    // Use optional chaining to read and log balance fields
    log("Account 1 Balance")
  	log(vaultRef.balance)
}
