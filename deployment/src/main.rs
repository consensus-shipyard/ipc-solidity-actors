use ethers::middleware::SignerMiddleware;
use ethers::prelude::{
    abigen, ContractDeployer, DeploymentTxFactory,
};
use ethers::providers::{Http, Provider};
use ethers::signers::{LocalWallet, Signer};
use ethers::solc::artifacts::{BytecodeObject};
use serde_json::Value;
use std::fs;
use std::{env, sync::Arc};
use url::Url;
use dotenv::dotenv;

// abigen!(Storage, "storage.json");
abigen!(
    SubnetIDHelper,
    "../out/SubnetIDHelper.sol/SubnetIDHelper.json",
);

#[tokio::main]
async fn main() {
    dotenv().ok();
    // for (key, value) in env::vars() {                                            
    //     println!("{}: {}", key, value);                                      
    // }
    let url = Url::parse(&env::var("RPC_URL").unwrap()).unwrap();
    let provider = Http::new(url);
    let provider = Provider::new(provider);
    let private_key_str = env::var("PRIVATE_KEY").unwrap();
    let wallet = private_key_str.parse::<LocalWallet>().unwrap();
    let wallet = wallet.with_chain_id(31415926u64);

    let signer = Arc::new(SignerMiddleware::new(provider, wallet));

    // Deploy libraries
    let contract_file = fs::read_to_string(
        "../out/SubnetIDHelper.sol/SubnetIDHelper.json",
    )
    .unwrap();
    let contract_data: Value =
        serde_json::from_str(&contract_file).expect("Failed to parse contract JSON");
    let abi = serde_json::from_str(&serde_json::to_string(&contract_data["abi"]).unwrap()).unwrap();
    // println!("Contract ABI: {:?}", contract_abi);

    let contract_bytecode = contract_data["bytecode"]["object"].to_string();
    let contract_bytecode = contract_bytecode.trim_matches('"');
    let contract_bytecode = contract_bytecode.trim_start_matches("0x");
    // println!("Contract bytecode: {:?}", contract_bytecode);
    let factory = DeploymentTxFactory::new(
        abi,
        ethers::types::Bytes::from(hex::decode(contract_bytecode).unwrap()),
        signer.clone(),
    );

    let contract = factory.deploy(()).unwrap();
    let contract: SubnetIDHelper<_> = ContractDeployer::new(contract)
        .gas(10000000000u64)
        .chain_id(3141) // 3141
        .send()
        .await
        .unwrap();
    println!("Contract SubnetIDHelper address: {:?}", contract.address());
    // ==================================================
    // Deploy and then link the library: solc --optimize --bin MetaCoin.sol | solc --link --libraries TestLib:<address>

    // let source = Path::new("/home/workspace/pl/filecoin-ipc-actors-fevm/src/SubnetActor.sol");
    // let compiled = Solc::default()
    //     .compile_source(source)
    //     .expect("Could not compile contracts");
    let contract_file = fs::read_to_string(
        "../out/SubnetActor.sol/SubnetActor.json",
    )
    .unwrap();
    let contract_data: Value =
        serde_json::from_str(&contract_file).expect("Failed to parse contract JSON");
    let abi = serde_json::from_str(&serde_json::to_string(&contract_data["abi"]).unwrap()).unwrap();
    // println!("Contract ABI: {:?}", contract_abi);

    let contract_bytecode = contract_data["bytecode"]["object"].to_string();
    let contract_bytecode = contract_bytecode.trim_matches('"');
    let contract_bytecode = contract_bytecode.trim_start_matches("0x");
    // println!("Contract bytecode: {:?}", contract_bytecode);
    let mut b = BytecodeObject::Unlinked(contract_bytecode.to_string());
    // b.link(&contract_file, "SubnetIDHelper", contract.address());
    // b.link(&contract_file, "CheckpointHelper", contract.address());
    // b.link(contract_file, "EpochVoteSubmission", contract.address());
    println!("{:?}", b.clone().into_unlinked().unwrap());
    let factory = DeploymentTxFactory::new(abi, b.clone().into_bytes().unwrap(), signer);

    let contract = factory.deploy(()).unwrap();
    let contract: SubnetIDHelper<_> = ContractDeployer::new(contract)
        .gas(10000000000u64)
        .chain_id(31415926)
        .send()
        .await
        .unwrap();
    println!("Contract SubnetActor address: {:?}", contract.address());
}