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
                    ::std::borrow::ToOwned::to_owned("getValidator"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("getValidator"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("validatorAddress"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("validator"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Tuple(
                                        ::std::vec![
                                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                        ],
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("struct Validator"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
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
                                    name: ::std::borrow::ToOwned::to_owned("netAddr"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::String,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("string"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("workerAddr"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Tuple(
                                        ::std::vec![
                                            ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                        ],
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("struct FvmAddress"),
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
                    ::std::borrow::ToOwned::to_owned("join2"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("join2"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("data"),
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
                    ::std::borrow::ToOwned::to_owned("kill2"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("kill2"),
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
                    ::std::borrow::ToOwned::to_owned("leave2"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("leave2"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("reward"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("reward"),
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
                    ::std::borrow::ToOwned::to_owned("setMetadata"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("setMetadata"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("metadata"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Bytes,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes"),
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
                    ::std::borrow::ToOwned::to_owned("setValidatorNetAddr"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "setValidatorNetAddr",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("newNetAddr"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::String,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("string"),
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
                    ::std::borrow::ToOwned::to_owned("setValidatorWorkerAddr"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "setValidatorWorkerAddr",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("newWorkerAddr"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Tuple(
                                        ::std::vec![
                                            ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                            ::ethers::core::abi::ethabi::ParamType::Bytes,
                                        ],
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("struct FvmAddress"),
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
                (
                    ::std::borrow::ToOwned::to_owned("withdraw"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("withdraw"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
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
            ]),
            errors: ::core::convert::From::from([
                (
                    ::std::borrow::ToOwned::to_owned("AddressInsufficientBalance"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "AddressInsufficientBalance",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("account"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
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
                    ::std::borrow::ToOwned::to_owned("EmptyAddress"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("EmptyAddress"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("FailedInnerCall"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("FailedInnerCall"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("HeightAlreadyExecuted"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "HeightAlreadyExecuted",
                            ),
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
                    ::std::borrow::ToOwned::to_owned("NoRewardToWithdraw"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("NoRewardToWithdraw"),
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
                    ::std::borrow::ToOwned::to_owned("SubnetNotActive"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("SubnetNotActive"),
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
    #[rustfmt::skip]
    const __BYTECODE: &[u8] = b"`\x80\x80`@R4a\0\x16Wa\"~\x90\x81a\0\x1C\x829\xF3[`\0\x80\xFD\xFE`\x80`@R`\x046\x10\x15a\0\x12W`\0\x80\xFD[`\0\x805`\xE0\x1C\x80c\x08G\xBEB\x14a\x11dW\x80c\x19\x04\xBB.\x14a\x0F\xD2W\x80c+\xB6\x85\xBC\x14a\x0F?W\x80c:Kf\xF1\x14a\x0F\rW\x80c<\xCF\xD6\x0B\x14a\x0EkW\x80cA\xC0\xE1\xB5\x14a\r\xD9W\x80cNq\xD9-\x14a\x0B\xAEW\x80cl\xF6\x97\n\x14a\x07\xF2W\x80c|\xC4\xFCC\x14a\x06\xBBW\x80c\xA9\xFBv<\x14a\x05\xCEW\x80c\xCC-\xC2\xB9\x14a\x05UW\x80c\xD6m\x9E\x19\x14a\x03\xF5W\x80c\xE8\xEF\x87/\x14a\x02\x92W\x80c\xED\xB0\xFF\x83\x14a\x022W\x80c\xEEW\xE3o\x14a\x01\xD0Wc\xF5\x90O\xCF\x14a\0\xCDW`\0\x80\xFD[4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDWa\0\xE5a\x19\xE3V[3`\0\x90\x81R`\x13` R`@\x90 `\x01\x01T\x80\x15a\x01\xBBW\x7F\xB2\xF7\xC5\xADm\x04\xDB\xEB\x9E\x16\x1Bgbs\xC7\x07\xE9\x02\x9E(\xA5\n\x81\xB4I\xB0pq.\x0C\x18\xF2`\x80`\x01`\x01`@\x1B\x03`\x1AT\x16a\x01Ua\x019\x82a\x1F-V[`\x01`\x01`@\x1B\x03\x16`\x01`\x01`@\x1B\x03\x19`\x1AT\x16\x17`\x1AUV[`@Q\x90`\x01\x82R3` \x83\x01R\x84`@\x83\x01R``\x82\x01R\xA13`\0\x90\x81R`\x13` R`@\x90 `\x01\x01T\x90\x80\x82\x10a\x01\xA9Wa\x01\x93\x91a\x1A&V[3`\0\x90\x81R`\x13` R`@\x90 `\x01\x01U\x80\xF3[`@Qc\xACi6\x03`\xE0\x1B\x81R`\x04\x90\xFD[`@Qc.\xC5\xB4I`\xE0\x1B\x81R`\x04\x90\xFD[\x80\xFD[P4a\x01\xCDW` 6`\x03\x19\x01\x12a\x01\xCDW`\x045`\x01`\x01`@\x1B\x03\x81\x11a\x02.Wa\x02\x01\x906\x90`\x04\x01a\x16\xC8V[a\x02\n3a\x1D\x84V[\x15a\x02\x1CWa\x02\x19\x913a\x1D\xC2V[\x80\xF3[`@QcR\x8F\xC1e`\xE0\x1B\x81R`\x04\x90\xFD[P\x80\xFD[P` 6`\x03\x19\x01\x12a\x01\xCDW`\x045`\x01`\x01`@\x1B\x03\x81\x11a\x02.Wa\x02^\x906\x90`\x04\x01a\x16\xC8V[a\x02fa\x19\xE3V[4\x15a\x02\x80Wa\x02v\x913a\x1D\xC2V[a\x02\x1943a\x1E\xA1V[`@QcZx\xC5\x81`\xE1\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW`\x03\x19` 6\x82\x01\x81\x13a\x03\xF1W`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x03\xEDW`@\x816\x03\x94\x85\x01\x12a\x03\xEDW3\x85R`\r\x83R`@\x85 T\x15a\x01\xBBW3\x85R`\x03\x83R`@\x85 \x92\x81`\x04\x015`\xFF\x81\x16\x80\x91\x03a\x03\xE5W\x84T`\xFF\x19\x16\x17\x84U`\x01\x93\x84\x01\x94`$\x92\x80\x84\x015\x91`\"\x19\x01\x82\x12\x15a\x03\xE9W\x01`\x04\x81\x015\x93\x84\x11a\x03\xE5W\x836\x03\x83\x82\x01\x13a\x03\xE5Wa\x03@\x84a\x03:\x88Ta\x18\x97V[\x88a\x18\xE8V[\x86\x91`\x1F\x85\x11`\x01\x14a\x03}WP\x91\x83\x94\x91\x84\x93\x88\x95a\x03pW[PPP\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U\x80\xF3[\x01\x015\x92P8\x80\x80a\x03[V[\x92\x90\x91\x84`\x1F\x19\x81\x16\x88\x8AR\x85\x8A \x95\x8A\x90[\x89\x83\x83\x10a\x03\xC9WPPP\x10a\x03\xADW[PPPP\x81\x1B\x01\x90U\x80\xF3[`\0\x19`\xF8\x86`\x03\x1B\x16\x1C\x19\x92\x01\x015\x16\x90U8\x80\x80\x80a\x03\xA1V[\x87\x86\x01\x87\x015\x89U\x90\x97\x01\x96\x93\x84\x01\x93\x88\x93P\x90\x81\x01\x90a\x03\x90V[\x86\x80\xFD[\x87\x80\xFD[\x84\x80\xFD[\x82\x80\xFD[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDW\x7Fi\x1B\xB0?\xFC\x16\xC5o\xC9k\x82\xFD\x16\xCD\x1B7\x15\xF0\xBC<\xDCd\x07\0_I\xBBb\x05\x86\0\x95\x90`\x01\x82T\x14a\x05CW`\x01\x82Ua\x04=a\x19\xE3V[3\x81R\x80` R`@\x81 T\x91\x82\x15a\x01\xBBW3\x82R\x81` R\x81`@\x81 Ua\x04i\x83`\x06Ta\x1A&V[`\x06Ua\x04u3a\x1A\xADV[P`\x0BT\x92`\xFF\x84`\xA8\x1C\x16\x93`\x06\x85\x10\x15a\x05/W`\x01\x84\x95\x14a\x05\rW[P`\x0BT`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x05\x08W\x83\x80\x91`$`@Q\x80\x94\x81\x93cE\xF5D\x85`\xE0\x1B\x83R\x87`\x04\x84\x01RZ\xF1\x90\x81\x15a\x04\xFDW\x84\x91a\x04\xE5W[PPa\x04\xE1\x903a\x1A3V[U\x80\xF3[a\x04\xEE\x90a\x16\xF5V[a\x04\xF9W\x828a\x04\xD5V[PP\xFD[`@Q=\x86\x82>=\x90\xFD[PPP\xFD[`\x06T`\x07T\x11\x15a\x04\x95W`\xFF`\xA8\x1B\x19\x16`\x01`\xA9\x1B\x17`\x0BU8a\x04\x95V[cNH{q`\xE0\x1B\x84R`!`\x04R`$\x84\xFD[`@Qc)\xF7E\xA7`\xE0\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW``6`\x03\x19\x01\x12a\x01\xCDW`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x03\xF1W6`#\x82\x01\x12\x15a\x03\xF1Wa\x05\x98\x906\x90`$\x81`\x04\x015\x91\x01a\x17[V[`D5\x91\x82\x11a\x03\xF1W6`#\x83\x01\x12\x15a\x03\xF1Wa\x05\xC4a\x02\x19\x926\x90`$\x81`\x04\x015\x91\x01a\x17\xCCV[\x90`$5\x90a\x1FEV[P4a\x01\xCDW` \x80`\x03\x196\x01\x12a\x02.W`\x0BT`\x045\x90`\x01`\x01`\xA0\x1B\x03\x90\x81\x163\x03a\x06\xA9W`\x0C\x90\x81T\x92\x83\x15a\x06\x97W\x83\x81\x10a\x06\x85W\x83\x90\x04\x91\x85[\x84\x81\x10a\x06\x1DW\x86\x80\xF3[\x81T\x81\x10\x15a\x06oW\x81`\0R\x82\x81\x7F\xDFif\xC9q\x05\x1C=T\xECY\x16&\x06S\x14\x93\xA5\x14\x04\xA0\x02\x84/V\0\x9D~\\\xF4\xA8\xC7\x01T\x16\x87R`\x01\x90\x81\x87R`@\x88 a\x06g\x86\x82Ta\x18tV[\x90U\x01a\x06\x12V[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[`@Qc0t\xCA\xBF`\xE1\x1B\x81R`\x04\x90\xFD[`@Qc\xEF\xA9\xC8\xF1`\xE0\x1B\x81R`\x04\x90\xFD[`@Qc\xE7\xE6\x01\xDB`\xE0\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW` \x90\x81`\x03\x196\x01\x12a\x01\xCDW`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x03\xF1Wa\x06\xEF\x906\x90`\x04\x01a\x16\xC8V[\x903\x84R`\r\x85R`@\x84 T\x15a\x01\xBBW\x81\x15a\x07\xE0W3\x84R`\x02\x85R`@\x84 \x92\x82\x11a\x07\xCCWa\x07-\x82a\x07'\x85Ta\x18\x97V[\x85a\x18\xE8V[\x83\x94`\x1F\x83\x11`\x01\x14a\x07iWP\x93\x83\x94\x82\x93\x94\x92a\x07^W[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U\x80\xF3[\x015\x90P8\x80a\x07GV[\x90`\x1F\x19\x83\x16\x95\x84\x86R\x82\x86 \x92\x86\x90[\x88\x82\x10a\x07\xB4WPP\x83`\x01\x95\x96\x97\x10a\x07\x9AW[PPP\x81\x1B\x01\x90U\x80\xF3[\x015`\0\x19`\x03\x84\x90\x1B`\xF8\x16\x1C\x19\x16\x90U8\x80\x80a\x07\x8FV[\x80`\x01\x84\x96\x82\x94\x95\x87\x015\x81U\x01\x95\x01\x92\x01\x90a\x07zV[cNH{q`\xE0\x1B\x84R`A`\x04R`$\x84\xFD[`@Qcq85o`\xE0\x1B\x81R`\x04\x90\xFD[P`\x03\x19`@6\x82\x01\x12a\x02.W`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x0B\xAAWa\x08 \x906\x90`\x04\x01a\x16\xC8V[\x92\x90\x91`$\x93\x845\x93\x82\x85\x11a\x03\xE5W`@\x856\x03\x94\x85\x01\x12a\x03\xE5Wa\x08Ea\x19\xE3V[4\x15a\x02\x80W3\x87R` \x91\x87\x83R`@\x88 a\x08c4\x82Ta\x18tV[\x90Ua\x08q4`\x06Ta\x18tV[`\x06U3\x88R\x87\x83R`@\x88 T`\x07T\x11\x15a\t\xA2W[PPPPPP`\x0BT\x90`\xFF\x82`\xA8\x1C\x16\x90`\x06\x82\x10\x15a\t\x90WP`\x05\x81\x03a\t&WPP\x80`\x06T`\x07T\x81\x10\x15a\x08\xC3W[PP\x80\xF3[`\x0B\x80T`\xFF`\xA8\x1B\x19\x81\x16`\x01`\xA8\x1B\x17\x90\x91U`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x04\xF9W\x82\x90`\x04`@Q\x80\x94\x81\x93c\x03Tt\x01`\xE3\x1B\x83RZ\xF1\x80\x15a\t\x1BW\x15a\x08\xBEW[a\t\x14\x90a\x16\xF5V[a\x01\xCDW\x80\xF3[`@Q=\x84\x82>=\x90\xFD[`\x02\x14a\toW[P`\x0BT\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\tlW\x81`\x04\x91`@Q\x92\x83\x80\x92c\x16\x98\x9Fo`\xE2\x1B\x82R4\x90Z\xF1\x80\x15a\t\x1BWa\t\x0BWPP\x80\xF3[P\xFD[`\x06T`\x07T\x11a\t.W`\xFF`\xA8\x1B\x19\x16`\x01`\xA8\x1B\x17`\x0BU8a\t.V[cNH{q`\xE0\x1B\x84R`!`\x04R\x83\xFD[3`\0R`\r\x83R`@`\0 Ta\x08\x89Wa\t\xBD3a\x19fV[P3\x88R`\x02\x83R`@\x88 \x91\x84\x82\x11a\x0B\x97W\x81\x90a\t\xE7\x82a\t\xE1\x86Ta\x18\x97V[\x86a\x18\xE8V[\x89\x90`\x1F\x83\x11`\x01\x14a\x0B2W\x8A\x92a\x0B'W[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U[3\x86R`\x03\x81R`@\x86 \x92\x84`\x04\x015`\xFF\x81\x16\x80\x91\x03a\x03\xE9W\x84T`\xFF\x19\x16\x17\x84U`\x01\x93\x84\x01\x94\x86\x81\x015\x91`\"\x19\x01\x82\x12\x15a\x03\xE9W\x01\x90`\x04\x82\x015\x92\x83\x11a\x03\xE5W\x826\x03\x86\x83\x01\x13a\x03\xE5W\x85\x91a\nt\x84a\x03:\x88Ta\x18\x97V[\x87\x91`\x1F\x85\x11`\x01\x14a\n\xBAWP\x91\x83\x94\x91\x84\x93\x89\x95a\n\xADW[PPP\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U[8\x80\x80\x80\x80\x80a\x08\x89V[\x01\x015\x92P\x858\x80a\n\x8FV[\x92\x90\x91\x84`\x1F\x19\x81\x16\x88\x8BR\x85\x8B \x95\x8B\x90[\x89\x83\x83\x10a\x0B\x08WPPP\x10a\n\xECW[PPPP\x81\x1B\x01\x90Ua\n\xA2V[`\0\x19`\xF8\x86`\x03\x1B\x16\x1C\x19\x92\x01\x015\x16\x90U8\x80\x85\x81a\n\xDEV[\x87\x86\x01\x90\x96\x015\x88U\x96\x90\x94\x01\x95\x8A\x94\x93\x81\x01\x93\x88\x93P\x81\x01\x90a\n\xCDV[\x015\x90P8\x80a\t\xFBV[\x84\x8BR\x85\x8B \x92P\x90`\x1F\x19\x84\x16\x8B[\x87\x82\x82\x10a\x0B\x81WPP\x90\x84`\x01\x95\x94\x93\x92\x10a\x0BgW[PPP\x81\x1B\x01\x90Ua\n\x10V[\x015`\0\x19`\x03\x84\x90\x1B`\xF8\x16\x1C\x19\x16\x90U8\x80\x80a\x0BZV[`\x01\x84\x96\x82\x93\x95\x87\x015\x81U\x01\x95\x01\x92\x01a\x0BBV[cNH{q`\xE0\x1B\x89R`A`\x04R\x87\x89\xFD[\x83\x80\xFD[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDW`\x01\x90\x7Fi\x1B\xB0?\xFC\x16\xC5o\xC9k\x82\xFD\x16\xCD\x1B7\x15\xF0\xBC<\xDCd\x07\0_I\xBBb\x05\x86\0\x95\x82\x81T\x14a\x05CW\x82\x81Ua\x0B\xF6a\x19\xE3V[3`\0\x90\x81R`\x1D` R`@\x90 \x92\x83T\x90a\xFF\xFF\x90\x81\x83\x16\x92\x83\x15a\r\xC7W\x82\x90`\x10\x1C\x16\x91\x83\x91\x80\x87\x95\x81\x8A\x01\x91[a\r\x17W[PPP\x91\x86\x91c\xFF\xFF\0\0\x93\x87\x98T\x91\x16\x93\x84\x92`\x10\x1B\x16\x90c\xFF\xFF\xFF\xFF\x19\x16\x17\x17\x90U\x15a\r\0W[`\x0BT`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x05\x08W\x83\x80\x91`$`@Q\x80\x94\x81\x93cE\xF5D\x85`\xE0\x1B\x83R\x87`\x04\x84\x01RZ\xF1\x90\x81\x15a\x04\xFDW\x84\x91a\x0C\xECW[P\x80\x82\x80\x15a\x0C\xE2W[\x82\x80\x92\x91\x81\x923\x90\xF1\x15a\t\x1BW`@\x7F\x19|XcS\xEA\xED\n\x1CS\xE6\xE5@D[\x94\xBE\xFA\xB8\xF92\xC8\x11]\x11!\x15\xEC\xBE\xEE\xD5\x14\x91\x81Q\x903\x82R` \x82\x01R\xA1U\x80\xF3[a\x08\xFC\x91Pa\x0C\xA0V[a\x0C\xF5\x90a\x16\xF5V[a\x04\xF9W\x828a\x0C\x96V[3`\0\x90\x81R`\x1D` R`@\x90 \x83\x90Ua\x0CWV[\x90\x91\x93\x94\x83\x81\x16\x96\x82\x88\x10\x15a\r\xBEW\x87`\0R` \x90\x84\x82R`@`\0 \x90`@Q\x91`@\x83\x01\x92\x80\x84\x10`\x01`\x01`@\x1B\x03\x85\x11\x17a\r\xA8W\x84\x93`@R\x89\x82T\x92\x83\x83R\x01T\x93\x84\x91\x01RC\x10a\r\x9DW\x85\x94\x93\x88\x96\x88\x94a\r~\x86\x95\x8A\x95a\x18tV[\x9C`\0RR`\0\x82`@\x82 \x82\x81U\x01U\x01\x16\x96`\0\x19\x01\x16\x94a\x0C(V[\x98PPP\x94\x93a\x0C-V[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[\x96P\x94\x93a\x0C-V[`@Qcd\xB0U\x7F`\xE0\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDWa\r\xF2a\x19\xE3V[`\x0CT\x15\x80\x15\x90a\x0E`W[a\x0ENW`\x0B\x80T`\xFF`\xA8\x1B\x19\x81\x16`\x03`\xA8\x1B\x17\x90\x91U\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\tlW\x81\x80\x91`\x04`@Q\x80\x94\x81\x93cA\xC0\xE1\xB5`\xE0\x1B\x83RZ\xF1\x80\x15a\t\x1BWa\t\x0BWP\xF3[`@Qckb%Q`\xE1\x1B\x81R`\x04\x90\xFD[P`\x06T\x15\x15a\r\xFEV[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDW3\x81R`\x01` R`@\x81 T\x80\x15a\x0E\xFBW3\x82R`\x01` R`@\x82 \x82\x90U`\x0BT\x82\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x02.W\x81\x80\x91`$`@Q\x80\x94\x81\x93c\x1F\x0E\x07w`\xE3\x1B\x83R\x88`\x04\x84\x01RZ\xF1\x80\x15a\t\x1BWa\x0E\xE7W[Pa\x02\x19\x823a\x1A3V[a\x0E\xF0\x90a\x16\xF5V[a\x02.W\x818a\x0E\xDCV[`@Qcg0\x0F\x91`\xE1\x1B\x81R`\x04\x90\xFD[P\x80`\x03\x196\x01\x12a\x01\xCDWa\x0F!a\x19\xE3V[4\x15a\x02\x80Wa\x0F03a\x1D\x84V[\x15a\x02\x1CWa\x02\x1943a\x1E\xA1V[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDWa\x0FXa\x19\xE3V[a\xFF\xFF\x80`\x17T\x16\x81`\x14T\x16\x01\x81\x81\x11a\x0F\xBEW\x16a\x0ENW`\x0B\x80T`\xFF`\xA8\x1B\x19\x81\x16`\x03`\xA8\x1B\x17\x90\x91U\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\tlW\x81\x80\x91`\x04`@Q\x80\x94\x81\x93cA\xC0\xE1\xB5`\xE0\x1B\x83RZ\xF1\x80\x15a\t\x1BWa\t\x0BWP\xF3[cNH{q`\xE0\x1B\x83R`\x11`\x04R`$\x83\xFD[P4a\x01\xCDW` \x80`\x03\x196\x01\x12a\x02.W`\x045`\x01`\x01`\xA0\x1B\x03\x81\x16\x81\x03a\x11_W```@\x80Qa\x10\x07\x81a\x17\x08V[\x85\x81R\x85\x85\x82\x01R\x01Ra\x10\x1A3a\x1D\x84V[\x15a\x02\x1CW`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x91`@Q\x92a\x10D\x84a\x17\x08V[\x80T\x84R`\x01\x90`\x02\x82\x82\x01T\x91\x85\x87\x01\x92\x83R\x01`@Q\x80\x93\x85\x90\x83T\x93a\x10l\x85a\x18\x97V[\x94\x85\x85R\x89\x83\x82\x16\x91\x82`\0\x14a\x11=WPP`\x01\x14a\x11\x01W[PPa\x10\x9B\x92P\x96\x94\x95\x93\x92\x96\x03\x82a\x17#V[`@\x83\x01\x90\x81R`@Q\x94\x85\x93\x83\x85RQ\x83\x85\x01RQ`@\x84\x01RQ\x92``\x80\x84\x01R\x83Q\x91\x82`\x80\x85\x01R\x81[\x83\x81\x10a\x10\xEAWPP`\xA0\x80\x94P\x82\x84\x01\x01R`\x1F\x80\x19\x91\x01\x16\x81\x01\x03\x01\x90\xF3[\x80\x86\x01\x82\x01Q\x87\x82\x01`\xA0\x01R\x86\x94P\x81\x01a\x10\xC9V[\x88\x92P\x87R\x81\x87 \x90\x87\x91[\x85\x83\x10a\x11%WPPa\x10\x9B\x93P\x82\x01\x018\x80a\x10\x87V[\x80T\x83\x89\x01\x85\x01R\x87\x94P\x89\x93\x90\x92\x01\x91\x81\x01a\x11\rV[\x92P\x93PPa\x10\x9B\x94\x91P`\xFF\x19\x16\x82\x84\x01R\x15\x15`\x05\x1B\x82\x01\x018\x80a\x10\x87V[`\0\x80\xFD[P4a\x01\xCDW`\x03\x19`\x806\x82\x01\x12a\x02.W`\x01`\x01`@\x1B\x03`\x045\x11a\x02.W`\xA0\x90`\x0456\x03\x01\x12a\x01\xCDW`$5`\x01`\x01`@\x1B\x03\x81\x11a\x02.Wa\x11\xB4\x906\x90`\x04\x01a\x16\x84V[\x90`D5`\x01`\x01`@\x1B\x03\x81\x11a\x0B\xAAWa\x11\xD4\x906\x90`\x04\x01a\x16\x84V[\x90`d5`\x01`\x01`@\x1B\x03\x81\x11a\x15\x02Wa\x11\xF4\x906\x90`\x04\x01a\x16\x84V[\x93\x90\x94a\x12\x05`$`\x045\x01a\x1B\x97V[`\x01`\x01`@\x1B\x03\x80`\x05T\x16\x91\x16\x11\x15a\x16sWa\x12(`$`\x045\x01a\x1B\x97V[`\x01`\x01`@\x1B\x03`\x08T`\x80\x1C\x16\x90\x81\x15a\x16_W\x90`\x01`\x01`@\x1B\x03\x80\x92\x16\x06\x16a\x16MW`\xFF`\x0BT`\xA8\x1C\x16`\x06\x81\x10\x15a\x169W`\x01\x03a\x16'W\x90`@Q\x80\x92` \x80\x83\x01R\x80`@\x83\x01R``\x82\x01``\x82`\x05\x1B\x84\x01\x01\x91\x84\x8B\x90[\x82\x82\x10a\x15\x18WPPPPa\x12\xAB\x92P\x03`\x1F\x19\x81\x01\x83R\x82a\x17#V[` \x81Q\x91\x01 `\x84`\x045\x015\x03a\x15\x06Wa\x13\r\x93a\x12\xFFa\x13\x07\x92`@Qa\x12\xF0\x81a\x12\xE2`\x045`\x04\x01` \x83\x01a\x1D V[\x03`\x1F\x19\x81\x01\x83R\x82a\x17#V[` \x81Q\x91\x01 \x946\x91a\x17[V[\x936\x91a\x17\xCCV[\x91a\x1FEV[`\x01`\x01`@\x1B\x03a\x13#`$`\x045\x01a\x1B\x97V[\x16\x81R`\x04` R`@\x81 `\x045`\x04\x015`B\x19`\x0456\x03\x01\x81\x12\x15a\x03\xF1W`\x045\x01\x90`\x01`\x01`@\x1B\x03a\x13_`\x04\x84\x01a\x1B\x97V[\x16\x91`\x01`\x01`@\x1B\x03\x19\x92\x83\x83T\x16\x17\x82U`\x01\x82\x01\x90`$\x81\x015\x90`\"\x19\x816\x03\x01\x82\x12\x15a\x15\x02W\x01`\x04\x81\x015\x90`\x01`\x01`@\x1B\x03\x82\x11a\x15\x02W`$\x01\x81`\x05\x1B6\x03\x81\x13a\x15\x02W`\x01`@\x1B\x82\x11a\x14\xEEW\x82T\x82\x84U\x80\x83\x10a\x14\xD3W[P\x91\x85R` \x85 \x91\x85[\x82\x81\x10a\x14\xAEWPPPP`\x02\x81\x01`\x01`\x01`@\x1B\x03a\x13\xF7`$`\x045\x01a\x1B\x97V[\x16\x83\x82T\x16\x17\x90U`D`\x045\x015`\x03\x82\x01U`\x04\x81\x01`\x01`\x01`@\x1B\x03a\x14%`d`\x045\x01a\x1B\x97V[\x16\x83\x82T\x16\x17\x90U`\x05`\x84`\x045\x015\x91\x01U`\x01`\x01`@\x1B\x03a\x14O`$`\x045\x01a\x1B\x97V[`\x05\x80T\x90\x93\x16\x91\x16\x17\x90U`\x0BT`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x02.W\x81`@Q\x80\x92c \r\x97\x05`\xE0\x1B\x82R\x81\x83\x81a\x14\x93`\x045`\x04\x01`\x04\x83\x01a\x1D V[\x03\x92Z\xF1\x80\x15a\t\x1BWa\x14\xA5WP\x80\xF3[a\x02\x19\x90a\x16\xF5V[\x815\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\x03\xE9W` `\x01\x92\x93\x01\x92\x81\x86\x01U\x01a\x13\xD2V[\x83\x87R` \x87 a\x14\xE8\x91\x81\x01\x90\x84\x01a\x18\xD1V[8a\x13\xC7V[cNH{q`\xE0\x1B\x86R`A`\x04R`$\x86\xFD[\x85\x80\xFD[`@Qc-\x7Fu\x03`\xE2\x1B\x81R`\x04\x90\xFD[\x91\x93\x90\x92\x94P`_\x19\x87\x82\x03\x01\x85Ra\x151\x86\x83a\x1B\xABV[\x90`\xBE\x19\x826\x03\x01\x825\x12\x15a\x16#W\x81\x805\x01`@\x82Ra\x15ha\x15V\x82\x80a\x1B\xABV[`\xC0`@\x85\x01Ra\x01\0\x84\x01\x90a\x1C\xB7V[\x90a\x15\x8Da\x15y` \x83\x01\x83a\x1B\xABV[\x92`?\x19\x93\x84\x86\x83\x03\x01``\x87\x01Ra\x1C\xB7V[`@\x82\x015`\x80\x85\x01R`\x01`\x01`@\x1B\x03a\x15\xAB``\x84\x01a\x1B\xBFV[\x16`\xA0\x85\x01R`\x80\x82\x015\x92c\xFF\xFF\xFF\xFF`\xE0\x1B\x84\x16\x80\x94\x03a\x16\x1EWa\x15\xE1a\x15\xF0\x93` \x95`\xC0\x88\x01R`\xA0\x81\x01\x90a\x1CeV[\x91\x86\x84\x03\x01`\xE0\x87\x01Ra\x1C\x96V[\x92\x015\x80\x15\x15\x81\x03a\x16\x1AW`\x01\x92` \x92\x83\x80\x93\x15\x15\x91\x01R\x97\x01\x95\x01\x92\x01\x86\x94\x95\x93\x91a\x12\x8DV[\x8D\x80\xFD[P\x8F\x80\xFD[\x8C\x80\xFD[`@Qc\xC1\x83\x16\xBF`\xE0\x1B\x81R`\x04\x90\xFD[cNH{q`\xE0\x1B\x88R`!`\x04R`$\x88\xFD[`@Qc\xFA\xE4\xEA\xDB`\xE0\x1B\x81R`\x04\x90\xFD[cNH{q`\xE0\x1B\x89R`\x12`\x04R`$\x89\xFD[c\x14\xFB\xADO`\xE3\x1B`\x80R`\x04`\x80\xFD[\x91\x81`\x1F\x84\x01\x12\x15a\x11_W\x825\x91`\x01`\x01`@\x1B\x03\x83\x11a\x11_W` \x80\x85\x01\x94\x84`\x05\x1B\x01\x01\x11a\x11_WV[5\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\x11_WV[\x91\x81`\x1F\x84\x01\x12\x15a\x11_W\x825\x91`\x01`\x01`@\x1B\x03\x83\x11a\x11_W` \x83\x81\x86\x01\x95\x01\x01\x11a\x11_WV[`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8W`@RV[``\x81\x01\x90\x81\x10`\x01`\x01`@\x1B\x03\x82\x11\x17a\r\xA8W`@RV[\x90`\x1F\x80\x19\x91\x01\x16\x81\x01\x90\x81\x10`\x01`\x01`@\x1B\x03\x82\x11\x17a\r\xA8W`@RV[`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8W`\x05\x1B` \x01\x90V[\x92\x91a\x17f\x82a\x17DV[\x91a\x17t`@Q\x93\x84a\x17#V[\x82\x94\x81\x84R` \x80\x94\x01\x91`\x05\x1B\x81\x01\x92\x83\x11a\x11_W\x90[\x82\x82\x10a\x17\x9AWPPPPV[\x83\x80\x91a\x17\xA6\x84a\x16\xB4V[\x81R\x01\x91\x01\x90a\x17\x8DV[`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8W`\x1F\x01`\x1F\x19\x16` \x01\x90V[\x92\x91\x90\x92a\x17\xD9\x84a\x17DV[\x91`@\x94a\x17\xE9\x86Q\x94\x85a\x17#V[\x83\x95\x81\x85R` \x80\x95\x01\x91`\x05\x1B\x84\x01\x93\x83\x85\x11a\x11_W\x80\x92[\x85\x84\x10a\x18\x14WPPPPPPPV[\x835`\x01`\x01`@\x1B\x03\x81\x11a\x11_W\x82\x01\x85`\x1F\x82\x01\x12\x15a\x11_W\x805\x91a\x18=\x83a\x17\xB1V[a\x18I\x86Q\x91\x82a\x17#V[\x83\x81R\x87\x8A\x85\x85\x01\x01\x11a\x11_W`\0\x8A\x85\x81\x96\x82\x80\x97\x01\x83\x86\x017\x83\x01\x01R\x81R\x01\x93\x01\x92a\x18\x04V[\x91\x90\x82\x01\x80\x92\x11a\x18\x81WV[cNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[\x90`\x01\x82\x81\x1C\x92\x16\x80\x15a\x18\xC7W[` \x83\x10\x14a\x18\xB1WV[cNH{q`\xE0\x1B`\0R`\"`\x04R`$`\0\xFD[\x91`\x7F\x16\x91a\x18\xA6V[\x81\x81\x10a\x18\xDCWPPV[`\0\x81U`\x01\x01a\x18\xD1V[\x91\x90`\x1F\x81\x11a\x18\xF7WPPPV[a\x19#\x92`\0R` `\0 \x90` `\x1F\x84\x01`\x05\x1C\x83\x01\x93\x10a\x19%W[`\x1F\x01`\x05\x1C\x01\x90a\x18\xD1V[V[\x90\x91P\x81\x90a\x19\x16V[`\x0CT\x81\x10\x15a\x06oW`\x0C`\0R\x7F\xDFif\xC9q\x05\x1C=T\xECY\x16&\x06S\x14\x93\xA5\x14\x04\xA0\x02\x84/V\0\x9D~\\\xF4\xA8\xC7\x01\x90`\0\x90V[`\0\x81\x81R`\r` R`@\x81 Ta\x19\xDEW`\x0CT`\x01`@\x1B\x81\x10\x15a\x19\xCAW\x90\x82a\x19\xB6a\x19\x9F\x84`\x01`@\x96\x01`\x0CUa\x19/V[\x81\x93\x91T\x90`\x03\x1B\x91\x82\x1B\x91`\0\x19\x90\x1B\x19\x16\x17\x90V[\x90U`\x0CT\x92\x81R`\r` R U`\x01\x90V[cNH{q`\xE0\x1B\x82R`A`\x04R`$\x82\xFD[\x90P\x90V[`\xFF`\x0BT`\xA8\x1C\x16`\x06\x81\x10\x15a\x1A\x10W`\x03\x14a\x19\xFEWV[`@Qc$\x8C\x8E\xFB`\xE1\x1B\x81R`\x04\x90\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[\x91\x90\x82\x03\x91\x82\x11a\x18\x81WV[\x81G\x10a\x1A\x95W`\0\x91\x82\x91\x82\x91\x82\x91`\x01`\x01`\xA0\x1B\x03\x16Z\xF1=\x15a\x1A\x90W=a\x1A^\x81a\x17\xB1V[\x90a\x1Al`@Q\x92\x83a\x17#V[\x81R`\0` =\x92\x01>[\x15a\x1A~WV[`@Qc\n\x12\xF5!`\xE1\x1B\x81R`\x04\x90\xFD[a\x1AwV[`@Qc\xCDx`Y`\xE0\x1B\x81R0`\x04\x82\x01R`$\x90\xFD[`\0\x81\x81R`\r` R`@\x81 T\x90\x91\x90\x80\x15a\x1B\x92W`\0\x19\x90\x80\x82\x01\x81\x81\x11a\x1B~W`\x0CT\x90\x83\x82\x01\x91\x82\x11a\x1BjW\x80\x82\x03a\x1B6W[PPP`\x0CT\x80\x15a\x1B\"W\x81\x01\x90a\x1B\x01\x82a\x19/V[\x90\x91\x82T\x91`\x03\x1B\x1B\x19\x16\x90U`\x0CU\x81R`\r` R`@\x81 U`\x01\x90V[cNH{q`\xE0\x1B\x84R`1`\x04R`$\x84\xFD[a\x1BTa\x1BEa\x19\x9F\x93a\x19/V[\x90T\x90`\x03\x1B\x1C\x92\x83\x92a\x19/V[\x90U\x84R`\r` R`@\x84 U8\x80\x80a\x1A\xE9V[cNH{q`\xE0\x1B\x86R`\x11`\x04R`$\x86\xFD[cNH{q`\xE0\x1B\x85R`\x11`\x04R`$\x85\xFD[PP\x90V[5`\x01`\x01`@\x1B\x03\x81\x16\x81\x03a\x11_W\x90V[\x905`>\x19\x826\x03\x01\x81\x12\x15a\x11_W\x01\x90V[5\x90`\x01`\x01`@\x1B\x03\x82\x16\x82\x03a\x11_WV[`\x01`\x01`@\x1B\x03\x91\x90`@\x82\x01\x83a\x1B\xEB\x83a\x1B\xBFV[\x16\x83R` \x91\x82\x81\x015`\x1E\x19\x826\x03\x01\x81\x12\x15a\x11_W\x01\x92\x82\x845\x94\x01\x94\x84\x11a\x11_W\x83`\x05\x1B6\x03\x85\x13a\x11_W`@\x81\x84\x01R\x90\x83\x90R``\x01\x92\x91\x90`\0[\x82\x81\x10a\x1C>WPPPP\x90V[\x90\x91\x92\x93\x82\x80`\x01\x92\x83\x80`\xA0\x1B\x03a\x1CV\x89a\x16\xB4V[\x16\x81R\x01\x95\x01\x93\x92\x91\x01a\x1C0V[\x905`\x1E\x19\x826\x03\x01\x81\x12\x15a\x11_W\x01` \x815\x91\x01\x91`\x01`\x01`@\x1B\x03\x82\x11a\x11_W\x816\x03\x83\x13a\x11_WV[\x90\x80` \x93\x92\x81\x84R\x84\x84\x017`\0\x82\x82\x01\x84\x01R`\x1F\x01`\x1F\x19\x16\x01\x01\x90V[a\x1C\xE0a\x1C\xD5a\x1C\xC7\x83\x80a\x1B\xABV[`@\x85R`@\x85\x01\x90a\x1B\xD3V[\x91` \x81\x01\x90a\x1B\xABV[\x91` \x81\x83\x03\x91\x01R\x815\x91`\xFF\x83\x16\x80\x93\x03a\x11_Wa\x1D\r`@\x91a\x1D\x1D\x94\x84R` \x81\x01\x90a\x1CeV[\x91\x90\x92\x81` \x82\x01R\x01\x91a\x1C\x96V[\x90V[` \x81R`\xA0`\x80a\x1DEa\x1D5\x85\x80a\x1B\xABV[\x83` \x86\x01R`\xC0\x85\x01\x90a\x1B\xD3V[\x93`\x01`\x01`@\x1B\x03\x80a\x1D[` \x84\x01a\x1B\xBFV[\x16`@\x86\x01R`@\x82\x015``\x86\x01Ra\x1Dw``\x83\x01a\x1B\xBFV[\x16\x82\x85\x01R\x015\x91\x01R\x90V[`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x18` R`@\x90 Ta\xFF\xFF\x90\x81\x16\x15\x80\x15\x91\x90a\x1D\xAFWP\x90V[\x90P`\x15` R`@`\0 T\x16\x15\x15\x90V[`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x90\x92\x91\x90`\x02\x01\x90`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8Wa\x1E\x03\x81a\x1D\xFD\x84Ta\x18\x97V[\x84a\x18\xE8V[`\0`\x1F\x82\x11`\x01\x14a\x1E=W\x81\x92\x93\x94`\0\x92a\x1E2W[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90UV[\x015\x90P8\x80a\x1E\x1CV[`\x1F\x19\x82\x16\x94\x83\x82R` \x91\x82\x81 \x92\x81\x90[\x88\x82\x10a\x1E\x89WPP\x83`\x01\x95\x96\x97\x10a\x1EoW[PPP\x81\x1B\x01\x90UV[\x015`\0\x19`\x03\x84\x90\x1B`\xF8\x16\x1C\x19\x16\x90U8\x80\x80a\x1EeV[\x80`\x01\x84\x96\x82\x94\x95\x87\x015\x81U\x01\x95\x01\x92\x01\x90a\x1EPV[`\x01a\x1F a\x1F)\x92\x7F\xB2\xF7\xC5\xADm\x04\xDB\xEB\x9E\x16\x1Bgbs\xC7\x07\xE9\x02\x9E(\xA5\n\x81\xB4I\xB0pq.\x0C\x18\xF2`\x80`\x01`\x01`@\x1B\x03`\x1AT\x16a\x1E\xE5a\x019\x82a\x1F-V[`@Q\x90`\0\x82R\x86\x80`\xA0\x1B\x03\x85\x16` \x83\x01R\x88`@\x83\x01R``\x82\x01R\xA1`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x90V[\x01\x91\x82Ta\x18tV[\x90UV[\x90`\x01`\x01`\x01`@\x1B\x03\x80\x93\x16\x01\x91\x82\x11a\x18\x81WV[\x90\x91\x81Q\x92a\x1FS\x84a\x17DV[\x92`@\x94a\x1Fc\x86Q\x95\x86a\x17#V[\x80\x85R`\x1F\x19a\x1Fr\x82a\x17DV[\x01\x90` \x916\x83\x88\x017`\0[\x81\x81\x10a\x1F\xDFWPP`\x12T`\x0BT`\xA0\x1C`\xFF\x16\x80\x82\x02\x96\x92P\x81\x15\x91\x87\x04\x14\x17\x15a\x18\x81W`da\x1F\xB3\x95\x04\x91a mV[\x90\x15a\x1F\xBDWPPV[`\x07\x81\x10\x15a\x1A\x10W`\xFF`$\x92Q\x91c(.\xF1\xC1`\xE0\x1B\x83R\x16`\x04\x82\x01R\xFD[`\x01`\x01`\xA0\x1B\x03\x80a\x1F\xF2\x83\x87a YV[Q\x16`\0R`\x15\x84Ra\xFF\xFF\x89`\0 T\x16\x15a HW\x90a 6`\x01\x92a \x1A\x83\x88a YV[Q\x16`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x90V[Ta A\x82\x8Aa YV[R\x01a\x1F\x7FV[\x88Qc.\xC5\xB4I`\xE0\x1B\x81R`\x04\x90\xFD[\x80Q\x82\x10\x15a\x06oW` \x91`\x05\x1B\x01\x01\x90V[\x84Q\x92\x94`\0\x94\x90\x84\x15a!oW\x82Q\x85\x14\x80\x15\x90a!dW[a!WW\x93\x92\x91\x90\x85\x94[\x84\x86\x10a \xB5WPPPPPP\x10\x15a \xADW`\0\x90`\x06\x90V[`\x01\x90`\0\x90V[\x90\x91\x92\x93\x94\x95a \xCFa \xC8\x88\x84a YV[Q\x84a!|V[P\x90`\x04\x91\x82\x81\x10\x15a!BWa!0W`\x01`\x01`\xA0\x1B\x03\x80a \xF3\x8B\x89a YV[Q\x16\x91\x16\x03a! WPa!\x14`\x01\x91a!\r\x89\x88a YV[Q\x90a\x18tV[\x96\x01\x94\x93\x92\x91\x90a \x92V[\x98\x97PPPPPPPP`\0\x91\x90V[PPPPPPPPPP`\0\x90`\x05\x90V[`!\x83cNH{q`\xE0\x1B`\0RR`$`\0\xFD[PPPPP\x90P\x90`\x01\x90V[P\x83Q\x85\x14\x15a \x87V[PPPPP\x90P\x90`\x02\x90V[\x81Q\x91\x90`A\x83\x03a!\xADWa!\xA6\x92P` \x82\x01Q\x90```@\x84\x01Q\x93\x01Q`\0\x1A\x90a!\xB8V[\x91\x92\x90\x91\x90V[PP`\0\x91`\x02\x91\x90V[\x91\x90\x7F\x7F\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF]WnsW\xA4P\x1D\xDF\xE9/Fh\x1B \xA0\x84\x11a\"<W\x92` \x92\x91`\xFF`\x80\x95`@Q\x94\x85R\x16\x84\x84\x01R`@\x83\x01R``\x82\x01R`\0\x92\x83\x91\x82\x80R`\x01Z\xFA\x15a\"0W\x80Q`\x01`\x01`\xA0\x1B\x03\x81\x16\x15a\"'W\x91\x81\x90V[P\x80\x91`\x01\x91\x90V[`@Q\x90=\x90\x82>=\x90\xFD[PPP`\0\x91`\x03\x91\x90V\xFE\xA2dipfsX\"\x12 \x9DnF\x12\xCA\xF0\xAC\xCB\xFC\x04\x005\x98\xB26\xA6\x7F\xE6\xF4\xE5\x96\xFE\x82\xA8\x13\xE3\xA2\xA0G\x01\xA6\x8DdsolcC\0\x08\x13\x003";
    /// The bytecode of the contract.
    pub static SUBNETACTORMANAGERFACET_BYTECODE: ::ethers::core::types::Bytes =
        ::ethers::core::types::Bytes::from_static(__BYTECODE);
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@R`\x046\x10\x15a\0\x12W`\0\x80\xFD[`\0\x805`\xE0\x1C\x80c\x08G\xBEB\x14a\x11dW\x80c\x19\x04\xBB.\x14a\x0F\xD2W\x80c+\xB6\x85\xBC\x14a\x0F?W\x80c:Kf\xF1\x14a\x0F\rW\x80c<\xCF\xD6\x0B\x14a\x0EkW\x80cA\xC0\xE1\xB5\x14a\r\xD9W\x80cNq\xD9-\x14a\x0B\xAEW\x80cl\xF6\x97\n\x14a\x07\xF2W\x80c|\xC4\xFCC\x14a\x06\xBBW\x80c\xA9\xFBv<\x14a\x05\xCEW\x80c\xCC-\xC2\xB9\x14a\x05UW\x80c\xD6m\x9E\x19\x14a\x03\xF5W\x80c\xE8\xEF\x87/\x14a\x02\x92W\x80c\xED\xB0\xFF\x83\x14a\x022W\x80c\xEEW\xE3o\x14a\x01\xD0Wc\xF5\x90O\xCF\x14a\0\xCDW`\0\x80\xFD[4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDWa\0\xE5a\x19\xE3V[3`\0\x90\x81R`\x13` R`@\x90 `\x01\x01T\x80\x15a\x01\xBBW\x7F\xB2\xF7\xC5\xADm\x04\xDB\xEB\x9E\x16\x1Bgbs\xC7\x07\xE9\x02\x9E(\xA5\n\x81\xB4I\xB0pq.\x0C\x18\xF2`\x80`\x01`\x01`@\x1B\x03`\x1AT\x16a\x01Ua\x019\x82a\x1F-V[`\x01`\x01`@\x1B\x03\x16`\x01`\x01`@\x1B\x03\x19`\x1AT\x16\x17`\x1AUV[`@Q\x90`\x01\x82R3` \x83\x01R\x84`@\x83\x01R``\x82\x01R\xA13`\0\x90\x81R`\x13` R`@\x90 `\x01\x01T\x90\x80\x82\x10a\x01\xA9Wa\x01\x93\x91a\x1A&V[3`\0\x90\x81R`\x13` R`@\x90 `\x01\x01U\x80\xF3[`@Qc\xACi6\x03`\xE0\x1B\x81R`\x04\x90\xFD[`@Qc.\xC5\xB4I`\xE0\x1B\x81R`\x04\x90\xFD[\x80\xFD[P4a\x01\xCDW` 6`\x03\x19\x01\x12a\x01\xCDW`\x045`\x01`\x01`@\x1B\x03\x81\x11a\x02.Wa\x02\x01\x906\x90`\x04\x01a\x16\xC8V[a\x02\n3a\x1D\x84V[\x15a\x02\x1CWa\x02\x19\x913a\x1D\xC2V[\x80\xF3[`@QcR\x8F\xC1e`\xE0\x1B\x81R`\x04\x90\xFD[P\x80\xFD[P` 6`\x03\x19\x01\x12a\x01\xCDW`\x045`\x01`\x01`@\x1B\x03\x81\x11a\x02.Wa\x02^\x906\x90`\x04\x01a\x16\xC8V[a\x02fa\x19\xE3V[4\x15a\x02\x80Wa\x02v\x913a\x1D\xC2V[a\x02\x1943a\x1E\xA1V[`@QcZx\xC5\x81`\xE1\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW`\x03\x19` 6\x82\x01\x81\x13a\x03\xF1W`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x03\xEDW`@\x816\x03\x94\x85\x01\x12a\x03\xEDW3\x85R`\r\x83R`@\x85 T\x15a\x01\xBBW3\x85R`\x03\x83R`@\x85 \x92\x81`\x04\x015`\xFF\x81\x16\x80\x91\x03a\x03\xE5W\x84T`\xFF\x19\x16\x17\x84U`\x01\x93\x84\x01\x94`$\x92\x80\x84\x015\x91`\"\x19\x01\x82\x12\x15a\x03\xE9W\x01`\x04\x81\x015\x93\x84\x11a\x03\xE5W\x836\x03\x83\x82\x01\x13a\x03\xE5Wa\x03@\x84a\x03:\x88Ta\x18\x97V[\x88a\x18\xE8V[\x86\x91`\x1F\x85\x11`\x01\x14a\x03}WP\x91\x83\x94\x91\x84\x93\x88\x95a\x03pW[PPP\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U\x80\xF3[\x01\x015\x92P8\x80\x80a\x03[V[\x92\x90\x91\x84`\x1F\x19\x81\x16\x88\x8AR\x85\x8A \x95\x8A\x90[\x89\x83\x83\x10a\x03\xC9WPPP\x10a\x03\xADW[PPPP\x81\x1B\x01\x90U\x80\xF3[`\0\x19`\xF8\x86`\x03\x1B\x16\x1C\x19\x92\x01\x015\x16\x90U8\x80\x80\x80a\x03\xA1V[\x87\x86\x01\x87\x015\x89U\x90\x97\x01\x96\x93\x84\x01\x93\x88\x93P\x90\x81\x01\x90a\x03\x90V[\x86\x80\xFD[\x87\x80\xFD[\x84\x80\xFD[\x82\x80\xFD[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDW\x7Fi\x1B\xB0?\xFC\x16\xC5o\xC9k\x82\xFD\x16\xCD\x1B7\x15\xF0\xBC<\xDCd\x07\0_I\xBBb\x05\x86\0\x95\x90`\x01\x82T\x14a\x05CW`\x01\x82Ua\x04=a\x19\xE3V[3\x81R\x80` R`@\x81 T\x91\x82\x15a\x01\xBBW3\x82R\x81` R\x81`@\x81 Ua\x04i\x83`\x06Ta\x1A&V[`\x06Ua\x04u3a\x1A\xADV[P`\x0BT\x92`\xFF\x84`\xA8\x1C\x16\x93`\x06\x85\x10\x15a\x05/W`\x01\x84\x95\x14a\x05\rW[P`\x0BT`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x05\x08W\x83\x80\x91`$`@Q\x80\x94\x81\x93cE\xF5D\x85`\xE0\x1B\x83R\x87`\x04\x84\x01RZ\xF1\x90\x81\x15a\x04\xFDW\x84\x91a\x04\xE5W[PPa\x04\xE1\x903a\x1A3V[U\x80\xF3[a\x04\xEE\x90a\x16\xF5V[a\x04\xF9W\x828a\x04\xD5V[PP\xFD[`@Q=\x86\x82>=\x90\xFD[PPP\xFD[`\x06T`\x07T\x11\x15a\x04\x95W`\xFF`\xA8\x1B\x19\x16`\x01`\xA9\x1B\x17`\x0BU8a\x04\x95V[cNH{q`\xE0\x1B\x84R`!`\x04R`$\x84\xFD[`@Qc)\xF7E\xA7`\xE0\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW``6`\x03\x19\x01\x12a\x01\xCDW`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x03\xF1W6`#\x82\x01\x12\x15a\x03\xF1Wa\x05\x98\x906\x90`$\x81`\x04\x015\x91\x01a\x17[V[`D5\x91\x82\x11a\x03\xF1W6`#\x83\x01\x12\x15a\x03\xF1Wa\x05\xC4a\x02\x19\x926\x90`$\x81`\x04\x015\x91\x01a\x17\xCCV[\x90`$5\x90a\x1FEV[P4a\x01\xCDW` \x80`\x03\x196\x01\x12a\x02.W`\x0BT`\x045\x90`\x01`\x01`\xA0\x1B\x03\x90\x81\x163\x03a\x06\xA9W`\x0C\x90\x81T\x92\x83\x15a\x06\x97W\x83\x81\x10a\x06\x85W\x83\x90\x04\x91\x85[\x84\x81\x10a\x06\x1DW\x86\x80\xF3[\x81T\x81\x10\x15a\x06oW\x81`\0R\x82\x81\x7F\xDFif\xC9q\x05\x1C=T\xECY\x16&\x06S\x14\x93\xA5\x14\x04\xA0\x02\x84/V\0\x9D~\\\xF4\xA8\xC7\x01T\x16\x87R`\x01\x90\x81\x87R`@\x88 a\x06g\x86\x82Ta\x18tV[\x90U\x01a\x06\x12V[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[`@Qc0t\xCA\xBF`\xE1\x1B\x81R`\x04\x90\xFD[`@Qc\xEF\xA9\xC8\xF1`\xE0\x1B\x81R`\x04\x90\xFD[`@Qc\xE7\xE6\x01\xDB`\xE0\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW` \x90\x81`\x03\x196\x01\x12a\x01\xCDW`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x03\xF1Wa\x06\xEF\x906\x90`\x04\x01a\x16\xC8V[\x903\x84R`\r\x85R`@\x84 T\x15a\x01\xBBW\x81\x15a\x07\xE0W3\x84R`\x02\x85R`@\x84 \x92\x82\x11a\x07\xCCWa\x07-\x82a\x07'\x85Ta\x18\x97V[\x85a\x18\xE8V[\x83\x94`\x1F\x83\x11`\x01\x14a\x07iWP\x93\x83\x94\x82\x93\x94\x92a\x07^W[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U\x80\xF3[\x015\x90P8\x80a\x07GV[\x90`\x1F\x19\x83\x16\x95\x84\x86R\x82\x86 \x92\x86\x90[\x88\x82\x10a\x07\xB4WPP\x83`\x01\x95\x96\x97\x10a\x07\x9AW[PPP\x81\x1B\x01\x90U\x80\xF3[\x015`\0\x19`\x03\x84\x90\x1B`\xF8\x16\x1C\x19\x16\x90U8\x80\x80a\x07\x8FV[\x80`\x01\x84\x96\x82\x94\x95\x87\x015\x81U\x01\x95\x01\x92\x01\x90a\x07zV[cNH{q`\xE0\x1B\x84R`A`\x04R`$\x84\xFD[`@Qcq85o`\xE0\x1B\x81R`\x04\x90\xFD[P`\x03\x19`@6\x82\x01\x12a\x02.W`\x01`\x01`@\x1B\x03`\x045\x81\x81\x11a\x0B\xAAWa\x08 \x906\x90`\x04\x01a\x16\xC8V[\x92\x90\x91`$\x93\x845\x93\x82\x85\x11a\x03\xE5W`@\x856\x03\x94\x85\x01\x12a\x03\xE5Wa\x08Ea\x19\xE3V[4\x15a\x02\x80W3\x87R` \x91\x87\x83R`@\x88 a\x08c4\x82Ta\x18tV[\x90Ua\x08q4`\x06Ta\x18tV[`\x06U3\x88R\x87\x83R`@\x88 T`\x07T\x11\x15a\t\xA2W[PPPPPP`\x0BT\x90`\xFF\x82`\xA8\x1C\x16\x90`\x06\x82\x10\x15a\t\x90WP`\x05\x81\x03a\t&WPP\x80`\x06T`\x07T\x81\x10\x15a\x08\xC3W[PP\x80\xF3[`\x0B\x80T`\xFF`\xA8\x1B\x19\x81\x16`\x01`\xA8\x1B\x17\x90\x91U`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x04\xF9W\x82\x90`\x04`@Q\x80\x94\x81\x93c\x03Tt\x01`\xE3\x1B\x83RZ\xF1\x80\x15a\t\x1BW\x15a\x08\xBEW[a\t\x14\x90a\x16\xF5V[a\x01\xCDW\x80\xF3[`@Q=\x84\x82>=\x90\xFD[`\x02\x14a\toW[P`\x0BT\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\tlW\x81`\x04\x91`@Q\x92\x83\x80\x92c\x16\x98\x9Fo`\xE2\x1B\x82R4\x90Z\xF1\x80\x15a\t\x1BWa\t\x0BWPP\x80\xF3[P\xFD[`\x06T`\x07T\x11a\t.W`\xFF`\xA8\x1B\x19\x16`\x01`\xA8\x1B\x17`\x0BU8a\t.V[cNH{q`\xE0\x1B\x84R`!`\x04R\x83\xFD[3`\0R`\r\x83R`@`\0 Ta\x08\x89Wa\t\xBD3a\x19fV[P3\x88R`\x02\x83R`@\x88 \x91\x84\x82\x11a\x0B\x97W\x81\x90a\t\xE7\x82a\t\xE1\x86Ta\x18\x97V[\x86a\x18\xE8V[\x89\x90`\x1F\x83\x11`\x01\x14a\x0B2W\x8A\x92a\x0B'W[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U[3\x86R`\x03\x81R`@\x86 \x92\x84`\x04\x015`\xFF\x81\x16\x80\x91\x03a\x03\xE9W\x84T`\xFF\x19\x16\x17\x84U`\x01\x93\x84\x01\x94\x86\x81\x015\x91`\"\x19\x01\x82\x12\x15a\x03\xE9W\x01\x90`\x04\x82\x015\x92\x83\x11a\x03\xE5W\x826\x03\x86\x83\x01\x13a\x03\xE5W\x85\x91a\nt\x84a\x03:\x88Ta\x18\x97V[\x87\x91`\x1F\x85\x11`\x01\x14a\n\xBAWP\x91\x83\x94\x91\x84\x93\x89\x95a\n\xADW[PPP\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90U[8\x80\x80\x80\x80\x80a\x08\x89V[\x01\x015\x92P\x858\x80a\n\x8FV[\x92\x90\x91\x84`\x1F\x19\x81\x16\x88\x8BR\x85\x8B \x95\x8B\x90[\x89\x83\x83\x10a\x0B\x08WPPP\x10a\n\xECW[PPPP\x81\x1B\x01\x90Ua\n\xA2V[`\0\x19`\xF8\x86`\x03\x1B\x16\x1C\x19\x92\x01\x015\x16\x90U8\x80\x85\x81a\n\xDEV[\x87\x86\x01\x90\x96\x015\x88U\x96\x90\x94\x01\x95\x8A\x94\x93\x81\x01\x93\x88\x93P\x81\x01\x90a\n\xCDV[\x015\x90P8\x80a\t\xFBV[\x84\x8BR\x85\x8B \x92P\x90`\x1F\x19\x84\x16\x8B[\x87\x82\x82\x10a\x0B\x81WPP\x90\x84`\x01\x95\x94\x93\x92\x10a\x0BgW[PPP\x81\x1B\x01\x90Ua\n\x10V[\x015`\0\x19`\x03\x84\x90\x1B`\xF8\x16\x1C\x19\x16\x90U8\x80\x80a\x0BZV[`\x01\x84\x96\x82\x93\x95\x87\x015\x81U\x01\x95\x01\x92\x01a\x0BBV[cNH{q`\xE0\x1B\x89R`A`\x04R\x87\x89\xFD[\x83\x80\xFD[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDW`\x01\x90\x7Fi\x1B\xB0?\xFC\x16\xC5o\xC9k\x82\xFD\x16\xCD\x1B7\x15\xF0\xBC<\xDCd\x07\0_I\xBBb\x05\x86\0\x95\x82\x81T\x14a\x05CW\x82\x81Ua\x0B\xF6a\x19\xE3V[3`\0\x90\x81R`\x1D` R`@\x90 \x92\x83T\x90a\xFF\xFF\x90\x81\x83\x16\x92\x83\x15a\r\xC7W\x82\x90`\x10\x1C\x16\x91\x83\x91\x80\x87\x95\x81\x8A\x01\x91[a\r\x17W[PPP\x91\x86\x91c\xFF\xFF\0\0\x93\x87\x98T\x91\x16\x93\x84\x92`\x10\x1B\x16\x90c\xFF\xFF\xFF\xFF\x19\x16\x17\x17\x90U\x15a\r\0W[`\x0BT`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x05\x08W\x83\x80\x91`$`@Q\x80\x94\x81\x93cE\xF5D\x85`\xE0\x1B\x83R\x87`\x04\x84\x01RZ\xF1\x90\x81\x15a\x04\xFDW\x84\x91a\x0C\xECW[P\x80\x82\x80\x15a\x0C\xE2W[\x82\x80\x92\x91\x81\x923\x90\xF1\x15a\t\x1BW`@\x7F\x19|XcS\xEA\xED\n\x1CS\xE6\xE5@D[\x94\xBE\xFA\xB8\xF92\xC8\x11]\x11!\x15\xEC\xBE\xEE\xD5\x14\x91\x81Q\x903\x82R` \x82\x01R\xA1U\x80\xF3[a\x08\xFC\x91Pa\x0C\xA0V[a\x0C\xF5\x90a\x16\xF5V[a\x04\xF9W\x828a\x0C\x96V[3`\0\x90\x81R`\x1D` R`@\x90 \x83\x90Ua\x0CWV[\x90\x91\x93\x94\x83\x81\x16\x96\x82\x88\x10\x15a\r\xBEW\x87`\0R` \x90\x84\x82R`@`\0 \x90`@Q\x91`@\x83\x01\x92\x80\x84\x10`\x01`\x01`@\x1B\x03\x85\x11\x17a\r\xA8W\x84\x93`@R\x89\x82T\x92\x83\x83R\x01T\x93\x84\x91\x01RC\x10a\r\x9DW\x85\x94\x93\x88\x96\x88\x94a\r~\x86\x95\x8A\x95a\x18tV[\x9C`\0RR`\0\x82`@\x82 \x82\x81U\x01U\x01\x16\x96`\0\x19\x01\x16\x94a\x0C(V[\x98PPP\x94\x93a\x0C-V[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[\x96P\x94\x93a\x0C-V[`@Qcd\xB0U\x7F`\xE0\x1B\x81R`\x04\x90\xFD[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDWa\r\xF2a\x19\xE3V[`\x0CT\x15\x80\x15\x90a\x0E`W[a\x0ENW`\x0B\x80T`\xFF`\xA8\x1B\x19\x81\x16`\x03`\xA8\x1B\x17\x90\x91U\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\tlW\x81\x80\x91`\x04`@Q\x80\x94\x81\x93cA\xC0\xE1\xB5`\xE0\x1B\x83RZ\xF1\x80\x15a\t\x1BWa\t\x0BWP\xF3[`@Qckb%Q`\xE1\x1B\x81R`\x04\x90\xFD[P`\x06T\x15\x15a\r\xFEV[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDW3\x81R`\x01` R`@\x81 T\x80\x15a\x0E\xFBW3\x82R`\x01` R`@\x82 \x82\x90U`\x0BT\x82\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x02.W\x81\x80\x91`$`@Q\x80\x94\x81\x93c\x1F\x0E\x07w`\xE3\x1B\x83R\x88`\x04\x84\x01RZ\xF1\x80\x15a\t\x1BWa\x0E\xE7W[Pa\x02\x19\x823a\x1A3V[a\x0E\xF0\x90a\x16\xF5V[a\x02.W\x818a\x0E\xDCV[`@Qcg0\x0F\x91`\xE1\x1B\x81R`\x04\x90\xFD[P\x80`\x03\x196\x01\x12a\x01\xCDWa\x0F!a\x19\xE3V[4\x15a\x02\x80Wa\x0F03a\x1D\x84V[\x15a\x02\x1CWa\x02\x1943a\x1E\xA1V[P4a\x01\xCDW\x80`\x03\x196\x01\x12a\x01\xCDWa\x0FXa\x19\xE3V[a\xFF\xFF\x80`\x17T\x16\x81`\x14T\x16\x01\x81\x81\x11a\x0F\xBEW\x16a\x0ENW`\x0B\x80T`\xFF`\xA8\x1B\x19\x81\x16`\x03`\xA8\x1B\x17\x90\x91U\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\tlW\x81\x80\x91`\x04`@Q\x80\x94\x81\x93cA\xC0\xE1\xB5`\xE0\x1B\x83RZ\xF1\x80\x15a\t\x1BWa\t\x0BWP\xF3[cNH{q`\xE0\x1B\x83R`\x11`\x04R`$\x83\xFD[P4a\x01\xCDW` \x80`\x03\x196\x01\x12a\x02.W`\x045`\x01`\x01`\xA0\x1B\x03\x81\x16\x81\x03a\x11_W```@\x80Qa\x10\x07\x81a\x17\x08V[\x85\x81R\x85\x85\x82\x01R\x01Ra\x10\x1A3a\x1D\x84V[\x15a\x02\x1CW`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x91`@Q\x92a\x10D\x84a\x17\x08V[\x80T\x84R`\x01\x90`\x02\x82\x82\x01T\x91\x85\x87\x01\x92\x83R\x01`@Q\x80\x93\x85\x90\x83T\x93a\x10l\x85a\x18\x97V[\x94\x85\x85R\x89\x83\x82\x16\x91\x82`\0\x14a\x11=WPP`\x01\x14a\x11\x01W[PPa\x10\x9B\x92P\x96\x94\x95\x93\x92\x96\x03\x82a\x17#V[`@\x83\x01\x90\x81R`@Q\x94\x85\x93\x83\x85RQ\x83\x85\x01RQ`@\x84\x01RQ\x92``\x80\x84\x01R\x83Q\x91\x82`\x80\x85\x01R\x81[\x83\x81\x10a\x10\xEAWPP`\xA0\x80\x94P\x82\x84\x01\x01R`\x1F\x80\x19\x91\x01\x16\x81\x01\x03\x01\x90\xF3[\x80\x86\x01\x82\x01Q\x87\x82\x01`\xA0\x01R\x86\x94P\x81\x01a\x10\xC9V[\x88\x92P\x87R\x81\x87 \x90\x87\x91[\x85\x83\x10a\x11%WPPa\x10\x9B\x93P\x82\x01\x018\x80a\x10\x87V[\x80T\x83\x89\x01\x85\x01R\x87\x94P\x89\x93\x90\x92\x01\x91\x81\x01a\x11\rV[\x92P\x93PPa\x10\x9B\x94\x91P`\xFF\x19\x16\x82\x84\x01R\x15\x15`\x05\x1B\x82\x01\x018\x80a\x10\x87V[`\0\x80\xFD[P4a\x01\xCDW`\x03\x19`\x806\x82\x01\x12a\x02.W`\x01`\x01`@\x1B\x03`\x045\x11a\x02.W`\xA0\x90`\x0456\x03\x01\x12a\x01\xCDW`$5`\x01`\x01`@\x1B\x03\x81\x11a\x02.Wa\x11\xB4\x906\x90`\x04\x01a\x16\x84V[\x90`D5`\x01`\x01`@\x1B\x03\x81\x11a\x0B\xAAWa\x11\xD4\x906\x90`\x04\x01a\x16\x84V[\x90`d5`\x01`\x01`@\x1B\x03\x81\x11a\x15\x02Wa\x11\xF4\x906\x90`\x04\x01a\x16\x84V[\x93\x90\x94a\x12\x05`$`\x045\x01a\x1B\x97V[`\x01`\x01`@\x1B\x03\x80`\x05T\x16\x91\x16\x11\x15a\x16sWa\x12(`$`\x045\x01a\x1B\x97V[`\x01`\x01`@\x1B\x03`\x08T`\x80\x1C\x16\x90\x81\x15a\x16_W\x90`\x01`\x01`@\x1B\x03\x80\x92\x16\x06\x16a\x16MW`\xFF`\x0BT`\xA8\x1C\x16`\x06\x81\x10\x15a\x169W`\x01\x03a\x16'W\x90`@Q\x80\x92` \x80\x83\x01R\x80`@\x83\x01R``\x82\x01``\x82`\x05\x1B\x84\x01\x01\x91\x84\x8B\x90[\x82\x82\x10a\x15\x18WPPPPa\x12\xAB\x92P\x03`\x1F\x19\x81\x01\x83R\x82a\x17#V[` \x81Q\x91\x01 `\x84`\x045\x015\x03a\x15\x06Wa\x13\r\x93a\x12\xFFa\x13\x07\x92`@Qa\x12\xF0\x81a\x12\xE2`\x045`\x04\x01` \x83\x01a\x1D V[\x03`\x1F\x19\x81\x01\x83R\x82a\x17#V[` \x81Q\x91\x01 \x946\x91a\x17[V[\x936\x91a\x17\xCCV[\x91a\x1FEV[`\x01`\x01`@\x1B\x03a\x13#`$`\x045\x01a\x1B\x97V[\x16\x81R`\x04` R`@\x81 `\x045`\x04\x015`B\x19`\x0456\x03\x01\x81\x12\x15a\x03\xF1W`\x045\x01\x90`\x01`\x01`@\x1B\x03a\x13_`\x04\x84\x01a\x1B\x97V[\x16\x91`\x01`\x01`@\x1B\x03\x19\x92\x83\x83T\x16\x17\x82U`\x01\x82\x01\x90`$\x81\x015\x90`\"\x19\x816\x03\x01\x82\x12\x15a\x15\x02W\x01`\x04\x81\x015\x90`\x01`\x01`@\x1B\x03\x82\x11a\x15\x02W`$\x01\x81`\x05\x1B6\x03\x81\x13a\x15\x02W`\x01`@\x1B\x82\x11a\x14\xEEW\x82T\x82\x84U\x80\x83\x10a\x14\xD3W[P\x91\x85R` \x85 \x91\x85[\x82\x81\x10a\x14\xAEWPPPP`\x02\x81\x01`\x01`\x01`@\x1B\x03a\x13\xF7`$`\x045\x01a\x1B\x97V[\x16\x83\x82T\x16\x17\x90U`D`\x045\x015`\x03\x82\x01U`\x04\x81\x01`\x01`\x01`@\x1B\x03a\x14%`d`\x045\x01a\x1B\x97V[\x16\x83\x82T\x16\x17\x90U`\x05`\x84`\x045\x015\x91\x01U`\x01`\x01`@\x1B\x03a\x14O`$`\x045\x01a\x1B\x97V[`\x05\x80T\x90\x93\x16\x91\x16\x17\x90U`\x0BT`\x01`\x01`\xA0\x1B\x03\x16\x80;\x15a\x02.W\x81`@Q\x80\x92c \r\x97\x05`\xE0\x1B\x82R\x81\x83\x81a\x14\x93`\x045`\x04\x01`\x04\x83\x01a\x1D V[\x03\x92Z\xF1\x80\x15a\t\x1BWa\x14\xA5WP\x80\xF3[a\x02\x19\x90a\x16\xF5V[\x815\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\x03\xE9W` `\x01\x92\x93\x01\x92\x81\x86\x01U\x01a\x13\xD2V[\x83\x87R` \x87 a\x14\xE8\x91\x81\x01\x90\x84\x01a\x18\xD1V[8a\x13\xC7V[cNH{q`\xE0\x1B\x86R`A`\x04R`$\x86\xFD[\x85\x80\xFD[`@Qc-\x7Fu\x03`\xE2\x1B\x81R`\x04\x90\xFD[\x91\x93\x90\x92\x94P`_\x19\x87\x82\x03\x01\x85Ra\x151\x86\x83a\x1B\xABV[\x90`\xBE\x19\x826\x03\x01\x825\x12\x15a\x16#W\x81\x805\x01`@\x82Ra\x15ha\x15V\x82\x80a\x1B\xABV[`\xC0`@\x85\x01Ra\x01\0\x84\x01\x90a\x1C\xB7V[\x90a\x15\x8Da\x15y` \x83\x01\x83a\x1B\xABV[\x92`?\x19\x93\x84\x86\x83\x03\x01``\x87\x01Ra\x1C\xB7V[`@\x82\x015`\x80\x85\x01R`\x01`\x01`@\x1B\x03a\x15\xAB``\x84\x01a\x1B\xBFV[\x16`\xA0\x85\x01R`\x80\x82\x015\x92c\xFF\xFF\xFF\xFF`\xE0\x1B\x84\x16\x80\x94\x03a\x16\x1EWa\x15\xE1a\x15\xF0\x93` \x95`\xC0\x88\x01R`\xA0\x81\x01\x90a\x1CeV[\x91\x86\x84\x03\x01`\xE0\x87\x01Ra\x1C\x96V[\x92\x015\x80\x15\x15\x81\x03a\x16\x1AW`\x01\x92` \x92\x83\x80\x93\x15\x15\x91\x01R\x97\x01\x95\x01\x92\x01\x86\x94\x95\x93\x91a\x12\x8DV[\x8D\x80\xFD[P\x8F\x80\xFD[\x8C\x80\xFD[`@Qc\xC1\x83\x16\xBF`\xE0\x1B\x81R`\x04\x90\xFD[cNH{q`\xE0\x1B\x88R`!`\x04R`$\x88\xFD[`@Qc\xFA\xE4\xEA\xDB`\xE0\x1B\x81R`\x04\x90\xFD[cNH{q`\xE0\x1B\x89R`\x12`\x04R`$\x89\xFD[c\x14\xFB\xADO`\xE3\x1B`\x80R`\x04`\x80\xFD[\x91\x81`\x1F\x84\x01\x12\x15a\x11_W\x825\x91`\x01`\x01`@\x1B\x03\x83\x11a\x11_W` \x80\x85\x01\x94\x84`\x05\x1B\x01\x01\x11a\x11_WV[5\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\x11_WV[\x91\x81`\x1F\x84\x01\x12\x15a\x11_W\x825\x91`\x01`\x01`@\x1B\x03\x83\x11a\x11_W` \x83\x81\x86\x01\x95\x01\x01\x11a\x11_WV[`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8W`@RV[``\x81\x01\x90\x81\x10`\x01`\x01`@\x1B\x03\x82\x11\x17a\r\xA8W`@RV[\x90`\x1F\x80\x19\x91\x01\x16\x81\x01\x90\x81\x10`\x01`\x01`@\x1B\x03\x82\x11\x17a\r\xA8W`@RV[`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8W`\x05\x1B` \x01\x90V[\x92\x91a\x17f\x82a\x17DV[\x91a\x17t`@Q\x93\x84a\x17#V[\x82\x94\x81\x84R` \x80\x94\x01\x91`\x05\x1B\x81\x01\x92\x83\x11a\x11_W\x90[\x82\x82\x10a\x17\x9AWPPPPV[\x83\x80\x91a\x17\xA6\x84a\x16\xB4V[\x81R\x01\x91\x01\x90a\x17\x8DV[`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8W`\x1F\x01`\x1F\x19\x16` \x01\x90V[\x92\x91\x90\x92a\x17\xD9\x84a\x17DV[\x91`@\x94a\x17\xE9\x86Q\x94\x85a\x17#V[\x83\x95\x81\x85R` \x80\x95\x01\x91`\x05\x1B\x84\x01\x93\x83\x85\x11a\x11_W\x80\x92[\x85\x84\x10a\x18\x14WPPPPPPPV[\x835`\x01`\x01`@\x1B\x03\x81\x11a\x11_W\x82\x01\x85`\x1F\x82\x01\x12\x15a\x11_W\x805\x91a\x18=\x83a\x17\xB1V[a\x18I\x86Q\x91\x82a\x17#V[\x83\x81R\x87\x8A\x85\x85\x01\x01\x11a\x11_W`\0\x8A\x85\x81\x96\x82\x80\x97\x01\x83\x86\x017\x83\x01\x01R\x81R\x01\x93\x01\x92a\x18\x04V[\x91\x90\x82\x01\x80\x92\x11a\x18\x81WV[cNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[\x90`\x01\x82\x81\x1C\x92\x16\x80\x15a\x18\xC7W[` \x83\x10\x14a\x18\xB1WV[cNH{q`\xE0\x1B`\0R`\"`\x04R`$`\0\xFD[\x91`\x7F\x16\x91a\x18\xA6V[\x81\x81\x10a\x18\xDCWPPV[`\0\x81U`\x01\x01a\x18\xD1V[\x91\x90`\x1F\x81\x11a\x18\xF7WPPPV[a\x19#\x92`\0R` `\0 \x90` `\x1F\x84\x01`\x05\x1C\x83\x01\x93\x10a\x19%W[`\x1F\x01`\x05\x1C\x01\x90a\x18\xD1V[V[\x90\x91P\x81\x90a\x19\x16V[`\x0CT\x81\x10\x15a\x06oW`\x0C`\0R\x7F\xDFif\xC9q\x05\x1C=T\xECY\x16&\x06S\x14\x93\xA5\x14\x04\xA0\x02\x84/V\0\x9D~\\\xF4\xA8\xC7\x01\x90`\0\x90V[`\0\x81\x81R`\r` R`@\x81 Ta\x19\xDEW`\x0CT`\x01`@\x1B\x81\x10\x15a\x19\xCAW\x90\x82a\x19\xB6a\x19\x9F\x84`\x01`@\x96\x01`\x0CUa\x19/V[\x81\x93\x91T\x90`\x03\x1B\x91\x82\x1B\x91`\0\x19\x90\x1B\x19\x16\x17\x90V[\x90U`\x0CT\x92\x81R`\r` R U`\x01\x90V[cNH{q`\xE0\x1B\x82R`A`\x04R`$\x82\xFD[\x90P\x90V[`\xFF`\x0BT`\xA8\x1C\x16`\x06\x81\x10\x15a\x1A\x10W`\x03\x14a\x19\xFEWV[`@Qc$\x8C\x8E\xFB`\xE1\x1B\x81R`\x04\x90\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[\x91\x90\x82\x03\x91\x82\x11a\x18\x81WV[\x81G\x10a\x1A\x95W`\0\x91\x82\x91\x82\x91\x82\x91`\x01`\x01`\xA0\x1B\x03\x16Z\xF1=\x15a\x1A\x90W=a\x1A^\x81a\x17\xB1V[\x90a\x1Al`@Q\x92\x83a\x17#V[\x81R`\0` =\x92\x01>[\x15a\x1A~WV[`@Qc\n\x12\xF5!`\xE1\x1B\x81R`\x04\x90\xFD[a\x1AwV[`@Qc\xCDx`Y`\xE0\x1B\x81R0`\x04\x82\x01R`$\x90\xFD[`\0\x81\x81R`\r` R`@\x81 T\x90\x91\x90\x80\x15a\x1B\x92W`\0\x19\x90\x80\x82\x01\x81\x81\x11a\x1B~W`\x0CT\x90\x83\x82\x01\x91\x82\x11a\x1BjW\x80\x82\x03a\x1B6W[PPP`\x0CT\x80\x15a\x1B\"W\x81\x01\x90a\x1B\x01\x82a\x19/V[\x90\x91\x82T\x91`\x03\x1B\x1B\x19\x16\x90U`\x0CU\x81R`\r` R`@\x81 U`\x01\x90V[cNH{q`\xE0\x1B\x84R`1`\x04R`$\x84\xFD[a\x1BTa\x1BEa\x19\x9F\x93a\x19/V[\x90T\x90`\x03\x1B\x1C\x92\x83\x92a\x19/V[\x90U\x84R`\r` R`@\x84 U8\x80\x80a\x1A\xE9V[cNH{q`\xE0\x1B\x86R`\x11`\x04R`$\x86\xFD[cNH{q`\xE0\x1B\x85R`\x11`\x04R`$\x85\xFD[PP\x90V[5`\x01`\x01`@\x1B\x03\x81\x16\x81\x03a\x11_W\x90V[\x905`>\x19\x826\x03\x01\x81\x12\x15a\x11_W\x01\x90V[5\x90`\x01`\x01`@\x1B\x03\x82\x16\x82\x03a\x11_WV[`\x01`\x01`@\x1B\x03\x91\x90`@\x82\x01\x83a\x1B\xEB\x83a\x1B\xBFV[\x16\x83R` \x91\x82\x81\x015`\x1E\x19\x826\x03\x01\x81\x12\x15a\x11_W\x01\x92\x82\x845\x94\x01\x94\x84\x11a\x11_W\x83`\x05\x1B6\x03\x85\x13a\x11_W`@\x81\x84\x01R\x90\x83\x90R``\x01\x92\x91\x90`\0[\x82\x81\x10a\x1C>WPPPP\x90V[\x90\x91\x92\x93\x82\x80`\x01\x92\x83\x80`\xA0\x1B\x03a\x1CV\x89a\x16\xB4V[\x16\x81R\x01\x95\x01\x93\x92\x91\x01a\x1C0V[\x905`\x1E\x19\x826\x03\x01\x81\x12\x15a\x11_W\x01` \x815\x91\x01\x91`\x01`\x01`@\x1B\x03\x82\x11a\x11_W\x816\x03\x83\x13a\x11_WV[\x90\x80` \x93\x92\x81\x84R\x84\x84\x017`\0\x82\x82\x01\x84\x01R`\x1F\x01`\x1F\x19\x16\x01\x01\x90V[a\x1C\xE0a\x1C\xD5a\x1C\xC7\x83\x80a\x1B\xABV[`@\x85R`@\x85\x01\x90a\x1B\xD3V[\x91` \x81\x01\x90a\x1B\xABV[\x91` \x81\x83\x03\x91\x01R\x815\x91`\xFF\x83\x16\x80\x93\x03a\x11_Wa\x1D\r`@\x91a\x1D\x1D\x94\x84R` \x81\x01\x90a\x1CeV[\x91\x90\x92\x81` \x82\x01R\x01\x91a\x1C\x96V[\x90V[` \x81R`\xA0`\x80a\x1DEa\x1D5\x85\x80a\x1B\xABV[\x83` \x86\x01R`\xC0\x85\x01\x90a\x1B\xD3V[\x93`\x01`\x01`@\x1B\x03\x80a\x1D[` \x84\x01a\x1B\xBFV[\x16`@\x86\x01R`@\x82\x015``\x86\x01Ra\x1Dw``\x83\x01a\x1B\xBFV[\x16\x82\x85\x01R\x015\x91\x01R\x90V[`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x18` R`@\x90 Ta\xFF\xFF\x90\x81\x16\x15\x80\x15\x91\x90a\x1D\xAFWP\x90V[\x90P`\x15` R`@`\0 T\x16\x15\x15\x90V[`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x90\x92\x91\x90`\x02\x01\x90`\x01`\x01`@\x1B\x03\x81\x11a\r\xA8Wa\x1E\x03\x81a\x1D\xFD\x84Ta\x18\x97V[\x84a\x18\xE8V[`\0`\x1F\x82\x11`\x01\x14a\x1E=W\x81\x92\x93\x94`\0\x92a\x1E2W[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90UV[\x015\x90P8\x80a\x1E\x1CV[`\x1F\x19\x82\x16\x94\x83\x82R` \x91\x82\x81 \x92\x81\x90[\x88\x82\x10a\x1E\x89WPP\x83`\x01\x95\x96\x97\x10a\x1EoW[PPP\x81\x1B\x01\x90UV[\x015`\0\x19`\x03\x84\x90\x1B`\xF8\x16\x1C\x19\x16\x90U8\x80\x80a\x1EeV[\x80`\x01\x84\x96\x82\x94\x95\x87\x015\x81U\x01\x95\x01\x92\x01\x90a\x1EPV[`\x01a\x1F a\x1F)\x92\x7F\xB2\xF7\xC5\xADm\x04\xDB\xEB\x9E\x16\x1Bgbs\xC7\x07\xE9\x02\x9E(\xA5\n\x81\xB4I\xB0pq.\x0C\x18\xF2`\x80`\x01`\x01`@\x1B\x03`\x1AT\x16a\x1E\xE5a\x019\x82a\x1F-V[`@Q\x90`\0\x82R\x86\x80`\xA0\x1B\x03\x85\x16` \x83\x01R\x88`@\x83\x01R``\x82\x01R\xA1`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x90V[\x01\x91\x82Ta\x18tV[\x90UV[\x90`\x01`\x01`\x01`@\x1B\x03\x80\x93\x16\x01\x91\x82\x11a\x18\x81WV[\x90\x91\x81Q\x92a\x1FS\x84a\x17DV[\x92`@\x94a\x1Fc\x86Q\x95\x86a\x17#V[\x80\x85R`\x1F\x19a\x1Fr\x82a\x17DV[\x01\x90` \x916\x83\x88\x017`\0[\x81\x81\x10a\x1F\xDFWPP`\x12T`\x0BT`\xA0\x1C`\xFF\x16\x80\x82\x02\x96\x92P\x81\x15\x91\x87\x04\x14\x17\x15a\x18\x81W`da\x1F\xB3\x95\x04\x91a mV[\x90\x15a\x1F\xBDWPPV[`\x07\x81\x10\x15a\x1A\x10W`\xFF`$\x92Q\x91c(.\xF1\xC1`\xE0\x1B\x83R\x16`\x04\x82\x01R\xFD[`\x01`\x01`\xA0\x1B\x03\x80a\x1F\xF2\x83\x87a YV[Q\x16`\0R`\x15\x84Ra\xFF\xFF\x89`\0 T\x16\x15a HW\x90a 6`\x01\x92a \x1A\x83\x88a YV[Q\x16`\x01`\x01`\xA0\x1B\x03\x16`\0\x90\x81R`\x13` R`@\x90 \x90V[Ta A\x82\x8Aa YV[R\x01a\x1F\x7FV[\x88Qc.\xC5\xB4I`\xE0\x1B\x81R`\x04\x90\xFD[\x80Q\x82\x10\x15a\x06oW` \x91`\x05\x1B\x01\x01\x90V[\x84Q\x92\x94`\0\x94\x90\x84\x15a!oW\x82Q\x85\x14\x80\x15\x90a!dW[a!WW\x93\x92\x91\x90\x85\x94[\x84\x86\x10a \xB5WPPPPPP\x10\x15a \xADW`\0\x90`\x06\x90V[`\x01\x90`\0\x90V[\x90\x91\x92\x93\x94\x95a \xCFa \xC8\x88\x84a YV[Q\x84a!|V[P\x90`\x04\x91\x82\x81\x10\x15a!BWa!0W`\x01`\x01`\xA0\x1B\x03\x80a \xF3\x8B\x89a YV[Q\x16\x91\x16\x03a! WPa!\x14`\x01\x91a!\r\x89\x88a YV[Q\x90a\x18tV[\x96\x01\x94\x93\x92\x91\x90a \x92V[\x98\x97PPPPPPPP`\0\x91\x90V[PPPPPPPPPP`\0\x90`\x05\x90V[`!\x83cNH{q`\xE0\x1B`\0RR`$`\0\xFD[PPPPP\x90P\x90`\x01\x90V[P\x83Q\x85\x14\x15a \x87V[PPPPP\x90P\x90`\x02\x90V[\x81Q\x91\x90`A\x83\x03a!\xADWa!\xA6\x92P` \x82\x01Q\x90```@\x84\x01Q\x93\x01Q`\0\x1A\x90a!\xB8V[\x91\x92\x90\x91\x90V[PP`\0\x91`\x02\x91\x90V[\x91\x90\x7F\x7F\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF]WnsW\xA4P\x1D\xDF\xE9/Fh\x1B \xA0\x84\x11a\"<W\x92` \x92\x91`\xFF`\x80\x95`@Q\x94\x85R\x16\x84\x84\x01R`@\x83\x01R``\x82\x01R`\0\x92\x83\x91\x82\x80R`\x01Z\xFA\x15a\"0W\x80Q`\x01`\x01`\xA0\x1B\x03\x81\x16\x15a\"'W\x91\x81\x90V[P\x80\x91`\x01\x91\x90V[`@Q\x90=\x90\x82>=\x90\xFD[PPP`\0\x91`\x03\x91\x90V\xFE\xA2dipfsX\"\x12 \x9DnF\x12\xCA\xF0\xAC\xCB\xFC\x04\x005\x98\xB26\xA6\x7F\xE6\xF4\xE5\x96\xFE\x82\xA8\x13\xE3\xA2\xA0G\x01\xA6\x8DdsolcC\0\x08\x13\x003";
    /// The deployed bytecode of the contract.
    pub static SUBNETACTORMANAGERFACET_DEPLOYED_BYTECODE: ::ethers::core::types::Bytes =
        ::ethers::core::types::Bytes::from_static(__DEPLOYED_BYTECODE);
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
        /// Constructs the general purpose `Deployer` instance based on the provided constructor arguments and sends it.
        /// Returns a new instance of a deployer that returns an instance of this contract after sending the transaction
        ///
        /// Notes:
        /// - If there are no constructor arguments, you should pass `()` as the argument.
        /// - The default poll duration is 7 seconds.
        /// - The default number of confirmations is 1 block.
        ///
        ///
        /// # Example
        ///
        /// Generate contract bindings with `abigen!` and deploy a new contract instance.
        ///
        /// *Note*: this requires a `bytecode` and `abi` object in the `greeter.json` artifact.
        ///
        /// ```ignore
        /// # async fn deploy<M: ethers::providers::Middleware>(client: ::std::sync::Arc<M>) {
        ///     abigen!(Greeter, "../greeter.json");
        ///
        ///    let greeter_contract = Greeter::deploy(client, "Hello world!".to_string()).unwrap().send().await.unwrap();
        ///    let msg = greeter_contract.greet().call().await.unwrap();
        /// # }
        /// ```
        pub fn deploy<T: ::ethers::core::abi::Tokenize>(
            client: ::std::sync::Arc<M>,
            constructor_args: T,
        ) -> ::core::result::Result<
            ::ethers::contract::builders::ContractDeployer<M, Self>,
            ::ethers::contract::ContractError<M>,
        > {
            let factory = ::ethers::contract::ContractFactory::new(
                SUBNETACTORMANAGERFACET_ABI.clone(),
                SUBNETACTORMANAGERFACET_BYTECODE.clone().into(),
                client,
            );
            let deployer = factory.deploy(constructor_args)?;
            let deployer = ::ethers::contract::ContractDeployer::new(deployer);
            Ok(deployer)
        }
        ///Calls the contract's `claim` (0x4e71d92d) function
        pub fn claim(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([78, 113, 217, 45], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getValidator` (0x1904bb2e) function
        pub fn get_validator(
            &self,
            validator_address: ::ethers::core::types::Address,
        ) -> ::ethers::contract::builders::ContractCall<M, Validator> {
            self.0
                .method_hash([25, 4, 187, 46], validator_address)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `join` (0x6cf6970a) function
        pub fn join(
            &self,
            net_addr: ::std::string::String,
            worker_addr: FvmAddress,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([108, 246, 151, 10], (net_addr, worker_addr))
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `join2` (0xedb0ff83) function
        pub fn join_2(
            &self,
            data: ::ethers::core::types::Bytes,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([237, 176, 255, 131], data)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `kill` (0x41c0e1b5) function
        pub fn kill(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([65, 192, 225, 181], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `kill2` (0x2bb685bc) function
        pub fn kill_2(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([43, 182, 133, 188], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `leave` (0xd66d9e19) function
        pub fn leave(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([214, 109, 158, 25], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `leave2` (0xf5904fcf) function
        pub fn leave_2(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([245, 144, 79, 207], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `reward` (0xa9fb763c) function
        pub fn reward(
            &self,
            amount: ::ethers::core::types::U256,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([169, 251, 118, 60], amount)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `setMetadata` (0xee57e36f) function
        pub fn set_metadata(
            &self,
            metadata: ::ethers::core::types::Bytes,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([238, 87, 227, 111], metadata)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `setValidatorNetAddr` (0x7cc4fc43) function
        pub fn set_validator_net_addr(
            &self,
            new_net_addr: ::std::string::String,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([124, 196, 252, 67], new_net_addr)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `setValidatorWorkerAddr` (0xe8ef872f) function
        pub fn set_validator_worker_addr(
            &self,
            new_worker_addr: FvmAddress,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([232, 239, 135, 47], (new_worker_addr,))
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
        ///Calls the contract's `withdraw` (0x3ccfd60b) function
        pub fn withdraw(&self) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash([60, 207, 214, 11], ())
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
    ///Custom Error type `AddressInsufficientBalance` with signature `AddressInsufficientBalance(address)` and selector `0xcd786059`
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
        name = "AddressInsufficientBalance",
        abi = "AddressInsufficientBalance(address)"
    )]
    pub struct AddressInsufficientBalance {
        pub account: ::ethers::core::types::Address,
    }
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
    ///Custom Error type `EmptyAddress` with signature `EmptyAddress()` and selector `0x7138356f`
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
    #[etherror(name = "EmptyAddress", abi = "EmptyAddress()")]
    pub struct EmptyAddress;
    ///Custom Error type `FailedInnerCall` with signature `FailedInnerCall()` and selector `0x1425ea42`
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
    #[etherror(name = "FailedInnerCall", abi = "FailedInnerCall()")]
    pub struct FailedInnerCall;
    ///Custom Error type `HeightAlreadyExecuted` with signature `HeightAlreadyExecuted()` and selector `0xa7dd6a78`
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
    #[etherror(name = "HeightAlreadyExecuted", abi = "HeightAlreadyExecuted()")]
    pub struct HeightAlreadyExecuted;
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
    ///Custom Error type `NoRewardToWithdraw` with signature `NoRewardToWithdraw()` and selector `0xce601f22`
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
    #[etherror(name = "NoRewardToWithdraw", abi = "NoRewardToWithdraw()")]
    pub struct NoRewardToWithdraw;
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
    ///Custom Error type `SubnetNotActive` with signature `SubnetNotActive()` and selector `0xc18316bf`
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
    #[etherror(name = "SubnetNotActive", abi = "SubnetNotActive()")]
    pub struct SubnetNotActive;
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
        AddressInsufficientBalance(AddressInsufficientBalance),
        CollateralIsZero(CollateralIsZero),
        EmptyAddress(EmptyAddress),
        FailedInnerCall(FailedInnerCall),
        HeightAlreadyExecuted(HeightAlreadyExecuted),
        InvalidCheckpointEpoch(InvalidCheckpointEpoch),
        InvalidCheckpointMessagesHash(InvalidCheckpointMessagesHash),
        InvalidSignatureErr(InvalidSignatureErr),
        NoCollateralToWithdraw(NoCollateralToWithdraw),
        NoRewardToWithdraw(NoRewardToWithdraw),
        NoValidatorsInSubnet(NoValidatorsInSubnet),
        NotAllValidatorsHaveLeft(NotAllValidatorsHaveLeft),
        NotEnoughBalanceForRewards(NotEnoughBalanceForRewards),
        NotGateway(NotGateway),
        NotStakedBefore(NotStakedBefore),
        NotValidator(NotValidator),
        ReentrancyError(ReentrancyError),
        SubnetAlreadyKilled(SubnetAlreadyKilled),
        SubnetNotActive(SubnetNotActive),
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
                <AddressInsufficientBalance as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::AddressInsufficientBalance(decoded));
            }
            if let Ok(decoded) = <CollateralIsZero as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::CollateralIsZero(decoded));
            }
            if let Ok(decoded) = <EmptyAddress as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::EmptyAddress(decoded));
            }
            if let Ok(decoded) = <FailedInnerCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::FailedInnerCall(decoded));
            }
            if let Ok(decoded) =
                <HeightAlreadyExecuted as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::HeightAlreadyExecuted(decoded));
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
                <NoRewardToWithdraw as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NoRewardToWithdraw(decoded));
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
            if let Ok(decoded) = <NotStakedBefore as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::NotStakedBefore(decoded));
            }
            if let Ok(decoded) = <NotValidator as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::NotValidator(decoded));
            }
            if let Ok(decoded) = <ReentrancyError as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::ReentrancyError(decoded));
            }
            if let Ok(decoded) =
                <SubnetAlreadyKilled as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::SubnetAlreadyKilled(decoded));
            }
            if let Ok(decoded) = <SubnetNotActive as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::SubnetNotActive(decoded));
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
                Self::AddressInsufficientBalance(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CollateralIsZero(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::EmptyAddress(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::FailedInnerCall(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::HeightAlreadyExecuted(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
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
                Self::NoRewardToWithdraw(element) => {
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
                Self::NotStakedBefore(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::NotValidator(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::ReentrancyError(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::SubnetAlreadyKilled(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::SubnetNotActive(element) => ::ethers::core::abi::AbiEncode::encode(element),
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
                    == <AddressInsufficientBalance as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CollateralIsZero as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <EmptyAddress as ::ethers::contract::EthError>::selector() => true,
                _ if selector
                    == <FailedInnerCall as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <HeightAlreadyExecuted as ::ethers::contract::EthError>::selector() => {
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
                    == <NoRewardToWithdraw as ::ethers::contract::EthError>::selector() => {
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
                    == <NotStakedBefore as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotValidator as ::ethers::contract::EthError>::selector() => true,
                _ if selector
                    == <ReentrancyError as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <SubnetAlreadyKilled as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <SubnetNotActive as ::ethers::contract::EthError>::selector() => {
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
                Self::AddressInsufficientBalance(element) => ::core::fmt::Display::fmt(element, f),
                Self::CollateralIsZero(element) => ::core::fmt::Display::fmt(element, f),
                Self::EmptyAddress(element) => ::core::fmt::Display::fmt(element, f),
                Self::FailedInnerCall(element) => ::core::fmt::Display::fmt(element, f),
                Self::HeightAlreadyExecuted(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidCheckpointEpoch(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidCheckpointMessagesHash(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidSignatureErr(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoCollateralToWithdraw(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoRewardToWithdraw(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoValidatorsInSubnet(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotAllValidatorsHaveLeft(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotEnoughBalanceForRewards(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotGateway(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotStakedBefore(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotValidator(element) => ::core::fmt::Display::fmt(element, f),
                Self::ReentrancyError(element) => ::core::fmt::Display::fmt(element, f),
                Self::SubnetAlreadyKilled(element) => ::core::fmt::Display::fmt(element, f),
                Self::SubnetNotActive(element) => ::core::fmt::Display::fmt(element, f),
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
    impl ::core::convert::From<AddressInsufficientBalance> for SubnetActorManagerFacetErrors {
        fn from(value: AddressInsufficientBalance) -> Self {
            Self::AddressInsufficientBalance(value)
        }
    }
    impl ::core::convert::From<CollateralIsZero> for SubnetActorManagerFacetErrors {
        fn from(value: CollateralIsZero) -> Self {
            Self::CollateralIsZero(value)
        }
    }
    impl ::core::convert::From<EmptyAddress> for SubnetActorManagerFacetErrors {
        fn from(value: EmptyAddress) -> Self {
            Self::EmptyAddress(value)
        }
    }
    impl ::core::convert::From<FailedInnerCall> for SubnetActorManagerFacetErrors {
        fn from(value: FailedInnerCall) -> Self {
            Self::FailedInnerCall(value)
        }
    }
    impl ::core::convert::From<HeightAlreadyExecuted> for SubnetActorManagerFacetErrors {
        fn from(value: HeightAlreadyExecuted) -> Self {
            Self::HeightAlreadyExecuted(value)
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
    impl ::core::convert::From<NoRewardToWithdraw> for SubnetActorManagerFacetErrors {
        fn from(value: NoRewardToWithdraw) -> Self {
            Self::NoRewardToWithdraw(value)
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
    impl ::core::convert::From<SubnetNotActive> for SubnetActorManagerFacetErrors {
        fn from(value: SubnetNotActive) -> Self {
            Self::SubnetNotActive(value)
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
    ///Container type for all of the contract's events
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetActorManagerFacetEvents {
        BottomUpCheckpointExecutedFilter(BottomUpCheckpointExecutedFilter),
        BottomUpCheckpointSubmittedFilter(BottomUpCheckpointSubmittedFilter),
        NextBottomUpCheckpointExecutedFilter(NextBottomUpCheckpointExecutedFilter),
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
    ///Container type for all input parameters for the `getValidator` function with signature `getValidator(address)` and selector `0x1904bb2e`
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
    #[ethcall(name = "getValidator", abi = "getValidator(address)")]
    pub struct GetValidatorCall {
        pub validator_address: ::ethers::core::types::Address,
    }
    ///Container type for all input parameters for the `join` function with signature `join(string,(uint8,bytes))` and selector `0x6cf6970a`
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
    #[ethcall(name = "join", abi = "join(string,(uint8,bytes))")]
    pub struct JoinCall {
        pub net_addr: ::std::string::String,
        pub worker_addr: FvmAddress,
    }
    ///Container type for all input parameters for the `join2` function with signature `join2(bytes)` and selector `0xedb0ff83`
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
    #[ethcall(name = "join2", abi = "join2(bytes)")]
    pub struct Join2Call {
        pub data: ::ethers::core::types::Bytes,
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
    ///Container type for all input parameters for the `kill2` function with signature `kill2()` and selector `0x2bb685bc`
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
    #[ethcall(name = "kill2", abi = "kill2()")]
    pub struct Kill2Call;
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
    ///Container type for all input parameters for the `leave2` function with signature `leave2()` and selector `0xf5904fcf`
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
    #[ethcall(name = "leave2", abi = "leave2()")]
    pub struct Leave2Call;
    ///Container type for all input parameters for the `reward` function with signature `reward(uint256)` and selector `0xa9fb763c`
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
    #[ethcall(name = "reward", abi = "reward(uint256)")]
    pub struct RewardCall {
        pub amount: ::ethers::core::types::U256,
    }
    ///Container type for all input parameters for the `setMetadata` function with signature `setMetadata(bytes)` and selector `0xee57e36f`
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
    #[ethcall(name = "setMetadata", abi = "setMetadata(bytes)")]
    pub struct SetMetadataCall {
        pub metadata: ::ethers::core::types::Bytes,
    }
    ///Container type for all input parameters for the `setValidatorNetAddr` function with signature `setValidatorNetAddr(string)` and selector `0x7cc4fc43`
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
    #[ethcall(name = "setValidatorNetAddr", abi = "setValidatorNetAddr(string)")]
    pub struct SetValidatorNetAddrCall {
        pub new_net_addr: ::std::string::String,
    }
    ///Container type for all input parameters for the `setValidatorWorkerAddr` function with signature `setValidatorWorkerAddr((uint8,bytes))` and selector `0xe8ef872f`
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
        name = "setValidatorWorkerAddr",
        abi = "setValidatorWorkerAddr((uint8,bytes))"
    )]
    pub struct SetValidatorWorkerAddrCall {
        pub new_worker_addr: FvmAddress,
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
    ///Container type for all input parameters for the `withdraw` function with signature `withdraw()` and selector `0x3ccfd60b`
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
    #[ethcall(name = "withdraw", abi = "withdraw()")]
    pub struct WithdrawCall;
    ///Container type for all of the contract's call
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetActorManagerFacetCalls {
        Claim(ClaimCall),
        GetValidator(GetValidatorCall),
        Join(JoinCall),
        Join2(Join2Call),
        Kill(KillCall),
        Kill2(Kill2Call),
        Leave(LeaveCall),
        Leave2(Leave2Call),
        Reward(RewardCall),
        SetMetadata(SetMetadataCall),
        SetValidatorNetAddr(SetValidatorNetAddrCall),
        SetValidatorWorkerAddr(SetValidatorWorkerAddrCall),
        Stake(StakeCall),
        SubmitCheckpoint(SubmitCheckpointCall),
        ValidateActiveQuorumSignatures(ValidateActiveQuorumSignaturesCall),
        Withdraw(WithdrawCall),
    }
    impl ::ethers::core::abi::AbiDecode for SubnetActorManagerFacetCalls {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) = <ClaimCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Claim(decoded));
            }
            if let Ok(decoded) = <GetValidatorCall as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::GetValidator(decoded));
            }
            if let Ok(decoded) = <JoinCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Join(decoded));
            }
            if let Ok(decoded) = <Join2Call as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Join2(decoded));
            }
            if let Ok(decoded) = <KillCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Kill(decoded));
            }
            if let Ok(decoded) = <Kill2Call as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Kill2(decoded));
            }
            if let Ok(decoded) = <LeaveCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Leave(decoded));
            }
            if let Ok(decoded) = <Leave2Call as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Leave2(decoded));
            }
            if let Ok(decoded) = <RewardCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Reward(decoded));
            }
            if let Ok(decoded) = <SetMetadataCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::SetMetadata(decoded));
            }
            if let Ok(decoded) =
                <SetValidatorNetAddrCall as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::SetValidatorNetAddr(decoded));
            }
            if let Ok(decoded) =
                <SetValidatorWorkerAddrCall as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::SetValidatorWorkerAddr(decoded));
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
            if let Ok(decoded) = <WithdrawCall as ::ethers::core::abi::AbiDecode>::decode(data) {
                return Ok(Self::Withdraw(decoded));
            }
            Err(::ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ::ethers::core::abi::AbiEncode for SubnetActorManagerFacetCalls {
        fn encode(self) -> Vec<u8> {
            match self {
                Self::Claim(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::GetValidator(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Join(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Join2(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Kill(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Kill2(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Leave(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Leave2(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::Reward(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::SetMetadata(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::SetValidatorNetAddr(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::SetValidatorWorkerAddr(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::Stake(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::SubmitCheckpoint(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::ValidateActiveQuorumSignatures(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::Withdraw(element) => ::ethers::core::abi::AbiEncode::encode(element),
            }
        }
    }
    impl ::core::fmt::Display for SubnetActorManagerFacetCalls {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::Claim(element) => ::core::fmt::Display::fmt(element, f),
                Self::GetValidator(element) => ::core::fmt::Display::fmt(element, f),
                Self::Join(element) => ::core::fmt::Display::fmt(element, f),
                Self::Join2(element) => ::core::fmt::Display::fmt(element, f),
                Self::Kill(element) => ::core::fmt::Display::fmt(element, f),
                Self::Kill2(element) => ::core::fmt::Display::fmt(element, f),
                Self::Leave(element) => ::core::fmt::Display::fmt(element, f),
                Self::Leave2(element) => ::core::fmt::Display::fmt(element, f),
                Self::Reward(element) => ::core::fmt::Display::fmt(element, f),
                Self::SetMetadata(element) => ::core::fmt::Display::fmt(element, f),
                Self::SetValidatorNetAddr(element) => ::core::fmt::Display::fmt(element, f),
                Self::SetValidatorWorkerAddr(element) => ::core::fmt::Display::fmt(element, f),
                Self::Stake(element) => ::core::fmt::Display::fmt(element, f),
                Self::SubmitCheckpoint(element) => ::core::fmt::Display::fmt(element, f),
                Self::ValidateActiveQuorumSignatures(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::Withdraw(element) => ::core::fmt::Display::fmt(element, f),
            }
        }
    }
    impl ::core::convert::From<ClaimCall> for SubnetActorManagerFacetCalls {
        fn from(value: ClaimCall) -> Self {
            Self::Claim(value)
        }
    }
    impl ::core::convert::From<GetValidatorCall> for SubnetActorManagerFacetCalls {
        fn from(value: GetValidatorCall) -> Self {
            Self::GetValidator(value)
        }
    }
    impl ::core::convert::From<JoinCall> for SubnetActorManagerFacetCalls {
        fn from(value: JoinCall) -> Self {
            Self::Join(value)
        }
    }
    impl ::core::convert::From<Join2Call> for SubnetActorManagerFacetCalls {
        fn from(value: Join2Call) -> Self {
            Self::Join2(value)
        }
    }
    impl ::core::convert::From<KillCall> for SubnetActorManagerFacetCalls {
        fn from(value: KillCall) -> Self {
            Self::Kill(value)
        }
    }
    impl ::core::convert::From<Kill2Call> for SubnetActorManagerFacetCalls {
        fn from(value: Kill2Call) -> Self {
            Self::Kill2(value)
        }
    }
    impl ::core::convert::From<LeaveCall> for SubnetActorManagerFacetCalls {
        fn from(value: LeaveCall) -> Self {
            Self::Leave(value)
        }
    }
    impl ::core::convert::From<Leave2Call> for SubnetActorManagerFacetCalls {
        fn from(value: Leave2Call) -> Self {
            Self::Leave2(value)
        }
    }
    impl ::core::convert::From<RewardCall> for SubnetActorManagerFacetCalls {
        fn from(value: RewardCall) -> Self {
            Self::Reward(value)
        }
    }
    impl ::core::convert::From<SetMetadataCall> for SubnetActorManagerFacetCalls {
        fn from(value: SetMetadataCall) -> Self {
            Self::SetMetadata(value)
        }
    }
    impl ::core::convert::From<SetValidatorNetAddrCall> for SubnetActorManagerFacetCalls {
        fn from(value: SetValidatorNetAddrCall) -> Self {
            Self::SetValidatorNetAddr(value)
        }
    }
    impl ::core::convert::From<SetValidatorWorkerAddrCall> for SubnetActorManagerFacetCalls {
        fn from(value: SetValidatorWorkerAddrCall) -> Self {
            Self::SetValidatorWorkerAddr(value)
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
    impl ::core::convert::From<WithdrawCall> for SubnetActorManagerFacetCalls {
        fn from(value: WithdrawCall) -> Self {
            Self::Withdraw(value)
        }
    }
    ///Container type for all return fields from the `getValidator` function with signature `getValidator(address)` and selector `0x1904bb2e`
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
    pub struct GetValidatorReturn {
        pub validator: Validator,
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
    ///`Validator(uint256,uint256,bytes)`
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
    pub struct Validator {
        pub confirmed_collateral: ::ethers::core::types::U256,
        pub total_collateral: ::ethers::core::types::U256,
        pub data: ::ethers::core::types::Bytes,
    }
}
