pub use subnet_actor_manager_facet::*;
/// This module was auto-generated with ethers-rs Abigen.
/// More information at: <https://github.com/gakonst/ethers-rs>
#[allow(
    clippy::enum_variant_names,
    clippy::too_many_arguments,
    clippy::upper_case_acronyms,
    clippy::type_complexity,
    dead_code,
    non_camel_case_types
)]
pub mod subnet_actor_manager_facet {
    #[allow(deprecated)]
    fn __abi() -> ::ethers::core::abi::Abi {
        ::ethers::core::abi::ethabi::Contract {
            constructor: ::core::option::Option::None,
            functions: ::core::convert::From::from([
                (
                    ::std::borrow::ToOwned::to_owned("claim"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("claim"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("claimReward"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("claimReward"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("join"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("join"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("publicKey"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Bytes,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::Payable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("kill"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("kill"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("leave"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("leave"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("rewardValidators"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("rewardValidators"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("amount"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(
                                        256usize,
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("uint256"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("stake"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("stake"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::Payable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("submitCheckpoint"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("submitCheckpoint"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("checkpoint"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Tuple(
                                        ::std::vec![
                                            ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                ::std::vec![
                                                    ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                                    ::ethers::core::abi::ethabi::ParamType::Array(
                                                        ::std::boxed::Box::new(
                                                            ::ethers::core::abi::ethabi::ParamType::Address,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(32usize),
                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(32usize),
                                        ],
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned(
                                            "struct BottomUpCheckpoint",
                                        ),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("messages"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                ::std::vec![
                                                    ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                        ::std::vec![
                                                            ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                                ::std::vec![
                                                                    ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                                        ::std::vec![
                                                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                                                            ::ethers::core::abi::ethabi::ParamType::Array(
                                                                                ::std::boxed::Box::new(
                                                                                    ::ethers::core::abi::ethabi::ParamType::Address,
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                    ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                                        ::std::vec![
                                                                            ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                            ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                                ::std::vec![
                                                                    ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                                        ::std::vec![
                                                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                                                            ::ethers::core::abi::ethabi::ParamType::Array(
                                                                                ::std::boxed::Box::new(
                                                                                    ::ethers::core::abi::ethabi::ParamType::Address,
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                    ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                                        ::std::vec![
                                                                            ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize),
                                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                                        ],
                                                    ),
                                                    ::ethers::core::abi::ethabi::ParamType::Bool,
                                                ],
                                            ),
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("struct CrossMsg[]"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("signatories"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::Address,
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address[]"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("signatures"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes[]"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("validateActiveQuorumSignatures"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "validateActiveQuorumSignatures",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("signatories"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::Address,
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address[]"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("hash"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::FixedBytes(
                                        32usize,
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes32"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("signatures"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes[]"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
            ]),
            events: ::core::convert::From::from([
                (
                    ::std::borrow::ToOwned::to_owned("BottomUpCheckpointExecuted"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Event {
                            name: ::std::borrow::ToOwned::to_owned(
                                "BottomUpCheckpointExecuted",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::borrow::ToOwned::to_owned("epoch"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                    indexed: false,
                                },
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::borrow::ToOwned::to_owned("submitter"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    indexed: false,
                                },
                            ],
                            anonymous: false,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("BottomUpCheckpointSubmitted"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Event {
                            name: ::std::borrow::ToOwned::to_owned(
                                "BottomUpCheckpointSubmitted",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::borrow::ToOwned::to_owned("checkpoint"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Tuple(
                                        ::std::vec![
                                            ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                ::std::vec![
                                                    ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                                    ::ethers::core::abi::ethabi::ParamType::Array(
                                                        ::std::boxed::Box::new(
                                                            ::ethers::core::abi::ethabi::ParamType::Address,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(32usize),
                                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(32usize),
                                        ],
                                    ),
                                    indexed: false,
                                },
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::borrow::ToOwned::to_owned("submitter"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    indexed: false,
                                },
                            ],
                            anonymous: false,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NextBottomUpCheckpointExecuted"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Event {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NextBottomUpCheckpointExecuted",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::borrow::ToOwned::to_owned("epoch"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                    indexed: false,
                                },
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::borrow::ToOwned::to_owned("submitter"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    indexed: false,
                                },
                            ],
                            anonymous: false,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("SubnetBootstrapped"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Event {
                            name: ::std::borrow::ToOwned::to_owned("SubnetBootstrapped"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::EventParam {
                                    name: ::std::string::String::new(),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                ::std::vec![
                                                    ::ethers::core::abi::ethabi::ParamType::Address,
                                                    ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                                    ::ethers::core::abi::ethabi::ParamType::Bytes,
                                                ],
                                            ),
                                        ),
                                    ),
                                    indexed: false,
                                },
                            ],
                            anonymous: false,
                        },
                    ],
                ),
            ]),
            errors: ::core::convert::From::from([
                (
                    ::std::borrow::ToOwned::to_owned("AddressShouldBeValidator"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "AddressShouldBeValidator",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("CollateralIsZero"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("CollateralIsZero"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidCheckpointEpoch"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "InvalidCheckpointEpoch",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidCheckpointMessagesHash"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "InvalidCheckpointMessagesHash",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidSignatureErr"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "InvalidSignatureErr",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::string::String::new(),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("uint8"),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NoCollateralToWithdraw"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NoCollateralToWithdraw",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NoValidatorsInSubnet"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NoValidatorsInSubnet",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotAllValidatorsHaveLeft"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NotAllValidatorsHaveLeft",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotEnoughBalanceForRewards"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NotEnoughBalanceForRewards",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotGateway"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("NotGateway"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotOwnerOfPublicKey"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NotOwnerOfPublicKey",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotStakedBefore"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("NotStakedBefore"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotValidator"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("NotValidator"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("PQDoesNotContainAddress"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "PQDoesNotContainAddress",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("PQEmpty"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("PQEmpty"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("ReentrancyError"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("ReentrancyError"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("SubnetAlreadyKilled"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "SubnetAlreadyKilled",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("WithdrawExceedingCollateral"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "WithdrawExceedingCollateral",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
            ]),
            receive: false,
            fallback: false,
        }
    }
    ///The parsed JSON ABI of the contract.
    pub static SUBNETACTORMANAGERFACET_ABI: ::ethers::contract::Lazy<::ethers::core::abi::Abi> =
        ::ethers::contract::Lazy::new(__abi);
    pub struct SubnetActorManagerFacet<M>(::ethers::contract::Contract<M>);
    impl<M> ::core::clone::Clone for SubnetActorManagerFacet<M> {
        fn clone(&self) -> Self {
            Self(::core::clone::Clone::clone(&self.0))
        }
    }
    impl<M> ::core::ops::Deref for SubnetActorManagerFacet<M> {
        type Target = ::ethers::contract::Contract<M>;
        fn deref(&self) -> &Self::Target {
            &self.0
        }
    }
    impl<M> ::core::ops::DerefMut for SubnetActorManagerFacet<M> {
        fn deref_mut(&mut self) -> &mut Self::Target {
            &mut self.0
        }
    }
    impl<M> ::core::fmt::Debug for SubnetActorManagerFacet<M> {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            f.debug_tuple(::core::stringify!(SubnetActorManagerFacet))
                .field(&self.address())
                .finish()
        }
    }
    impl<M: ::ethers::providers::Middleware> SubnetActorManagerFacet<M> {
        /// Creates a new contract instance with the specified `ethers` client at
        /// `address`. The contract derefs to a `ethers::Contract` object.
        pub fn new<T: Into<::ethers::core::types::Address>>(
            address: T,
            client: ::std::sync::Arc<M>,
        ) -> Self {
            Self(::ethers::contract::Contract::new(
                address.into(),
                SUBNETACTORMANAGERFACET_ABI.clone(),
                client,
            ))
        }
        ///Calls the contract's `claim` (0x4e71d92d) function
        pub fn claim(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([78, 113, 217, 45], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `claimReward` (0xb88a802f) function
        pub fn claim_reward(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([184, 138, 128, 47], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `join` (0x6170b162) function
        pub fn join(
            &self,
            public_key: ::ethers::core::types::Bytes,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([97, 112, 177, 98], public_key)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `kill` (0x41c0e1b5) function
        pub fn kill(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([65, 192, 225, 181], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `leave` (0xd66d9e19) function
        pub fn leave(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([214, 109, 158, 25], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `rewardValidators` (0xa26fbc64) function
        pub fn reward_validators(
            &self,
            amount: ::ethers::core::types::U256,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([162, 111, 188, 100], amount)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `stake` (0x3a4b66f1) function
        pub fn stake(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([58, 75, 102, 241], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `submitCheckpoint` (0x0847be42) function
        pub fn submit_checkpoint(
            &self,
            checkpoint: BottomUpCheckpoint,
            messages: ::std::vec::Vec<CrossMsg>,
            signatories: ::std::vec::Vec<::ethers::core::types::Address>,
            signatures: ::std::vec::Vec<::ethers::core::types::Bytes>,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash(
                    [8, 71, 190, 66],
                    (checkpoint, messages, signatories, signatures),
                )
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `validateActiveQuorumSignatures` (0xcc2dc2b9) function
        pub fn validate_active_quorum_signatures(
            &self,
            signatories: ::std::vec::Vec<::ethers::core::types::Address>,
            hash: [u8; 32],
            signatures: ::std::vec::Vec<::ethers::core::types::Bytes>,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([204, 45, 194, 185], (signatories, hash, signatures))
                .expect("method not found (this should never happen)")
        }
        ///Gets the contract's `BottomUpCheckpointExecuted` event
        pub fn bottom_up_checkpoint_executed_filter(
            &self,
        ) -> ::ethers::contract::builders::Event<
            ::std::sync::Arc<M>,
            M,
            BottomUpCheckpointExecutedFilter,
        > {
            self.0.event()
        }
        ///Gets the contract's `BottomUpCheckpointSubmitted` event
        pub fn bottom_up_checkpoint_submitted_filter(
            &self,
        ) -> ::ethers::contract::builders::Event<
            ::std::sync::Arc<M>,
            M,
            BottomUpCheckpointSubmittedFilter,
        > {
            self.0.event()
        }
        ///Gets the contract's `NextBottomUpCheckpointExecuted` event
        pub fn next_bottom_up_checkpoint_executed_filter(
            &self,
        ) -> ::ethers::contract::builders::Event<
            ::std::sync::Arc<M>,
            M,
            NextBottomUpCheckpointExecutedFilter,
        > {
            self.0.event()
        }
        ///Gets the contract's `SubnetBootstrapped` event
        pub fn subnet_bootstrapped_filter(
            &self,
        ) -> ::ethers::contract::builders::Event<::std::sync::Arc<M>, M, SubnetBootstrappedFilter>
        {
            self.0.event()
        }
        /// Returns an `Event` builder for all the events of this contract.
        pub fn events(
            &self,
        ) -> ::ethers::contract::builders::Event<
            ::std::sync::Arc<M>,
            M,
            SubnetActorManagerFacetEvents,
        > {
            self.0
                .event_with_filter(::core::default::Default::default())
        }
    }
    impl<M: ::ethers::providers::Middleware> From<::ethers::contract::Contract<M>>
        for SubnetActorManagerFacet<M>
    {
        fn from(contract: ::ethers::contract::Contract<M>) -> Self {
            Self::new(contract.address(), contract.client())
        }
    }
    ///Custom Error type `AddressShouldBeValidator` with signature `AddressShouldBeValidator()` and selector `0x2a55ca53`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "AddressShouldBeValidator", abi = "AddressShouldBeValidator()")]
    pub struct AddressShouldBeValidator;
    ///Custom Error type `CollateralIsZero` with signature `CollateralIsZero()` and selector `0xb4f18b02`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "CollateralIsZero", abi = "CollateralIsZero()")]
    pub struct CollateralIsZero;
    ///Custom Error type `InvalidCheckpointEpoch` with signature `InvalidCheckpointEpoch()` and selector `0xfae4eadb`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "InvalidCheckpointEpoch", abi = "InvalidCheckpointEpoch()")]
    pub struct InvalidCheckpointEpoch;
    ///Custom Error type `InvalidCheckpointMessagesHash` with signature `InvalidCheckpointMessagesHash()` and selector `0xb5fdd40c`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(
        name = "InvalidCheckpointMessagesHash",
        abi = "InvalidCheckpointMessagesHash()"
    )]
    pub struct InvalidCheckpointMessagesHash;
    ///Custom Error type `InvalidSignatureErr` with signature `InvalidSignatureErr(uint8)` and selector `0x282ef1c1`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "InvalidSignatureErr", abi = "InvalidSignatureErr(uint8)")]
    pub struct InvalidSignatureErr(pub u8);
    ///Custom Error type `NoCollateralToWithdraw` with signature `NoCollateralToWithdraw()` and selector `0x64b0557f`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NoCollateralToWithdraw", abi = "NoCollateralToWithdraw()")]
    pub struct NoCollateralToWithdraw;
    ///Custom Error type `NoValidatorsInSubnet` with signature `NoValidatorsInSubnet()` and selector `0xefa9c8f1`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NoValidatorsInSubnet", abi = "NoValidatorsInSubnet()")]
    pub struct NoValidatorsInSubnet;
    ///Custom Error type `NotAllValidatorsHaveLeft` with signature `NotAllValidatorsHaveLeft()` and selector `0xd6c44aa2`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NotAllValidatorsHaveLeft", abi = "NotAllValidatorsHaveLeft()")]
    pub struct NotAllValidatorsHaveLeft;
    ///Custom Error type `NotEnoughBalanceForRewards` with signature `NotEnoughBalanceForRewards()` and selector `0x60e9957e`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(
        name = "NotEnoughBalanceForRewards",
        abi = "NotEnoughBalanceForRewards()"
    )]
    pub struct NotEnoughBalanceForRewards;
    ///Custom Error type `NotGateway` with signature `NotGateway()` and selector `0xe7e601db`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NotGateway", abi = "NotGateway()")]
    pub struct NotGateway;
    ///Custom Error type `NotOwnerOfPublicKey` with signature `NotOwnerOfPublicKey()` and selector `0x97d24a3a`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NotOwnerOfPublicKey", abi = "NotOwnerOfPublicKey()")]
    pub struct NotOwnerOfPublicKey;
    ///Custom Error type `NotStakedBefore` with signature `NotStakedBefore()` and selector `0x528fc165`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NotStakedBefore", abi = "NotStakedBefore()")]
    pub struct NotStakedBefore;
    ///Custom Error type `NotValidator` with signature `NotValidator()` and selector `0x2ec5b449`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "NotValidator", abi = "NotValidator()")]
    pub struct NotValidator;
    ///Custom Error type `PQDoesNotContainAddress` with signature `PQDoesNotContainAddress()` and selector `0xf2755e37`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "PQDoesNotContainAddress", abi = "PQDoesNotContainAddress()")]
    pub struct PQDoesNotContainAddress;
    ///Custom Error type `PQEmpty` with signature `PQEmpty()` and selector `0x40d9b011`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "PQEmpty", abi = "PQEmpty()")]
    pub struct PQEmpty;
    ///Custom Error type `ReentrancyError` with signature `ReentrancyError()` and selector `0x29f745a7`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "ReentrancyError", abi = "ReentrancyError()")]
    pub struct ReentrancyError;
    ///Custom Error type `SubnetAlreadyKilled` with signature `SubnetAlreadyKilled()` and selector `0x49191df6`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(name = "SubnetAlreadyKilled", abi = "SubnetAlreadyKilled()")]
    pub struct SubnetAlreadyKilled;
    ///Custom Error type `WithdrawExceedingCollateral` with signature `WithdrawExceedingCollateral()` and selector `0xac693603`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[etherror(
        name = "WithdrawExceedingCollateral",
        abi = "WithdrawExceedingCollateral()"
    )]
    pub struct WithdrawExceedingCollateral;
    ///Container type for all of the contract's custom errors
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetActorManagerFacetErrors {
        AddressShouldBeValidator(AddressShouldBeValidator),
        CollateralIsZero(CollateralIsZero),
        InvalidCheckpointEpoch(InvalidCheckpointEpoch),
        InvalidCheckpointMessagesHash(InvalidCheckpointMessagesHash),
        InvalidSignatureErr(InvalidSignatureErr),
        NoCollateralToWithdraw(NoCollateralToWithdraw),
        NoValidatorsInSubnet(NoValidatorsInSubnet),
        NotAllValidatorsHaveLeft(NotAllValidatorsHaveLeft),
        NotEnoughBalanceForRewards(NotEnoughBalanceForRewards),
        NotGateway(NotGateway),
        NotOwnerOfPublicKey(NotOwnerOfPublicKey),
        NotStakedBefore(NotStakedBefore),
        NotValidator(NotValidator),
        PQDoesNotContainAddress(PQDoesNotContainAddress),
        PQEmpty(PQEmpty),
        ReentrancyError(ReentrancyError),
        SubnetAlreadyKilled(SubnetAlreadyKilled),
        WithdrawExceedingCollateral(WithdrawExceedingCollateral),
        /// The standard solidity revert string, with selector
        /// Error(string) -- 0x08c379a0
        RevertString(::std::string::String),
    }
    impl ::ethers::core::abi::AbiDecode for SubnetActorManagerFacetErrors {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) =
                <::std::string::String as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::RevertString(decoded));
            }
            if let Ok(decoded) =
                <AddressShouldBeValidator as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::AddressShouldBeValidator(decoded));
            }
            if let Ok(decoded) = <CollateralIsZero as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::CollateralIsZero(decoded));
            }
            if let Ok(decoded) =
                <InvalidCheckpointEpoch as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InvalidCheckpointEpoch(decoded));
            }
            if let Ok(decoded) =
                <InvalidCheckpointMessagesHash as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InvalidCheckpointMessagesHash(decoded));
            }
            if let Ok(decoded) =
                <InvalidSignatureErr as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InvalidSignatureErr(decoded));
            }
            if let Ok(decoded) =
                <NoCollateralToWithdraw as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NoCollateralToWithdraw(decoded));
            }
            if let Ok(decoded) =
                <NoValidatorsInSubnet as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NoValidatorsInSubnet(decoded));
            }
            if let Ok(decoded) =
                <NotAllValidatorsHaveLeft as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NotAllValidatorsHaveLeft(decoded));
            }
            if let Ok(decoded) =
                <NotEnoughBalanceForRewards as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NotEnoughBalanceForRewards(decoded));
            }
            if let Ok(decoded) = <NotGateway as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::NotGateway(decoded));
            }
            if let Ok(decoded) =
                <NotOwnerOfPublicKey as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NotOwnerOfPublicKey(decoded));
            }
            if let Ok(decoded) = <NotStakedBefore as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::NotStakedBefore(decoded));
            }
            if let Ok(decoded) = <NotValidator as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::NotValidator(decoded));
            }
            if let Ok(decoded) =
                <PQDoesNotContainAddress as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::PQDoesNotContainAddress(decoded));
            }
            if let Ok(decoded) = <PQEmpty as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::PQEmpty(decoded));
            }
            if let Ok(decoded) = <ReentrancyError as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::ReentrancyError(decoded));
            }
            if let Ok(decoded) =
                <SubnetAlreadyKilled as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::SubnetAlreadyKilled(decoded));
            }
            if let Ok(decoded) =
                <WithdrawExceedingCollateral as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::WithdrawExceedingCollateral(decoded));
            }
            Err(::ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ::ethers::core::abi::AbiEncode for SubnetActorManagerFacetErrors {
        fn encode(self) -> ::std::vec::Vec<u8> {
            match self {
                Self::AddressShouldBeValidator(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CollateralIsZero(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::InvalidCheckpointEpoch(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InvalidCheckpointMessagesHash(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InvalidSignatureErr(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NoCollateralToWithdraw(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NoValidatorsInSubnet(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NotAllValidatorsHaveLeft(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NotEnoughBalanceForRewards(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NotGateway(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::NotOwnerOfPublicKey(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NotStakedBefore(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::NotValidator(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::PQDoesNotContainAddress(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::PQEmpty(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::ReentrancyError(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::SubnetAlreadyKilled(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::WithdrawExceedingCollateral(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::RevertString(s) => ::ethers::core::abi::AbiEncode::encode(s),
            }
        }
    }
    impl ::ethers::contract::ContractRevert for SubnetActorManagerFacetErrors {
        fn valid_selector(selector: [u8; 4]) -> bool {
            match selector {
                [0x08, 0xc3, 0x79, 0xa0] => true,
                _ if selector
                    == <AddressShouldBeValidator as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CollateralIsZero as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InvalidCheckpointEpoch as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InvalidCheckpointMessagesHash as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InvalidSignatureErr as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NoCollateralToWithdraw as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NoValidatorsInSubnet as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotAllValidatorsHaveLeft as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotEnoughBalanceForRewards as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotGateway as ::ethers::contract::EthError>::selector() => true,
                _ if selector
                    == <NotOwnerOfPublicKey as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotStakedBefore as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotValidator as ::ethers::contract::EthError>::selector() => true,
                _ if selector
                    == <PQDoesNotContainAddress as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <PQEmpty as ::ethers::contract::EthError>::selector() => true,
                _ if selector
                    == <ReentrancyError as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <SubnetAlreadyKilled as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <WithdrawExceedingCollateral as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ => false,
            }
        }
    }
    impl ::core::fmt::Display for SubnetActorManagerFacetErrors {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::AddressShouldBeValidator(element) => ::core::fmt::Display::fmt(element, f),
                Self::CollateralIsZero(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidCheckpointEpoch(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidCheckpointMessagesHash(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidSignatureErr(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoCollateralToWithdraw(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoValidatorsInSubnet(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotAllValidatorsHaveLeft(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotEnoughBalanceForRewards(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotGateway(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotOwnerOfPublicKey(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotStakedBefore(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotValidator(element) => ::core::fmt::Display::fmt(element, f),
                Self::PQDoesNotContainAddress(element) => ::core::fmt::Display::fmt(element, f),
                Self::PQEmpty(element) => ::core::fmt::Display::fmt(element, f),
                Self::ReentrancyError(element) => ::core::fmt::Display::fmt(element, f),
                Self::SubnetAlreadyKilled(element) => ::core::fmt::Display::fmt(element, f),
                Self::WithdrawExceedingCollateral(element) => ::core::fmt::Display::fmt(element, f),
                Self::RevertString(s) => ::core::fmt::Display::fmt(s, f),
            }
        }
    }
    impl ::core::convert::From<::std::string::String> for SubnetActorManagerFacetErrors {
        fn from(value: String) -> Self {
            Self::RevertString(value)
        }
    }
    impl ::core::convert::From<AddressShouldBeValidator> for SubnetActorManagerFacetErrors {
        fn from(value: AddressShouldBeValidator) -> Self {
            Self::AddressShouldBeValidator(value)
        }
    }
    impl ::core::convert::From<CollateralIsZero> for SubnetActorManagerFacetErrors {
        fn from(value: CollateralIsZero) -> Self {
            Self::CollateralIsZero(value)
        }
    }
    impl ::core::convert::From<InvalidCheckpointEpoch> for SubnetActorManagerFacetErrors {
        fn from(value: InvalidCheckpointEpoch) -> Self {
            Self::InvalidCheckpointEpoch(value)
        }
    }
    impl ::core::convert::From<InvalidCheckpointMessagesHash> for SubnetActorManagerFacetErrors {
        fn from(value: InvalidCheckpointMessagesHash) -> Self {
            Self::InvalidCheckpointMessagesHash(value)
        }
    }
    impl ::core::convert::From<InvalidSignatureErr> for SubnetActorManagerFacetErrors {
        fn from(value: InvalidSignatureErr) -> Self {
            Self::InvalidSignatureErr(value)
        }
    }
    impl ::core::convert::From<NoCollateralToWithdraw> for SubnetActorManagerFacetErrors {
        fn from(value: NoCollateralToWithdraw) -> Self {
            Self::NoCollateralToWithdraw(value)
        }
    }
    impl ::core::convert::From<NoValidatorsInSubnet> for SubnetActorManagerFacetErrors {
        fn from(value: NoValidatorsInSubnet) -> Self {
            Self::NoValidatorsInSubnet(value)
        }
    }
    impl ::core::convert::From<NotAllValidatorsHaveLeft> for SubnetActorManagerFacetErrors {
        fn from(value: NotAllValidatorsHaveLeft) -> Self {
            Self::NotAllValidatorsHaveLeft(value)
        }
    }
    impl ::core::convert::From<NotEnoughBalanceForRewards> for SubnetActorManagerFacetErrors {
        fn from(value: NotEnoughBalanceForRewards) -> Self {
            Self::NotEnoughBalanceForRewards(value)
        }
    }
    impl ::core::convert::From<NotGateway> for SubnetActorManagerFacetErrors {
        fn from(value: NotGateway) -> Self {
            Self::NotGateway(value)
        }
    }
    impl ::core::convert::From<NotOwnerOfPublicKey> for SubnetActorManagerFacetErrors {
        fn from(value: NotOwnerOfPublicKey) -> Self {
            Self::NotOwnerOfPublicKey(value)
        }
    }
    impl ::core::convert::From<NotStakedBefore> for SubnetActorManagerFacetErrors {
        fn from(value: NotStakedBefore) -> Self {
            Self::NotStakedBefore(value)
        }
    }
    impl ::core::convert::From<NotValidator> for SubnetActorManagerFacetErrors {
        fn from(value: NotValidator) -> Self {
            Self::NotValidator(value)
        }
    }
    impl ::core::convert::From<PQDoesNotContainAddress> for SubnetActorManagerFacetErrors {
        fn from(value: PQDoesNotContainAddress) -> Self {
            Self::PQDoesNotContainAddress(value)
        }
    }
    impl ::core::convert::From<PQEmpty> for SubnetActorManagerFacetErrors {
        fn from(value: PQEmpty) -> Self {
            Self::PQEmpty(value)
        }
    }
    impl ::core::convert::From<ReentrancyError> for SubnetActorManagerFacetErrors {
        fn from(value: ReentrancyError) -> Self {
            Self::ReentrancyError(value)
        }
    }
    impl ::core::convert::From<SubnetAlreadyKilled> for SubnetActorManagerFacetErrors {
        fn from(value: SubnetAlreadyKilled) -> Self {
            Self::SubnetAlreadyKilled(value)
        }
    }
    impl ::core::convert::From<WithdrawExceedingCollateral> for SubnetActorManagerFacetErrors {
        fn from(value: WithdrawExceedingCollateral) -> Self {
            Self::WithdrawExceedingCollateral(value)
        }
    }
    #[derive(
        Clone,
        ::ethers::contract::EthEvent,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethevent(
        name = "BottomUpCheckpointExecuted",
        abi = "BottomUpCheckpointExecuted(uint64,address)"
    )]
    pub struct BottomUpCheckpointExecutedFilter {
        pub epoch: u64,
        pub submitter: ::ethers::core::types::Address,
    }
    #[derive(
        Clone,
        ::ethers::contract::EthEvent,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethevent(
        name = "BottomUpCheckpointSubmitted",
        abi = "BottomUpCheckpointSubmitted(((uint64,address[]),uint64,bytes32,uint64,bytes32),address)"
    )]
    pub struct BottomUpCheckpointSubmittedFilter {
        pub checkpoint: BottomUpCheckpoint,
        pub submitter: ::ethers::core::types::Address,
    }
    #[derive(
        Clone,
        ::ethers::contract::EthEvent,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethevent(
        name = "NextBottomUpCheckpointExecuted",
        abi = "NextBottomUpCheckpointExecuted(uint64,address)"
    )]
    pub struct NextBottomUpCheckpointExecutedFilter {
        pub epoch: u64,
        pub submitter: ::ethers::core::types::Address,
    }
    #[derive(
        Clone,
        ::ethers::contract::EthEvent,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethevent(
        name = "SubnetBootstrapped",
        abi = "SubnetBootstrapped((address,uint256,bytes)[])"
    )]
    pub struct SubnetBootstrappedFilter(pub ::std::vec::Vec<GenesisValidator>);
    ///Container type for all of the contract's events
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetActorManagerFacetEvents {
        BottomUpCheckpointExecutedFilter(BottomUpCheckpointExecutedFilter),
        BottomUpCheckpointSubmittedFilter(BottomUpCheckpointSubmittedFilter),
        NextBottomUpCheckpointExecutedFilter(NextBottomUpCheckpointExecutedFilter),
        SubnetBootstrappedFilter(SubnetBootstrappedFilter),
    }
    impl ::ethers::contract::EthLogDecode for SubnetActorManagerFacetEvents {
        fn decode_log(
            log: &::ethers::core::abi::RawLog,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::Error> {
            if let Ok(decoded) = BottomUpCheckpointExecutedFilter::decode_log(log) {
                return Ok(
                    SubnetActorManagerFacetEvents::BottomUpCheckpointExecutedFilter(decoded),
                );
            }
            if let Ok(decoded) = BottomUpCheckpointSubmittedFilter::decode_log(log) {
                return Ok(
                    SubnetActorManagerFacetEvents::BottomUpCheckpointSubmittedFilter(decoded),
                );
            }
            if let Ok(decoded) = NextBottomUpCheckpointExecutedFilter::decode_log(log) {
                return Ok(
                    SubnetActorManagerFacetEvents::NextBottomUpCheckpointExecutedFilter(decoded),
                );
            }
            if let Ok(decoded) = SubnetBootstrappedFilter::decode_log(log) {
                return Ok(SubnetActorManagerFacetEvents::SubnetBootstrappedFilter(
                    decoded,
                ));
            }
            Err(::ethers::core::abi::Error::InvalidData)
        }
    }
    impl ::core::fmt::Display for SubnetActorManagerFacetEvents {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::BottomUpCheckpointExecutedFilter(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::BottomUpCheckpointSubmittedFilter(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::NextBottomUpCheckpointExecutedFilter(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::SubnetBootstrappedFilter(element) => ::core::fmt::Display::fmt(element, f),
            }
        }
    }
    impl ::core::convert::From<BottomUpCheckpointExecutedFilter> for SubnetActorManagerFacetEvents {
        fn from(value: BottomUpCheckpointExecutedFilter) -> Self {
            Self::BottomUpCheckpointExecutedFilter(value)
        }
    }
    impl ::core::convert::From<BottomUpCheckpointSubmittedFilter> for SubnetActorManagerFacetEvents {
        fn from(value: BottomUpCheckpointSubmittedFilter) -> Self {
            Self::BottomUpCheckpointSubmittedFilter(value)
        }
    }
    impl ::core::convert::From<NextBottomUpCheckpointExecutedFilter> for SubnetActorManagerFacetEvents {
        fn from(value: NextBottomUpCheckpointExecutedFilter) -> Self {
            Self::NextBottomUpCheckpointExecutedFilter(value)
        }
    }
    impl ::core::convert::From<SubnetBootstrappedFilter> for SubnetActorManagerFacetEvents {
        fn from(value: SubnetBootstrappedFilter) -> Self {
            Self::SubnetBootstrappedFilter(value)
        }
    }
    ///Container type for all input parameters for the `claim` function with signature `claim()` and selector `0x4e71d92d`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "claim", abi = "claim()")]
    pub struct ClaimCall;
    ///Container type for all input parameters for the `claimReward` function with signature `claimReward()` and selector `0xb88a802f`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "claimReward", abi = "claimReward()")]
    pub struct ClaimRewardCall;
    ///Container type for all input parameters for the `join` function with signature `join(bytes)` and selector `0x6170b162`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "join", abi = "join(bytes)")]
    pub struct JoinCall {
        pub public_key: ::ethers::core::types::Bytes,
    }
    ///Container type for all input parameters for the `kill` function with signature `kill()` and selector `0x41c0e1b5`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "kill", abi = "kill()")]
    pub struct KillCall;
    ///Container type for all input parameters for the `leave` function with signature `leave()` and selector `0xd66d9e19`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "leave", abi = "leave()")]
    pub struct LeaveCall;
    ///Container type for all input parameters for the `rewardValidators` function with signature `rewardValidators(uint256)` and selector `0xa26fbc64`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "rewardValidators", abi = "rewardValidators(uint256)")]
    pub struct RewardValidatorsCall {
        pub amount: ::ethers::core::types::U256,
    }
    ///Container type for all input parameters for the `stake` function with signature `stake()` and selector `0x3a4b66f1`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(name = "stake", abi = "stake()")]
    pub struct StakeCall;
    ///Container type for all input parameters for the `submitCheckpoint` function with signature `submitCheckpoint(((uint64,address[]),uint64,bytes32,uint64,bytes32),((((uint64,address[]),(uint8,bytes)),((uint64,address[]),(uint8,bytes)),uint256,uint64,bytes4,bytes),bool)[],address[],bytes[])` and selector `0x0847be42`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(
        name = "submitCheckpoint",
        abi = "submitCheckpoint(((uint64,address[]),uint64,bytes32,uint64,bytes32),((((uint64,address[]),(uint8,bytes)),((uint64,address[]),(uint8,bytes)),uint256,uint64,bytes4,bytes),bool)[],address[],bytes[])"
    )]
    pub struct SubmitCheckpointCall {
        pub checkpoint: BottomUpCheckpoint,
        pub messages: ::std::vec::Vec<CrossMsg>,
        pub signatories: ::std::vec::Vec<::ethers::core::types::Address>,
        pub signatures: ::std::vec::Vec<::ethers::core::types::Bytes>,
    }
    ///Container type for all input parameters for the `validateActiveQuorumSignatures` function with signature `validateActiveQuorumSignatures(address[],bytes32,bytes[])` and selector `0xcc2dc2b9`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    #[ethcall(
        name = "validateActiveQuorumSignatures",
        abi = "validateActiveQuorumSignatures(address[],bytes32,bytes[])"
    )]
    pub struct ValidateActiveQuorumSignaturesCall {
        pub signatories: ::std::vec::Vec<::ethers::core::types::Address>,
        pub hash: [u8; 32],
        pub signatures: ::std::vec::Vec<::ethers::core::types::Bytes>,
    }
    ///Container type for all of the contract's call
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetActorManagerFacetCalls {
        Claim(ClaimCall),
        ClaimReward(ClaimRewardCall),
        Join(JoinCall),
        Kill(KillCall),
        Leave(LeaveCall),
        RewardValidators(RewardValidatorsCall),
        Stake(StakeCall),
        SubmitCheckpoint(SubmitCheckpointCall),
        ValidateActiveQuorumSignatures(ValidateActiveQuorumSignaturesCall),
    }
    impl ::ethers::core::abi::AbiDecode for SubnetActorManagerFacetCalls {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) = <ClaimCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Claim(decoded));
            }
            if let Ok(decoded) = <ClaimRewardCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::ClaimReward(decoded));
            }
            if let Ok(decoded) = <JoinCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Join(decoded));
            }
            if let Ok(decoded) = <KillCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Kill(decoded));
            }
            if let Ok(decoded) = <LeaveCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Leave(decoded));
            }
            if let Ok(decoded) =
                <RewardValidatorsCall as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::RewardValidators(decoded));
            }
            if let Ok(decoded) = <StakeCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Stake(decoded));
            }
            if let Ok(decoded) =
                <SubmitCheckpointCall as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::SubmitCheckpoint(decoded));
            }
            if let Ok(decoded) =
                <ValidateActiveQuorumSignaturesCall as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::ValidateActiveQuorumSignatures(decoded));
            }
            Err(::ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ::ethers::core::abi::AbiEncode for SubnetActorManagerFacetCalls {
        fn encode(self) -> Vec<u8> {
            match self {
                Self::Claim(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::ClaimReward(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Join(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Kill(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Leave(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::RewardValidators(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Stake(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::SubmitCheckpoint(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::ValidateActiveQuorumSignatures(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
            }
        }
    }
    impl ::core::fmt::Display for SubnetActorManagerFacetCalls {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::Claim(element) => ::core::fmt::Display::fmt(element, f),
                Self::ClaimReward(element) => ::core::fmt::Display::fmt(element, f),
                Self::Join(element) => ::core::fmt::Display::fmt(element, f),
                Self::Kill(element) => ::core::fmt::Display::fmt(element, f),
                Self::Leave(element) => ::core::fmt::Display::fmt(element, f),
                Self::RewardValidators(element) => ::core::fmt::Display::fmt(element, f),
                Self::Stake(element) => ::core::fmt::Display::fmt(element, f),
                Self::SubmitCheckpoint(element) => ::core::fmt::Display::fmt(element, f),
                Self::ValidateActiveQuorumSignatures(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
            }
        }
    }
    impl ::core::convert::From<ClaimCall> for SubnetActorManagerFacetCalls {
        fn from(value: ClaimCall) -> Self {
            Self::Claim(value)
        }
    }
    impl ::core::convert::From<ClaimRewardCall> for SubnetActorManagerFacetCalls {
        fn from(value: ClaimRewardCall) -> Self {
            Self::ClaimReward(value)
        }
    }
    impl ::core::convert::From<JoinCall> for SubnetActorManagerFacetCalls {
        fn from(value: JoinCall) -> Self {
            Self::Join(value)
        }
    }
    impl ::core::convert::From<KillCall> for SubnetActorManagerFacetCalls {
        fn from(value: KillCall) -> Self {
            Self::Kill(value)
        }
    }
    impl ::core::convert::From<LeaveCall> for SubnetActorManagerFacetCalls {
        fn from(value: LeaveCall) -> Self {
            Self::Leave(value)
        }
    }
    impl ::core::convert::From<RewardValidatorsCall> for SubnetActorManagerFacetCalls {
        fn from(value: RewardValidatorsCall) -> Self {
            Self::RewardValidators(value)
        }
    }
    impl ::core::convert::From<StakeCall> for SubnetActorManagerFacetCalls {
        fn from(value: StakeCall) -> Self {
            Self::Stake(value)
        }
    }
    impl ::core::convert::From<SubmitCheckpointCall> for SubnetActorManagerFacetCalls {
        fn from(value: SubmitCheckpointCall) -> Self {
            Self::SubmitCheckpoint(value)
        }
    }
    impl ::core::convert::From<ValidateActiveQuorumSignaturesCall> for SubnetActorManagerFacetCalls {
        fn from(value: ValidateActiveQuorumSignaturesCall) -> Self {
            Self::ValidateActiveQuorumSignatures(value)
        }
    }
    ///`BottomUpCheckpoint((uint64,address[]),uint64,bytes32,uint64,bytes32)`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct BottomUpCheckpoint {
        pub subnet_id: SubnetID,
        pub block_height: u64,
        pub block_hash: [u8; 32],
        pub next_configuration_number: u64,
        pub cross_messages_hash: [u8; 32],
    }
    ///`CrossMsg((((uint64,address[]),(uint8,bytes)),((uint64,address[]),(uint8,bytes)),uint256,uint64,bytes4,bytes),bool)`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct CrossMsg {
        pub message: StorableMsg,
        pub wrapped: bool,
    }
    ///`FvmAddress(uint8,bytes)`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct FvmAddress {
        pub addr_type: u8,
        pub payload: ::ethers::core::types::Bytes,
    }
    ///`GenesisValidator(address,uint256,bytes)`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct GenesisValidator {
        pub addr: ::ethers::core::types::Address,
        pub collateral: ::ethers::core::types::U256,
        pub metadata: ::ethers::core::types::Bytes,
    }
    ///`Ipcaddress((uint64,address[]),(uint8,bytes))`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct Ipcaddress {
        pub subnet_id: SubnetID,
        pub raw_address: FvmAddress,
    }
    ///`StorableMsg(((uint64,address[]),(uint8,bytes)),((uint64,address[]),(uint8,bytes)),uint256,uint64,bytes4,bytes)`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct StorableMsg {
        pub from: Ipcaddress,
        pub to: Ipcaddress,
        pub value: ::ethers::core::types::U256,
        pub nonce: u64,
        pub method: [u8; 4],
        pub params: ::ethers::core::types::Bytes,
    }
    ///`SubnetID(uint64,address[])`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash,
    )]
    pub struct SubnetID {
        pub root: u64,
        pub route: ::std::vec::Vec<::ethers::core::types::Address>,
    }
}
