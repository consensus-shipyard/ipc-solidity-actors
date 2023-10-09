pub use gateway_diamond::*;
/// This module was auto-generated with ethers-rs Abigen.
/// More information at: <https://github.com/gakonst/ethers-rs>
#[allow(
    clippy::enum_variant_names,
    clippy::too_many_arguments,
    clippy::upper_case_acronyms,
    clippy::type_complexity,
    dead_code,
<<<<<<< HEAD
    non_camel_case_types
=======
    non_camel_case_types,
>>>>>>> f7ef052 (add address check)
)]
pub mod gateway_diamond {
    #[allow(deprecated)]
    fn __abi() -> ::ethers::core::abi::Abi {
        ::ethers::core::abi::ethabi::Contract {
            constructor: ::core::option::Option::Some(::ethers::core::abi::ethabi::Constructor {
                inputs: ::std::vec![
                    ::ethers::core::abi::ethabi::Param {
                        name: ::std::borrow::ToOwned::to_owned("_diamondCut"),
                        kind: ::ethers::core::abi::ethabi::ParamType::Array(
<<<<<<< HEAD
                            ::std::boxed::Box::new(::ethers::core::abi::ethabi::ParamType::Tuple(
                                ::std::vec![
                                    ::ethers::core::abi::ethabi::ParamType::Address,
                                    ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                    ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(
                                                4usize
                                            ),
                                        ),
                                    ),
                                ],
                            ),),
                        ),
                        internal_type: ::core::option::Option::Some(
                            ::std::borrow::ToOwned::to_owned("struct IDiamond.FacetCut[]",),
=======
                            ::std::boxed::Box::new(
                                ::ethers::core::abi::ethabi::ParamType::Tuple(
                                    ::std::vec![
                                        ::ethers::core::abi::ethabi::ParamType::Address,
                                        ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                        ::ethers::core::abi::ethabi::ParamType::Array(
                                            ::std::boxed::Box::new(
                                                ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ),
                        internal_type: ::core::option::Option::Some(
                            ::std::borrow::ToOwned::to_owned(
                                "struct IDiamond.FacetCut[]",
                            ),
>>>>>>> f7ef052 (add address check)
                        ),
                    },
                    ::ethers::core::abi::ethabi::Param {
                        name: ::std::borrow::ToOwned::to_owned("params"),
<<<<<<< HEAD
                        kind: ::ethers::core::abi::ethabi::ParamType::Tuple(::std::vec![
                            ::ethers::core::abi::ethabi::ParamType::Tuple(::std::vec![
                                ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                ::ethers::core::abi::ethabi::ParamType::Array(
                                    ::std::boxed::Box::new(
                                        ::ethers::core::abi::ethabi::ParamType::Address,
                                    ),
                                ),
                            ],),
                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                            ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                            ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                        ],),
=======
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
                                ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                            ],
                        ),
>>>>>>> f7ef052 (add address check)
                        internal_type: ::core::option::Option::Some(
                            ::std::borrow::ToOwned::to_owned(
                                "struct GatewayDiamond.ConstructorParams",
                            ),
                        ),
                    },
                ],
            }),
            functions: ::std::collections::BTreeMap::new(),
            events: ::std::collections::BTreeMap::new(),
            errors: ::core::convert::From::from([
                (
<<<<<<< HEAD
                    ::std::borrow::ToOwned::to_owned("CannotAddFunctionToDiamondThatAlreadyExists"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned(
                            "CannotAddFunctionToDiamondThatAlreadyExists",
                        ),
                        inputs: ::std::vec![::ethers::core::abi::ethabi::Param {
                            name: ::std::borrow::ToOwned::to_owned("_selector"),
                            kind: ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize,),
                            internal_type: ::core::option::Option::Some(
                                ::std::borrow::ToOwned::to_owned("bytes4"),
                            ),
                        },],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("CannotAddSelectorsToZeroAddress"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("CannotAddSelectorsToZeroAddress",),
                        inputs: ::std::vec![::ethers::core::abi::ethabi::Param {
                            name: ::std::borrow::ToOwned::to_owned("_selectors"),
                            kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                ::std::boxed::Box::new(
                                    ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize),
                                ),
                            ),
                            internal_type: ::core::option::Option::Some(
                                ::std::borrow::ToOwned::to_owned("bytes4[]"),
                            ),
                        },],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("FunctionNotFound"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("FunctionNotFound"),
                        inputs: ::std::vec![::ethers::core::abi::ethabi::Param {
                            name: ::std::borrow::ToOwned::to_owned("_functionSelector"),
                            kind: ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize,),
                            internal_type: ::core::option::Option::Some(
                                ::std::borrow::ToOwned::to_owned("bytes4"),
                            ),
                        },],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("IncorrectFacetCutAction"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("IncorrectFacetCutAction",),
                        inputs: ::std::vec![::ethers::core::abi::ethabi::Param {
                            name: ::std::borrow::ToOwned::to_owned("_action"),
                            kind: ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                            internal_type: ::core::option::Option::Some(
                                ::std::borrow::ToOwned::to_owned("enum IDiamond.FacetCutAction",),
                            ),
                        },],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InitializationFunctionReverted"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("InitializationFunctionReverted",),
                        inputs: ::std::vec![
                            ::ethers::core::abi::ethabi::Param {
                                name: ::std::borrow::ToOwned::to_owned(
                                    "_initializationContractAddress",
                                ),
                                kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                internal_type: ::core::option::Option::Some(
                                    ::std::borrow::ToOwned::to_owned("address"),
                                ),
                            },
                            ::ethers::core::abi::ethabi::Param {
                                name: ::std::borrow::ToOwned::to_owned("_calldata"),
                                kind: ::ethers::core::abi::ethabi::ParamType::Bytes,
                                internal_type: ::core::option::Option::Some(
                                    ::std::borrow::ToOwned::to_owned("bytes"),
                                ),
                            },
                        ],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidCollateral"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("InvalidCollateral"),
                        inputs: ::std::vec![],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidMajorityPercentage"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("InvalidMajorityPercentage",),
                        inputs: ::std::vec![],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidSubmissionPeriod"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("InvalidSubmissionPeriod",),
                        inputs: ::std::vec![],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NoBytecodeAtAddress"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("NoBytecodeAtAddress",),
                        inputs: ::std::vec![
                            ::ethers::core::abi::ethabi::Param {
                                name: ::std::borrow::ToOwned::to_owned("_contractAddress"),
                                kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                internal_type: ::core::option::Option::Some(
                                    ::std::borrow::ToOwned::to_owned("address"),
                                ),
                            },
                            ::ethers::core::abi::ethabi::Param {
                                name: ::std::borrow::ToOwned::to_owned("_message"),
                                kind: ::ethers::core::abi::ethabi::ParamType::String,
                                internal_type: ::core::option::Option::Some(
                                    ::std::borrow::ToOwned::to_owned("string"),
                                ),
                            },
                        ],
                    },],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NoSelectorsProvidedForFacetForCut"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("NoSelectorsProvidedForFacetForCut",),
                        inputs: ::std::vec![::ethers::core::abi::ethabi::Param {
                            name: ::std::borrow::ToOwned::to_owned("_facetAddress"),
                            kind: ::ethers::core::abi::ethabi::ParamType::Address,
                            internal_type: ::core::option::Option::Some(
                                ::std::borrow::ToOwned::to_owned("address"),
                            ),
                        },],
                    },],
=======
                    ::std::borrow::ToOwned::to_owned(
                        "CannotAddFunctionToDiamondThatAlreadyExists",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotAddFunctionToDiamondThatAlreadyExists",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_selector"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::FixedBytes(
                                        4usize,
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes4"),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("CannotAddSelectorsToZeroAddress"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotAddSelectorsToZeroAddress",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_selectors"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize),
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes4[]"),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("FunctionNotFound"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("FunctionNotFound"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_functionSelector"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::FixedBytes(
                                        4usize,
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes4"),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("IncorrectFacetCutAction"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "IncorrectFacetCutAction",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_action"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned(
                                            "enum IDiamond.FacetCutAction",
                                        ),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InitializationFunctionReverted"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "InitializationFunctionReverted",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned(
                                        "_initializationContractAddress",
                                    ),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_calldata"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Bytes,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes"),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidCollateral"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("InvalidCollateral"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidMajorityPercentage"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "InvalidMajorityPercentage",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("InvalidSubmissionPeriod"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "InvalidSubmissionPeriod",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NoBytecodeAtAddress"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NoBytecodeAtAddress",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_contractAddress"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_message"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::String,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("string"),
                                    ),
                                },
                            ],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned(
                        "NoSelectorsProvidedForFacetForCut",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "NoSelectorsProvidedForFacetForCut",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("_facetAddress"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                        },
                    ],
>>>>>>> f7ef052 (add address check)
                ),
            ]),
            receive: true,
            fallback: true,
        }
    }
    ///The parsed JSON ABI of the contract.
<<<<<<< HEAD
    pub static GATEWAYDIAMOND_ABI: ::ethers::contract::Lazy<::ethers::core::abi::Abi> =
        ::ethers::contract::Lazy::new(__abi);
    #[rustfmt::skip]
    const __BYTECODE: &[u8] = b"`\x80`@R4a\x07\xBCWa\x0Bn\x808\x03\x80a\0\x19\x81a\x08\xF7V[\x92\x839\x81\x01`@\x82\x82\x03\x12a\x07\xBCW\x81Q`\x01`\x01`@\x1B\x03\x81\x11a\x07\xBCW\x82\x01\x81`\x1F\x82\x01\x12\x15a\x07\xBCW\x80Q\x92a\0Ya\0T\x85a\t\x1CV[a\x08\xF7V[\x91` \x83\x86\x81R\x01` \x81\x96`\x05\x1B\x83\x01\x01\x91\x85\x83\x11a\x07\xBCW` \x81\x01\x91[\x83\x83\x10a\x07\xD9WPPPP` \x81\x01Q\x90`\x01`\x01`@\x1B\x03\x82\x11a\x07\xBCW\x01\x92`\xC0\x84\x84\x03\x12a\x07\xBCW`@Q\x92`\xC0\x84\x01`\x01`\x01`@\x1B\x03\x81\x11\x85\x82\x10\x17a\x04\x05W`@R\x84Q`\x01`\x01`@\x1B\x03\x81\x11a\x07\xBCW\x85\x01\x90`@\x82\x82\x03\x12a\x07\xBCWa\0\xE6a\x08\xD8V[\x91a\0\xF0\x81a\tGV[\x83R` \x81\x01Q\x90`\x01`\x01`@\x1B\x03\x82\x11a\x07\xBCW\x01\x90\x80`\x1F\x83\x01\x12\x15a\x07\xBCW\x81Qa\x01!a\0T\x82a\t\x1CV[\x92` \x80\x85\x84\x81R\x01\x92`\x05\x1B\x82\x01\x01\x92\x83\x11a\x07\xBCW` \x01\x90[\x82\x82\x10a\x07\xC1WPPP` \x82\x01R\x83Ra\x01Z` \x85\x01a\tGV[` \x84\x01Ra\x01k`@\x85\x01a\tGV[\x93`@\x84\x01\x94\x85R`\xA0``\x82\x01Q\x91\x82``\x87\x01R`\x80\x81\x01Q`\x80\x87\x01R\x01Q`\xFF\x81\x16\x81\x03a\x07\xBCW`\xA0\x85\x01R\x15a\x07\xAAW` \x83\x01Q`\x01`\x01`@\x1B\x03\x16\x15a\x07\x98W`\xFF`\xA0\x84\x01Q\x16`3\x81\x10\x90\x81\x15a\x07\x8DW[Pa\x07{W\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5\x80T`\x01`\x01`\xA0\x1B\x03\x19\x163\x17\x90U`@Q` \x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17a\x04\x05W`@R`\0\x81R\x82Q`\0[\x81\x81\x10a\x04pWPP`@Q\x92``\x84\x01\x90``\x85RQ\x80\x91R`\x80\x84\x01\x90`\x80\x81`\x05\x1B\x86\x01\x01\x93\x91`\0\x90[\x82\x82\x10a\x04\x1BW\x88\x88\x7F\x8F\xAAp\x87\x86q\xCC\xD2\x12\xD2\x07q\xB7\x95\xC5\n\xF8\xFD?\xF6\xCF'\xF4\xBD\xE5~]M\xE0\xAE\xB6s\x89\x80a\x02\x96\x8B\x8B`\0` \x85\x01R\x83\x82\x03`@\x85\x01Ra\t\xBAV[\x03\x90\xA1\x80Q\x80Q`\x15\x80T`\x01`\x01`@\x1B\x03\x19\x90\x81\x16`\x01`\x01`@\x1B\x03\x93\x84\x16\x17\x90\x91U` \x90\x92\x01Q\x80Q\x90\x94\x92\x93\x92\x91\x81\x11a\x04\x05Wh\x01\0\0\0\0\0\0\0\0\x81\x11a\x04\x05W`\x01\x94`\x16T\x82`\x16U\x80\x83\x10a\x03\xC0W[P` \x01`\x16`\0R` `\0 `\0[\x83\x81\x10a\x03\xA6WPPPP``\x82\x01Q`\x17U` \x82\x01Q`\x1AT\x90h\x01\0\0\0\0\0\0\0\0\x86`\x80\x1B\x03\x90`@\x1B\x16\x90h\x01\0\0\0\0\0\0\0\0\x86`\x80\x1B\x03\x19\x16\x17`\x1AUQ\x90`\xFF`\xA0`\x19T\x92`\x80\x81\x01Q`\x18U\x01Q\x16\x91\x84`\x88\x1B\x85`\xC8\x1B\x03\x90`\x88\x1B\x16\x90x\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xFF\x19\x16\x17\x17`\x19U`\x0FT\x16\x17`\x0FU`@Qa\x013\x90\x81a\t\xFB\x829\xF3[\x87\x90` \x82\x80`\xA0\x1B\x03\x85Q\x16\x94\x01\x93\x81\x84\x01U\x01a\x03\x03V[`\x16`\0R\x7F\xD83\x14}}\xC3U\xBAE\x9F\xC7\x88\xF6i\xE5\x8C\xFA\xF9\xDC%\xDD\xCD\x07\x02\xE8}i\xC7\xB5\x12B\x89\x90\x81\x01\x90\x83\x01[\x81\x81\x10a\x03\xFAWPa\x02\xF2V[`\0\x81U\x87\x01a\x03\xEDV[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[\x90\x91\x92\x94` \x80a\x04b`\x01\x93`\x7F\x19\x8B\x82\x03\x01\x86R```@\x8BQ\x87\x80`\xA0\x1B\x03\x81Q\x16\x84Ra\x04R\x86\x82\x01Q\x87\x86\x01\x90a\toV[\x01Q\x91\x81`@\x82\x01R\x01\x90a\t|V[\x97\x01\x92\x01\x92\x01\x90\x92\x91a\x02QV[`@a\x04|\x82\x87a\t[V[Q\x01Q`\x01`\x01`\xA0\x1B\x03a\x04\x91\x83\x88a\t[V[QQ\x16\x90\x80Q\x15a\x07bW` a\x04\xA8\x84\x89a\t[V[Q\x01Q`\x03\x81\x10\x15a\x07LW\x80a\x07,WP\x81\x15a\x07\x07Wa\xFF\xFF`\0\x80Q` a\x0B.\x839\x81Q\x91RT\x16\x91`@Q\x80``\x81\x01\x10`\x01\x80`@\x1B\x03``\x83\x01\x11\x17a\x04\x05W``\x81\x01`@R`!\x81R\x7FdiamondCut: Add facet has no cod` \x82\x01R`e`\xF8\x1B`@\x82\x01R\x81;\x15a\x06\xD9WP\x81Q\x91`\0\x93[\x83\x85\x10a\x05MWPPPPP`\x01\x01a\x02#V[a\x05W\x85\x83a\t[V[Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R`\0\x80Q` a\x0BN\x839\x81Q\x91R` R`@\x90 T`\x01`\x01`\xA0\x1B\x03\x16a\x06\xB6Wa\x05\x94a\x08\xD8V[\x84\x81Ra\xFF\xFF\x83\x16` \x80\x83\x01\x91\x82R`\x01`\x01`\xE0\x1B\x03\x19\x84\x16`\0\x90\x81R`\0\x80Q` a\x0BN\x839\x81Q\x91R\x90\x91R`@\x90 \x91Q\x82T\x91Q`\x01`\x01`\xB0\x1B\x03\x19\x90\x92\x16`\x01`\x01`\xA0\x1B\x03\x91\x90\x91\x16\x17`\xA0\x91\x90\x91\x1Ba\xFF\xFF`\xA0\x1B\x16\x17\x90U`\0\x80Q` a\x0B.\x839\x81Q\x91RTh\x01\0\0\0\0\0\0\0\0\x81\x10\x15a\x04\x05W`\x01\x81\x01\x80`\0\x80Q` a\x0B.\x839\x81Q\x91RU\x81\x10\x15a\x06\xA0W`\0\x80Q` a\x0B.\x839\x81Q\x91R`\0R` `\0 \x81`\x03\x1C\x01\x91c\xFF\xFF\xFF\xFF\x83T\x91`\xE0\x80\x94`\x05\x1B\x16\x93\x1C\x83\x1B\x92\x1B\x19\x16\x17\x90Ua\xFF\xFF\x80\x82\x16\x14a\x06\x8AW`\x01a\xFF\xFF\x81\x92\x16\x01\x94\x01\x93a\x059V[cNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[`@Qc\xEB\xBF]\x07`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x90\x91\x16`\x04\x82\x01R`$\x90\xFD[\x90a\x07\x03`@Q\x92\x83\x92c\x91\x984\xB9`\xE0\x1B\x84R`\x04\x84\x01R`@`$\x84\x01R`D\x83\x01\x90a\t\xBAV[\x03\x90\xFD[`@Qc\x02\xB8\xDA\x07`\xE2\x1B\x81R` `\x04\x82\x01R\x90\x81\x90a\x07\x03\x90`$\x83\x01\x90a\t|V[`@Qc?\xF4\xD2\x0F`\xE1\x1B\x81R`$\x91a\x07J\x90`\x04\x83\x01\x90a\toV[\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[`@Qc\xE7g\xF9\x1F`\xE0\x1B\x81R`\x04\x81\x01\x83\x90R`$\x90\xFD[`@Qcu\xC3\xB4'`\xE0\x1B\x81R`\x04\x90\xFD[`d\x91P\x118a\x01\xC8V[`@Qc1/\x8E\x05`\xE0\x1B\x81R`\x04\x90\xFD[`@Qch\xF7\xA6u`\xE1\x1B\x81R`\x04\x90\xFD[`\0\x80\xFD[` \x80\x91a\x07\xCE\x84a\t3V[\x81R\x01\x91\x01\x90a\x01=V[\x82Q`\x01`\x01`@\x1B\x03\x81\x11a\x07\xBCW\x82\x01``\x90\x81`\x1F\x19\x82\x8B\x03\x01\x12a\x07\xBCW`@Q\x91\x80\x83\x01`\x01`\x01`@\x1B\x03\x81\x11\x84\x82\x10\x17a\x08\xC3W`@Ra\x08#` \x83\x01a\t3V[\x83R`@\x82\x01Q`\x03\x81\x10\x15a\x07\xBCW` \x84\x01R\x81\x01Q\x90`\x01`\x01`@\x1B\x03\x82\x11a\x07\xBCW\x01\x88`?\x82\x01\x12\x15a\x07\xBCW` \x81\x01Qa\x08ga\0T\x82a\t\x1CV[\x91`@` \x84\x84\x81R\x01\x92`\x05\x1B\x82\x01\x01\x90\x8B\x82\x11a\x07\xBCW`@\x01\x91[\x81\x83\x10a\x08\xA2WPPP`@\x82\x01R\x81R` \x92\x83\x01\x92\x01a\0yV[\x82Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x03a\x07\xBCW\x81R` \x92\x83\x01\x92\x01a\x08\x85V[`$`\0cNH{q`\xE0\x1B\x81R`A`\x04R\xFD[`@\x80Q\x91\x90\x82\x01`\x01`\x01`@\x1B\x03\x81\x11\x83\x82\x10\x17a\x04\x05W`@RV[`@Q\x91\x90`\x1F\x01`\x1F\x19\x16\x82\x01`\x01`\x01`@\x1B\x03\x81\x11\x83\x82\x10\x17a\x04\x05W`@RV[`\x01`\x01`@\x1B\x03\x81\x11a\x04\x05W`\x05\x1B` \x01\x90V[Q\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\x07\xBCWV[Q\x90`\x01`\x01`@\x1B\x03\x82\x16\x82\x03a\x07\xBCWV[\x80Q\x82\x10\x15a\x06\xA0W` \x91`\x05\x1B\x01\x01\x90V[\x90`\x03\x82\x10\x15a\x07LWRV[\x90\x81Q\x80\x82R` \x80\x80\x93\x01\x93\x01\x91`\0[\x82\x81\x10a\t\x9CWPPPP\x90V[\x83Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x93\x81\x01\x93\x92\x81\x01\x92`\x01\x01a\t\x8EV[\x91\x90\x82Q\x92\x83\x82R`\0[\x84\x81\x10a\t\xE6WPP\x82`\0` \x80\x94\x95\x84\x01\x01R`\x1F\x80\x19\x91\x01\x16\x01\x01\x90V[` \x81\x83\x01\x81\x01Q\x84\x83\x01\x82\x01R\x01a\t\xC5V\xFE`\x80`@R6\x15`\x87W`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`oWP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[=\x90\xFD[`$\x90`@Q\x90c\n\x82\xDDs`\xE3\x1B\x82R`\x04\x82\x01R\xFD[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`\xE9WP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[c\n\x82\xDDs`\xE3\x1B`\x80R`\x84R`$`\x80\xFD\xFE\xA2dipfsX\"\x12 e|\x95\xBC~%\xB5\xD6_\x12\x17\x12\x07\x10\xD9N)\xBE!+W_nY{=V\x9C.`\x1D\xB2dsolcC\0\x08\x13\x003\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD3\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2";
    /// The bytecode of the contract.
    pub static GATEWAYDIAMOND_BYTECODE: ::ethers::core::types::Bytes =
        ::ethers::core::types::Bytes::from_static(__BYTECODE);
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@R6\x15`\x87W`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`oWP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[=\x90\xFD[`$\x90`@Q\x90c\n\x82\xDDs`\xE3\x1B\x82R`\x04\x82\x01R\xFD[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`\xE9WP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[c\n\x82\xDDs`\xE3\x1B`\x80R`\x84R`$`\x80\xFD\xFE\xA2dipfsX\"\x12 e|\x95\xBC~%\xB5\xD6_\x12\x17\x12\x07\x10\xD9N)\xBE!+W_nY{=V\x9C.`\x1D\xB2dsolcC\0\x08\x13\x003";
    /// The deployed bytecode of the contract.
    pub static GATEWAYDIAMOND_DEPLOYED_BYTECODE: ::ethers::core::types::Bytes =
        ::ethers::core::types::Bytes::from_static(__DEPLOYED_BYTECODE);
=======
    pub static GATEWAYDIAMOND_ABI: ::ethers::contract::Lazy<::ethers::core::abi::Abi> = ::ethers::contract::Lazy::new(
        __abi,
    );
    #[rustfmt::skip]
    const __BYTECODE: &[u8] = b"`\x80`@R4\x80\x15a\0\x10W`\0\x80\xFD[P`@Qa\r\xEB8\x03\x80a\r\xEB\x839\x81\x01`@\x81\x90Ra\0/\x91a\x08\xB6V[\x80``\x01Q`\0\x03a\0TW`@Qch\xF7\xA6u`\xE1\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x80` \x01Q`\x01`\x01`@\x1B\x03\x16`\0\x03a\0\x82W`@Qc1/\x8E\x05`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[`3\x81`\xA0\x01Q`\xFF\x16\x10\x80a\0\x9FWP`d\x81`\xA0\x01Q`\xFF\x16\x11[\x15a\0\xBDW`@Qcu\xC3\xB4'`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5\x80T`\x01`\x01`\xA0\x1B\x03\x19\x163\x17\x90U`@\x80Q`\0\x80\x82R` \x82\x01\x90\x92Ra\x01\t\x91\x84\x91a\x01\xDBV[\x80Q\x80Q`\x15\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x81U` \x80\x83\x01Q\x80Qa\x01B\x92`\x16\x92\x01\x90a\x05\xF0V[PPP``\x81\x01Q`\x17U` \x81\x01Q`\x1A\x80T`\x01`\x01`@\x1B\x03\x92\x83\x16h\x01\0\0\0\0\0\0\0\0\x02`\x01`@\x1B`\x01`\x80\x1B\x03\x19\x90\x91\x16\x17\x90U`@\x82\x01Q`\x19\x80T`\x80\x85\x01Q`\x18U`\xA0\x90\x94\x01Q`\xFF\x16`\xFF\x19\x92\x90\x93\x16`\x01`\x88\x1B\x02\x91\x90\x91\x16`\xFF`\x01`\x88\x1B\x03`\x01`\xC8\x1B\x03\x19\x90\x93\x16\x92\x90\x92\x17\x17\x90UP`\x0F\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01\x17\x90Ua\x0C\xB5V[\x82Q`\0[\x81\x81\x10\x15a\x02\xE2W`\0\x85\x82\x81Q\x81\x10a\x01\xFCWa\x01\xFCa\nRV[` \x02` \x01\x01Q`@\x01Q\x90P`\0\x86\x83\x81Q\x81\x10a\x02\x1EWa\x02\x1Ea\nRV[` \x02` \x01\x01Q`\0\x01Q\x90P\x81Q`\0\x03a\x02^W`@Qc\xE7g\xF9\x1F`\xE0\x1B\x81R`\x01`\x01`\xA0\x1B\x03\x82\x16`\x04\x82\x01R`$\x01[`@Q\x80\x91\x03\x90\xFD[`\0\x87\x84\x81Q\x81\x10a\x02rWa\x02ra\nRV[` \x02` \x01\x01Q` \x01Q\x90P`\0`\x02\x81\x11\x15a\x02\x93Wa\x02\x93a\nhV[\x81`\x02\x81\x11\x15a\x02\xA5Wa\x02\xA5a\nhV[\x03a\x02\xB9Wa\x02\xB4\x82\x84a\x03.V[a\x02\xD4V[\x80`@Qc?\xF4\xD2\x0F`\xE1\x1B\x81R`\x04\x01a\x02U\x91\x90a\n\xA0V[\x83`\x01\x01\x93PPPPa\x01\xE0V[P\x7F\x8F\xAAp\x87\x86q\xCC\xD2\x12\xD2\x07q\xB7\x95\xC5\n\xF8\xFD?\xF6\xCF'\xF4\xBD\xE5~]M\xE0\xAE\xB6s\x84\x84\x84`@Qa\x03\x16\x93\x92\x91\x90a\x0B\x04V[`@Q\x80\x91\x03\x90\xA1a\x03(\x83\x83a\x04\xFDV[PPPPV[`\x01`\x01`\xA0\x1B\x03\x82\x16a\x03WW\x80`@Qc\x02\xB8\xDA\x07`\xE2\x1B\x81R`\x04\x01a\x02U\x91\x90a\x0B\xF0V[\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD3T`@\x80Q``\x81\x01\x90\x91R`!\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2\x92\x91a\x03\xC0\x91\x86\x91\x90a\r\xCA` \x83\x019a\x05\xC3V[\x82Q`\0[\x81\x81\x10\x15a\x04\xF5W`\0\x85\x82\x81Q\x81\x10a\x03\xE1Wa\x03\xE1a\nRV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R\x91\x87\x90R`@\x90\x91 T\x90\x91P`\x01`\x01`\xA0\x1B\x03\x16\x80\x15a\x04>W`@Qc\xEB\xBF]\x07`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01a\x02UV[`@\x80Q\x80\x82\x01\x82R`\x01`\x01`\xA0\x1B\x03\x80\x8B\x16\x82Ra\xFF\xFF\x80\x89\x16` \x80\x85\x01\x91\x82R`\x01`\x01`\xE0\x1B\x03\x19\x88\x16`\0\x90\x81R\x8C\x82R\x95\x86 \x94Q\x85T\x92Q\x90\x93\x16`\x01`\xA0\x1B\x02`\x01`\x01`\xB0\x1B\x03\x19\x90\x92\x16\x92\x90\x93\x16\x91\x90\x91\x17\x17\x90\x91U`\x01\x80\x89\x01\x80T\x91\x82\x01\x81U\x83R\x91 `\x08\x82\x04\x01\x80T`\xE0\x85\x90\x1C`\x04`\x07\x90\x94\x16\x93\x90\x93\x02a\x01\0\n\x92\x83\x02c\xFF\xFF\xFF\xFF\x90\x93\x02\x19\x16\x91\x90\x91\x17\x90Ua\x04\xE6\x85a\x0C>V[\x94P\x82`\x01\x01\x92PPPa\x03\xC5V[PPPPPPV[`\x01`\x01`\xA0\x1B\x03\x82\x16a\x05\x0FWPPV[a\x051\x82`@Q\x80``\x01`@R\x80`%\x81R` \x01a\r\xA5`%\x919a\x05\xC3V[`\0\x80\x83`\x01`\x01`\xA0\x1B\x03\x16\x83`@Qa\x05L\x91\x90a\x0CmV[`\0`@Q\x80\x83\x03\x81\x85Z\xF4\x91PP=\x80`\0\x81\x14a\x05\x87W`@Q\x91P`\x1F\x19`?=\x01\x16\x82\x01`@R=\x82R=`\0` \x84\x01>a\x05\x8CV[``\x91P[P\x91P\x91P\x81a\x03(W\x80Q\x15a\x05\xA6W\x80Q\x80\x82` \x01\xFD[\x83\x83`@Qc\x19!\x05\xD7`\xE0\x1B\x81R`\x04\x01a\x02U\x92\x91\x90a\x0C\x89V[\x81;`\0\x81\x90\x03a\x05\xEBW\x82\x82`@Qc\x91\x984\xB9`\xE0\x1B\x81R`\x04\x01a\x02U\x92\x91\x90a\x0C\x89V[PPPV[\x82\x80T\x82\x82U\x90`\0R` `\0 \x90\x81\x01\x92\x82\x15a\x06EW\x91` \x02\x82\x01[\x82\x81\x11\x15a\x06EW\x82Q\x82T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x17\x82U` \x90\x92\x01\x91`\x01\x90\x91\x01\x90a\x06\x10V[Pa\x06Q\x92\x91Pa\x06UV[P\x90V[[\x80\x82\x11\x15a\x06QW`\0\x81U`\x01\x01a\x06VV[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[`@Q`\xC0\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15a\x06\xA2Wa\x06\xA2a\x06jV[`@R\x90V[`@\x80Q\x90\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15a\x06\xA2Wa\x06\xA2a\x06jV[`@Q``\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15a\x06\xA2Wa\x06\xA2a\x06jV[`@Q`\x1F\x82\x01`\x1F\x19\x16\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15a\x07\x14Wa\x07\x14a\x06jV[`@R\x91\x90PV[`\0`\x01`\x01`@\x1B\x03\x82\x11\x15a\x075Wa\x075a\x06jV[P`\x05\x1B` \x01\x90V[\x80Q`\x01`\x01`\xA0\x1B\x03\x81\x16\x81\x14a\x07VW`\0\x80\xFD[\x91\x90PV[\x80Q`\x01`\x01`@\x1B\x03\x81\x16\x81\x14a\x07VW`\0\x80\xFD[\x80Q`\xFF\x81\x16\x81\x14a\x07VW`\0\x80\xFD[`\0`\xC0\x82\x84\x03\x12\x15a\x07\x95W`\0\x80\xFD[a\x07\x9Da\x06\x80V[\x82Q\x90\x91P`\x01`\x01`@\x1B\x03\x80\x82\x11\x15a\x07\xB7W`\0\x80\xFD[\x90\x83\x01\x90`@\x82\x86\x03\x12\x15a\x07\xCBW`\0\x80\xFD[a\x07\xD3a\x06\xA8V[a\x07\xDC\x83a\x07[V[\x81R` \x80\x84\x01Q\x83\x81\x11\x15a\x07\xF1W`\0\x80\xFD[\x80\x85\x01\x94PP\x86`\x1F\x85\x01\x12a\x08\x06W`\0\x80\xFD[\x83Q\x92Pa\x08\x1Ba\x08\x16\x84a\x07\x1CV[a\x06\xECV[\x83\x81R`\x05\x93\x90\x93\x1B\x84\x01\x81\x01\x92\x81\x81\x01\x90\x88\x85\x11\x15a\x08:W`\0\x80\xFD[\x94\x82\x01\x94[\x84\x86\x10\x15a\x08_Wa\x08P\x86a\x07?V[\x82R\x94\x82\x01\x94\x90\x82\x01\x90a\x08?V[\x83\x83\x01RP\x81\x85Ra\x08r\x86\x82\x01a\x07[V[\x81\x86\x01RPPPPa\x08\x86`@\x83\x01a\x07[V[`@\x82\x01R``\x82\x01Q``\x82\x01R`\x80\x82\x01Q`\x80\x82\x01Ra\x08\xAB`\xA0\x83\x01a\x07rV[`\xA0\x82\x01R\x92\x91PPV[`\0\x80`@\x83\x85\x03\x12\x15a\x08\xC9W`\0\x80\xFD[\x82Q`\x01`\x01`@\x1B\x03\x80\x82\x11\x15a\x08\xE0W`\0\x80\xFD[\x81\x85\x01\x91P\x85`\x1F\x83\x01\x12a\x08\xF4W`\0\x80\xFD[\x81Q` a\t\x04a\x08\x16\x83a\x07\x1CV[\x82\x81R`\x05\x92\x90\x92\x1B\x84\x01\x81\x01\x91\x81\x81\x01\x90\x89\x84\x11\x15a\t#W`\0\x80\xFD[\x82\x86\x01[\x84\x81\x10\x15a\n!W\x80Q\x86\x81\x11\x15a\t>W`\0\x80\xFD[\x87\x01``\x81\x8D\x03`\x1F\x19\x01\x12\x15a\tTW`\0\x80\xFD[a\t\\a\x06\xCAV[a\tg\x86\x83\x01a\x07?V[\x81R`@\x82\x01Q`\x03\x81\x10a\t{W`\0\x80\xFD[\x81\x87\x01R``\x82\x01Q\x88\x81\x11\x15a\t\x91W`\0\x80\xFD[\x80\x83\x01\x92PP\x8C`?\x83\x01\x12a\t\xA6W`\0\x80\xFD[\x85\x82\x01Qa\t\xB6a\x08\x16\x82a\x07\x1CV[\x81\x81R`\x05\x91\x90\x91\x1B\x83\x01`@\x01\x90\x87\x81\x01\x90\x8F\x83\x11\x15a\t\xD6W`\0\x80\xFD[`@\x85\x01\x94P[\x82\x85\x10\x15a\n\x0CW\x84Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x14a\t\xFDW`\0\x80\xFD[\x82R\x93\x88\x01\x93\x90\x88\x01\x90a\t\xDDV[`@\x84\x01RPP\x84RP\x91\x83\x01\x91\x83\x01a\t'V[P\x91\x88\x01Q\x91\x96P\x90\x93PPP\x80\x82\x11\x15a\n;W`\0\x80\xFD[Pa\nH\x85\x82\x86\x01a\x07\x83V[\x91PP\x92P\x92\x90PV[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[`\x03\x81\x10a\n\x9CWcNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[\x90RV[` \x81\x01a\n\xAE\x82\x84a\n~V[\x92\x91PPV[`\0[\x83\x81\x10\x15a\n\xCFW\x81\x81\x01Q\x83\x82\x01R` \x01a\n\xB7V[PP`\0\x91\x01RV[`\0\x81Q\x80\x84Ra\n\xF0\x81` \x86\x01` \x86\x01a\n\xB4V[`\x1F\x01`\x1F\x19\x16\x92\x90\x92\x01` \x01\x92\x91PPV[`\0``\x80\x83\x01\x81\x84R\x80\x87Q\x80\x83R`\x80\x92P\x82\x86\x01\x91P\x82\x81`\x05\x1B\x87\x01\x01` \x80\x8B\x01`\0\x80[\x85\x81\x10\x15a\x0B\xBFW\x8A\x85\x03`\x7F\x19\x01\x87R\x82Q\x80Q`\x01`\x01`\xA0\x1B\x03\x16\x86R\x84\x81\x01Q\x8A\x87\x01\x90a\x0Bb\x87\x89\x01\x82a\n~V[P`@\x91\x82\x01Q\x91\x87\x01\x8B\x90R\x81Q\x90\x81\x90R\x90\x85\x01\x90\x83\x90\x8A\x88\x01\x90[\x80\x83\x10\x15a\x0B\xAAW\x83Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x82R\x92\x87\x01\x92`\x01\x92\x90\x92\x01\x91\x90\x87\x01\x90a\x0B\x80V[P\x98\x86\x01\x98\x96PPP\x91\x83\x01\x91`\x01\x01a\x0B.V[PPP`\x01`\x01`\xA0\x1B\x03\x8A\x16\x90\x88\x01R\x86\x81\x03`@\x88\x01Ra\x0B\xE2\x81\x89a\n\xD8V[\x9A\x99PPPPPPPPPPV[` \x80\x82R\x82Q\x82\x82\x01\x81\x90R`\0\x91\x90\x84\x82\x01\x90`@\x85\x01\x90\x84[\x81\x81\x10\x15a\x0C2W\x83Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x83R\x92\x84\x01\x92\x91\x84\x01\x91`\x01\x01a\x0C\x0CV[P\x90\x96\x95PPPPPPV[`\0a\xFF\xFF\x80\x83\x16\x81\x81\x03a\x0CcWcNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[`\x01\x01\x93\x92PPPV[`\0\x82Qa\x0C\x7F\x81\x84` \x87\x01a\n\xB4V[\x91\x90\x91\x01\x92\x91PPV[`\x01`\x01`\xA0\x1B\x03\x83\x16\x81R`@` \x82\x01\x81\x90R`\0\x90a\x0C\xAD\x90\x83\x01\x84a\n\xD8V[\x94\x93PPPPV[`\xE2\x80a\x0C\xC3`\09`\0\xF3\xFE`\x80`@R6`\x10W`\x0E`\x13V[\0[`\x0E[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` \x81\x90R`@\x90\x91 T\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80`\x89W`@Qc\n\x82\xDDs`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19`\x005\x16`\x04\x82\x01R`$\x01`@Q\x80\x91\x03\x90\xFD[6`\0\x807`\0\x806`\0\x84Z\xF4=`\0\x80>\x80\x80\x15`\xA7W=`\0\xF3[=`\0\xFD\xFE\xA2dipfsX\"\x12 \x11\x88A\x96\x02r\xEF U\x12\xCB\x82\xF9hj\x83\x19w\xA8\xA6\xA2\xFBj\x15\xA2{7\x06}2\x94\0dsolcC\0\x08\x13\x003diamondCut: _init address has no codediamondCut: Add facet has no code";
    /// The bytecode of the contract.
    pub static GATEWAYDIAMOND_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __BYTECODE,
    );
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@R6`\x10W`\x0E`\x13V[\0[`\x0E[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` \x81\x90R`@\x90\x91 T\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80`\x89W`@Qc\n\x82\xDDs`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19`\x005\x16`\x04\x82\x01R`$\x01`@Q\x80\x91\x03\x90\xFD[6`\0\x807`\0\x806`\0\x84Z\xF4=`\0\x80>\x80\x80\x15`\xA7W=`\0\xF3[=`\0\xFD\xFE\xA2dipfsX\"\x12 \x11\x88A\x96\x02r\xEF U\x12\xCB\x82\xF9hj\x83\x19w\xA8\xA6\xA2\xFBj\x15\xA2{7\x06}2\x94\0dsolcC\0\x08\x13\x003";
    /// The deployed bytecode of the contract.
    pub static GATEWAYDIAMOND_DEPLOYED_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __DEPLOYED_BYTECODE,
    );
>>>>>>> f7ef052 (add address check)
    pub struct GatewayDiamond<M>(::ethers::contract::Contract<M>);
    impl<M> ::core::clone::Clone for GatewayDiamond<M> {
        fn clone(&self) -> Self {
            Self(::core::clone::Clone::clone(&self.0))
        }
    }
    impl<M> ::core::ops::Deref for GatewayDiamond<M> {
        type Target = ::ethers::contract::Contract<M>;
        fn deref(&self) -> &Self::Target {
            &self.0
        }
    }
    impl<M> ::core::ops::DerefMut for GatewayDiamond<M> {
        fn deref_mut(&mut self) -> &mut Self::Target {
            &mut self.0
        }
    }
    impl<M> ::core::fmt::Debug for GatewayDiamond<M> {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            f.debug_tuple(::core::stringify!(GatewayDiamond))
                .field(&self.address())
                .finish()
        }
    }
    impl<M: ::ethers::providers::Middleware> GatewayDiamond<M> {
        /// Creates a new contract instance with the specified `ethers` client at
        /// `address`. The contract derefs to a `ethers::Contract` object.
        pub fn new<T: Into<::ethers::core::types::Address>>(
            address: T,
            client: ::std::sync::Arc<M>,
        ) -> Self {
<<<<<<< HEAD
            Self(::ethers::contract::Contract::new(
                address.into(),
                GATEWAYDIAMOND_ABI.clone(),
                client,
            ))
=======
            Self(
                ::ethers::contract::Contract::new(
                    address.into(),
                    GATEWAYDIAMOND_ABI.clone(),
                    client,
                ),
            )
>>>>>>> f7ef052 (add address check)
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
                GATEWAYDIAMOND_ABI.clone(),
                GATEWAYDIAMOND_BYTECODE.clone().into(),
                client,
            );
            let deployer = factory.deploy(constructor_args)?;
            let deployer = ::ethers::contract::ContractDeployer::new(deployer);
            Ok(deployer)
        }
    }
    impl<M: ::ethers::providers::Middleware> From<::ethers::contract::Contract<M>>
<<<<<<< HEAD
        for GatewayDiamond<M>
    {
=======
    for GatewayDiamond<M> {
>>>>>>> f7ef052 (add address check)
        fn from(contract: ::ethers::contract::Contract<M>) -> Self {
            Self::new(contract.address(), contract.client())
        }
    }
    ///Custom Error type `CannotAddFunctionToDiamondThatAlreadyExists` with signature `CannotAddFunctionToDiamondThatAlreadyExists(bytes4)` and selector `0xebbf5d07`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(
        name = "CannotAddFunctionToDiamondThatAlreadyExists",
        abi = "CannotAddFunctionToDiamondThatAlreadyExists(bytes4)"
    )]
    pub struct CannotAddFunctionToDiamondThatAlreadyExists {
        pub selector: [u8; 4],
    }
    ///Custom Error type `CannotAddSelectorsToZeroAddress` with signature `CannotAddSelectorsToZeroAddress(bytes4[])` and selector `0x0ae3681c`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(
        name = "CannotAddSelectorsToZeroAddress",
        abi = "CannotAddSelectorsToZeroAddress(bytes4[])"
    )]
    pub struct CannotAddSelectorsToZeroAddress {
        pub selectors: ::std::vec::Vec<[u8; 4]>,
    }
    ///Custom Error type `FunctionNotFound` with signature `FunctionNotFound(bytes4)` and selector `0x5416eb98`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(name = "FunctionNotFound", abi = "FunctionNotFound(bytes4)")]
    pub struct FunctionNotFound {
        pub function_selector: [u8; 4],
    }
    ///Custom Error type `IncorrectFacetCutAction` with signature `IncorrectFacetCutAction(uint8)` and selector `0x7fe9a41e`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
    )]
    #[etherror(
        name = "IncorrectFacetCutAction",
        abi = "IncorrectFacetCutAction(uint8)"
    )]
=======
        Hash
    )]
    #[etherror(name = "IncorrectFacetCutAction", abi = "IncorrectFacetCutAction(uint8)")]
>>>>>>> f7ef052 (add address check)
    pub struct IncorrectFacetCutAction {
        pub action: u8,
    }
    ///Custom Error type `InitializationFunctionReverted` with signature `InitializationFunctionReverted(address,bytes)` and selector `0x192105d7`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(
        name = "InitializationFunctionReverted",
        abi = "InitializationFunctionReverted(address,bytes)"
    )]
    pub struct InitializationFunctionReverted {
        pub initialization_contract_address: ::ethers::core::types::Address,
        pub calldata: ::ethers::core::types::Bytes,
    }
    ///Custom Error type `InvalidCollateral` with signature `InvalidCollateral()` and selector `0xd1ef4cea`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(name = "InvalidCollateral", abi = "InvalidCollateral()")]
    pub struct InvalidCollateral;
    ///Custom Error type `InvalidMajorityPercentage` with signature `InvalidMajorityPercentage()` and selector `0x75c3b427`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
    )]
    #[etherror(
        name = "InvalidMajorityPercentage",
        abi = "InvalidMajorityPercentage()"
    )]
=======
        Hash
    )]
    #[etherror(name = "InvalidMajorityPercentage", abi = "InvalidMajorityPercentage()")]
>>>>>>> f7ef052 (add address check)
    pub struct InvalidMajorityPercentage;
    ///Custom Error type `InvalidSubmissionPeriod` with signature `InvalidSubmissionPeriod()` and selector `0x312f8e05`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(name = "InvalidSubmissionPeriod", abi = "InvalidSubmissionPeriod()")]
    pub struct InvalidSubmissionPeriod;
    ///Custom Error type `NoBytecodeAtAddress` with signature `NoBytecodeAtAddress(address,string)` and selector `0x919834b9`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(
        name = "NoBytecodeAtAddress",
        abi = "NoBytecodeAtAddress(address,string)"
    )]
    pub struct NoBytecodeAtAddress {
        pub contract_address: ::ethers::core::types::Address,
        pub message: ::std::string::String,
    }
    ///Custom Error type `NoSelectorsProvidedForFacetForCut` with signature `NoSelectorsProvidedForFacetForCut(address)` and selector `0xe767f91f`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
<<<<<<< HEAD
        Hash,
=======
        Hash
>>>>>>> f7ef052 (add address check)
    )]
    #[etherror(
        name = "NoSelectorsProvidedForFacetForCut",
        abi = "NoSelectorsProvidedForFacetForCut(address)"
    )]
    pub struct NoSelectorsProvidedForFacetForCut {
        pub facet_address: ::ethers::core::types::Address,
    }
    ///Container type for all of the contract's custom errors
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum GatewayDiamondErrors {
<<<<<<< HEAD
        CannotAddFunctionToDiamondThatAlreadyExists(CannotAddFunctionToDiamondThatAlreadyExists),
=======
        CannotAddFunctionToDiamondThatAlreadyExists(
            CannotAddFunctionToDiamondThatAlreadyExists,
        ),
>>>>>>> f7ef052 (add address check)
        CannotAddSelectorsToZeroAddress(CannotAddSelectorsToZeroAddress),
        FunctionNotFound(FunctionNotFound),
        IncorrectFacetCutAction(IncorrectFacetCutAction),
        InitializationFunctionReverted(InitializationFunctionReverted),
        InvalidCollateral(InvalidCollateral),
        InvalidMajorityPercentage(InvalidMajorityPercentage),
        InvalidSubmissionPeriod(InvalidSubmissionPeriod),
        NoBytecodeAtAddress(NoBytecodeAtAddress),
        NoSelectorsProvidedForFacetForCut(NoSelectorsProvidedForFacetForCut),
        /// The standard solidity revert string, with selector
        /// Error(string) -- 0x08c379a0
        RevertString(::std::string::String),
    }
    impl ::ethers::core::abi::AbiDecode for GatewayDiamondErrors {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
<<<<<<< HEAD
            if let Ok(decoded) =
                <::std::string::String as ::ethers::core::abi::AbiDecode>::decode(data)
            {
=======
            if let Ok(decoded) = <::std::string::String as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
>>>>>>> f7ef052 (add address check)
                return Ok(Self::RevertString(decoded));
            }
            if let Ok(decoded) = <CannotAddFunctionToDiamondThatAlreadyExists as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotAddFunctionToDiamondThatAlreadyExists(decoded));
            }
<<<<<<< HEAD
            if let Ok(decoded) =
                <CannotAddSelectorsToZeroAddress as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::CannotAddSelectorsToZeroAddress(decoded));
            }
            if let Ok(decoded) = <FunctionNotFound as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::FunctionNotFound(decoded));
            }
            if let Ok(decoded) =
                <IncorrectFacetCutAction as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::IncorrectFacetCutAction(decoded));
            }
            if let Ok(decoded) =
                <InitializationFunctionReverted as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InitializationFunctionReverted(decoded));
            }
            if let Ok(decoded) = <InvalidCollateral as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InvalidCollateral(decoded));
            }
            if let Ok(decoded) =
                <InvalidMajorityPercentage as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InvalidMajorityPercentage(decoded));
            }
            if let Ok(decoded) =
                <InvalidSubmissionPeriod as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::InvalidSubmissionPeriod(decoded));
            }
            if let Ok(decoded) =
                <NoBytecodeAtAddress as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::NoBytecodeAtAddress(decoded));
            }
            if let Ok(decoded) =
                <NoSelectorsProvidedForFacetForCut as ::ethers::core::abi::AbiDecode>::decode(data)
            {
=======
            if let Ok(decoded) = <CannotAddSelectorsToZeroAddress as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotAddSelectorsToZeroAddress(decoded));
            }
            if let Ok(decoded) = <FunctionNotFound as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::FunctionNotFound(decoded));
            }
            if let Ok(decoded) = <IncorrectFacetCutAction as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::IncorrectFacetCutAction(decoded));
            }
            if let Ok(decoded) = <InitializationFunctionReverted as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::InitializationFunctionReverted(decoded));
            }
            if let Ok(decoded) = <InvalidCollateral as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::InvalidCollateral(decoded));
            }
            if let Ok(decoded) = <InvalidMajorityPercentage as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::InvalidMajorityPercentage(decoded));
            }
            if let Ok(decoded) = <InvalidSubmissionPeriod as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::InvalidSubmissionPeriod(decoded));
            }
            if let Ok(decoded) = <NoBytecodeAtAddress as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::NoBytecodeAtAddress(decoded));
            }
            if let Ok(decoded) = <NoSelectorsProvidedForFacetForCut as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
>>>>>>> f7ef052 (add address check)
                return Ok(Self::NoSelectorsProvidedForFacetForCut(decoded));
            }
            Err(::ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ::ethers::core::abi::AbiEncode for GatewayDiamondErrors {
        fn encode(self) -> ::std::vec::Vec<u8> {
            match self {
                Self::CannotAddFunctionToDiamondThatAlreadyExists(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CannotAddSelectorsToZeroAddress(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
<<<<<<< HEAD
                Self::FunctionNotFound(element) => ::ethers::core::abi::AbiEncode::encode(element),
=======
                Self::FunctionNotFound(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
>>>>>>> f7ef052 (add address check)
                Self::IncorrectFacetCutAction(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InitializationFunctionReverted(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
<<<<<<< HEAD
                Self::InvalidCollateral(element) => ::ethers::core::abi::AbiEncode::encode(element),
=======
                Self::InvalidCollateral(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
>>>>>>> f7ef052 (add address check)
                Self::InvalidMajorityPercentage(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InvalidSubmissionPeriod(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NoBytecodeAtAddress(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NoSelectorsProvidedForFacetForCut(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::RevertString(s) => ::ethers::core::abi::AbiEncode::encode(s),
            }
        }
    }
    impl ::ethers::contract::ContractRevert for GatewayDiamondErrors {
        fn valid_selector(selector: [u8; 4]) -> bool {
            match selector {
                [0x08, 0xc3, 0x79, 0xa0] => true,
                _ if selector
                    == <CannotAddFunctionToDiamondThatAlreadyExists as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CannotAddSelectorsToZeroAddress as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <FunctionNotFound as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <IncorrectFacetCutAction as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InitializationFunctionReverted as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InvalidCollateral as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InvalidMajorityPercentage as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <InvalidSubmissionPeriod as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NoBytecodeAtAddress as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NoSelectorsProvidedForFacetForCut as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ => false,
            }
        }
    }
    impl ::core::fmt::Display for GatewayDiamondErrors {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::CannotAddFunctionToDiamondThatAlreadyExists(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::CannotAddSelectorsToZeroAddress(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::FunctionNotFound(element) => ::core::fmt::Display::fmt(element, f),
<<<<<<< HEAD
                Self::IncorrectFacetCutAction(element) => ::core::fmt::Display::fmt(element, f),
=======
                Self::IncorrectFacetCutAction(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
>>>>>>> f7ef052 (add address check)
                Self::InitializationFunctionReverted(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidCollateral(element) => ::core::fmt::Display::fmt(element, f),
<<<<<<< HEAD
                Self::InvalidMajorityPercentage(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidSubmissionPeriod(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoBytecodeAtAddress(element) => ::core::fmt::Display::fmt(element, f),
=======
                Self::InvalidMajorityPercentage(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidSubmissionPeriod(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::NoBytecodeAtAddress(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
>>>>>>> f7ef052 (add address check)
                Self::NoSelectorsProvidedForFacetForCut(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::RevertString(s) => ::core::fmt::Display::fmt(s, f),
            }
        }
    }
    impl ::core::convert::From<::std::string::String> for GatewayDiamondErrors {
        fn from(value: String) -> Self {
            Self::RevertString(value)
        }
    }
<<<<<<< HEAD
    impl ::core::convert::From<CannotAddFunctionToDiamondThatAlreadyExists> for GatewayDiamondErrors {
=======
    impl ::core::convert::From<CannotAddFunctionToDiamondThatAlreadyExists>
    for GatewayDiamondErrors {
>>>>>>> f7ef052 (add address check)
        fn from(value: CannotAddFunctionToDiamondThatAlreadyExists) -> Self {
            Self::CannotAddFunctionToDiamondThatAlreadyExists(value)
        }
    }
<<<<<<< HEAD
    impl ::core::convert::From<CannotAddSelectorsToZeroAddress> for GatewayDiamondErrors {
=======
    impl ::core::convert::From<CannotAddSelectorsToZeroAddress>
    for GatewayDiamondErrors {
>>>>>>> f7ef052 (add address check)
        fn from(value: CannotAddSelectorsToZeroAddress) -> Self {
            Self::CannotAddSelectorsToZeroAddress(value)
        }
    }
    impl ::core::convert::From<FunctionNotFound> for GatewayDiamondErrors {
        fn from(value: FunctionNotFound) -> Self {
            Self::FunctionNotFound(value)
        }
    }
    impl ::core::convert::From<IncorrectFacetCutAction> for GatewayDiamondErrors {
        fn from(value: IncorrectFacetCutAction) -> Self {
            Self::IncorrectFacetCutAction(value)
        }
    }
    impl ::core::convert::From<InitializationFunctionReverted> for GatewayDiamondErrors {
        fn from(value: InitializationFunctionReverted) -> Self {
            Self::InitializationFunctionReverted(value)
        }
    }
    impl ::core::convert::From<InvalidCollateral> for GatewayDiamondErrors {
        fn from(value: InvalidCollateral) -> Self {
            Self::InvalidCollateral(value)
        }
    }
    impl ::core::convert::From<InvalidMajorityPercentage> for GatewayDiamondErrors {
        fn from(value: InvalidMajorityPercentage) -> Self {
            Self::InvalidMajorityPercentage(value)
        }
    }
    impl ::core::convert::From<InvalidSubmissionPeriod> for GatewayDiamondErrors {
        fn from(value: InvalidSubmissionPeriod) -> Self {
            Self::InvalidSubmissionPeriod(value)
        }
    }
    impl ::core::convert::From<NoBytecodeAtAddress> for GatewayDiamondErrors {
        fn from(value: NoBytecodeAtAddress) -> Self {
            Self::NoBytecodeAtAddress(value)
        }
    }
<<<<<<< HEAD
    impl ::core::convert::From<NoSelectorsProvidedForFacetForCut> for GatewayDiamondErrors {
=======
    impl ::core::convert::From<NoSelectorsProvidedForFacetForCut>
    for GatewayDiamondErrors {
>>>>>>> f7ef052 (add address check)
        fn from(value: NoSelectorsProvidedForFacetForCut) -> Self {
            Self::NoSelectorsProvidedForFacetForCut(value)
        }
    }
}
