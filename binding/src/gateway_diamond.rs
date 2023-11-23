pub use gateway_diamond::*;
/// This module was auto-generated with ethers-rs Abigen.
/// More information at: <https://github.com/gakonst/ethers-rs>
#[allow(
    clippy::enum_variant_names,
    clippy::too_many_arguments,
    clippy::upper_case_acronyms,
    clippy::type_complexity,
    dead_code,
    non_camel_case_types,
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
                        ),
                    },
                    ::ethers::core::abi::ethabi::Param {
                        name: ::std::borrow::ToOwned::to_owned("params"),
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
                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                ::ethers::core::abi::ethabi::ParamType::Array(
                                    ::std::boxed::Box::new(
                                        ::ethers::core::abi::ethabi::ParamType::Tuple(
                                            ::std::vec![
                                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                                ::ethers::core::abi::ethabi::ParamType::Address,
                                                ::ethers::core::abi::ethabi::ParamType::Bytes,
                                            ],
                                        ),
                                    ),
                                ),
                                ::ethers::core::abi::ethabi::ParamType::Uint(16usize),
                            ],
                        ),
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
                    ::std::borrow::ToOwned::to_owned(
                        "CannotRemoveFunctionThatDoesNotExist",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotRemoveFunctionThatDoesNotExist",
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
                    ::std::borrow::ToOwned::to_owned("CannotRemoveImmutableFunction"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotRemoveImmutableFunction",
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
                    ::std::borrow::ToOwned::to_owned(
                        "CannotReplaceFunctionThatDoesNotExists",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotReplaceFunctionThatDoesNotExists",
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
                    ::std::borrow::ToOwned::to_owned(
                        "CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet",
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
                    ::std::borrow::ToOwned::to_owned(
                        "CannotReplaceFunctionsFromFacetWithZeroAddress",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotReplaceFunctionsFromFacetWithZeroAddress",
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
                    ::std::borrow::ToOwned::to_owned("CannotReplaceImmutableFunction"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "CannotReplaceImmutableFunction",
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
                ),
                (
                    ::std::borrow::ToOwned::to_owned("OldConfigurationNumber"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "OldConfigurationNumber",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned(
                        "RemoveFacetAddressMustBeZeroAddress",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "RemoveFacetAddressMustBeZeroAddress",
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
                ),
            ]),
            receive: true,
            fallback: true,
        }
    }
    ///The parsed JSON ABI of the contract.
    pub static GATEWAYDIAMOND_ABI: ::ethers::contract::Lazy<::ethers::core::abi::Abi> = ::ethers::contract::Lazy::new(
        __abi,
    );
    #[rustfmt::skip]
    const __BYTECODE: &[u8] = b"`\x80`@R4\x80\x15b\0\0\x11W`\0\x80\xFD[P`@Qb\0\x1E\x9A8\x03\x80b\0\x1E\x9A\x839\x81\x01`@\x81\x90Rb\0\x004\x91b\0\x15\xC2V[\x80`@\x01Q`\0\x03b\0\0ZW`@Qch\xF7\xA6u`\xE1\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x80` \x01Q`\x01`\x01`@\x1B\x03\x16`\0\x03b\0\0\x89W`@Qc1/\x8E\x05`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[`3\x81`\x80\x01Q`\xFF\x16\x10\x80b\0\0\xA7WP`d\x81`\x80\x01Q`\xFF\x16\x11[\x15b\0\0\xC6W`@Qcu\xC3\xB4'`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5\x80T`\x01`\x01`\xA0\x1B\x03\x19\x163\x17\x90U`@\x80Q`\0\x80\x82R` \x82\x01\x90\x92Rb\0\x01\x14\x91\x84\x91b\0\x02\x0CV[\x80Q\x80Q`\x12\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x81U` \x80\x83\x01Q\x80Qb\0\x01O\x92`\x13\x92\x01\x90b\0\x0F\xEFV[PPP`@\x81\x81\x01Q`\x14U` \x80\x83\x01Q`\x17\x80T`\x01`\x01`@\x1B\x03\x19\x90\x81\x16`\x01`\x01`@\x1B\x03\x90\x93\x16\x92\x90\x92\x17\x90U``\x84\x01Q`\x15U`\x80\x84\x01Q`\x16\x80T`\xFF\x19\x16`\xFF\x90\x92\x16\x91\x90\x91\x17\x90U`\x0C\x80T\x90\x91\x16`\x01\x17\x90U`\xC0\x83\x01Q`\x18\x80Ta\xFF\xFF\x19\x16a\xFF\xFF\x90\x92\x16\x91\x90\x91\x17\x90U`!\x80T`\x01`\x01`\x80\x1B\x03\x19\x16h\x01\0\0\0\0\0\0\0\x01\x17\x90U\x81Q\x80\x83\x01\x90\x92R`\xA0\x83\x01Q\x82R`\0\x90\x82\x01Rb\0\x02\x03\x81b\0\x03\xCDV[PPPb\0\x1C\xFBV[\x82Q`\0[\x81\x81\x10\x15b\0\x03}W`\0\x85\x82\x81Q\x81\x10b\0\x021Wb\0\x021b\0\x17zV[` \x02` \x01\x01Q`@\x01Q\x90P`\0\x86\x83\x81Q\x81\x10b\0\x02VWb\0\x02Vb\0\x17zV[` \x02` \x01\x01Q`\0\x01Q\x90P\x81Q`\0\x03b\0\x02\x97W`@Qc\xE7g\xF9\x1F`\xE0\x1B\x81R`\x01`\x01`\xA0\x1B\x03\x82\x16`\x04\x82\x01R`$\x01[`@Q\x80\x91\x03\x90\xFD[`\0\x87\x84\x81Q\x81\x10b\0\x02\xAEWb\0\x02\xAEb\0\x17zV[` \x02` \x01\x01Q` \x01Q\x90P`\0`\x02\x81\x11\x15b\0\x02\xD2Wb\0\x02\xD2b\0\x17\x90V[\x81`\x02\x81\x11\x15b\0\x02\xE7Wb\0\x02\xE7b\0\x17\x90V[\x03b\0\x02\xFFWb\0\x02\xF9\x82\x84b\0\x07\xDFV[b\0\x03nV[`\x01\x81`\x02\x81\x11\x15b\0\x03\x16Wb\0\x03\x16b\0\x17\x90V[\x03b\0\x03(Wb\0\x02\xF9\x82\x84b\0\t\x9BV[`\x02\x81`\x02\x81\x11\x15b\0\x03?Wb\0\x03?b\0\x17\x90V[\x03b\0\x03QWb\0\x02\xF9\x82\x84b\0\x0B1V[\x80`@Qc?\xF4\xD2\x0F`\xE1\x1B\x81R`\x04\x01b\0\x02\x8E\x91\x90b\0\x17\xC9V[\x83`\x01\x01\x93PPPPb\0\x02\x11V[P\x7F\x8F\xAAp\x87\x86q\xCC\xD2\x12\xD2\x07q\xB7\x95\xC5\n\xF8\xFD?\xF6\xCF'\xF4\xBD\xE5~]M\xE0\xAE\xB6s\x84\x84\x84`@Qb\0\x03\xB3\x93\x92\x91\x90b\0\x18NV[`@Q\x80\x91\x03\x90\xA1b\0\x03\xC7\x83\x83b\0\r\xC8V[PPPPV[\x7F~\xCD\xACH#4\xC3o\xCC\xBE7C\x18\xCF\xE7N\xA0\xC8\x18\x13\x94\x89\r\xDE\xC8\x94\xA1\x0F\x0F\xCCt\x81\x81`@Qb\0\x03\xFE\x91\x90b\0\x19\x8CV[`@Q\x80\x91\x03\x90\xA1`\x06T`\0\x90`\x01`\x01`@\x1B\x03\x16\x15b\0\x05\xBFW`\x08\x81\x01T` \x83\x01Q`\x01`\x01`@\x1B\x03\x91\x82\x16\x91\x16\x03b\0\x04<WPPV[`\x08\x81\x01T` \x83\x01Q`\x01`\x01`@\x1B\x03\x91\x82\x16\x91\x16\x10\x15b\0\x04sW`@Qc7F\xBE%`\xE1\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[`@\x80Q`\x05\x83\x01\x80T``` \x82\x02\x84\x01\x81\x01\x85R\x93\x83\x01\x81\x81Rb\0\x05\xB5\x94\x87\x94\x93\x92\x84\x92\x91\x84\x91\x90`\0\x90\x85\x01[\x82\x82\x10\x15b\0\x05\x92W`\0\x84\x81R` \x90\x81\x90 `@\x80Q``\x81\x01\x82R`\x03\x86\x02\x90\x92\x01\x80T\x83R`\x01\x81\x01T`\x01`\x01`\xA0\x1B\x03\x16\x93\x83\x01\x93\x90\x93R`\x02\x83\x01\x80T\x92\x93\x92\x91\x84\x01\x91b\0\x04\xFA\x90b\0\x19\xCBV[\x80`\x1F\x01` \x80\x91\x04\x02` \x01`@Q\x90\x81\x01`@R\x80\x92\x91\x90\x81\x81R` \x01\x82\x80Tb\0\x05(\x90b\0\x19\xCBV[\x80\x15b\0\x05yW\x80`\x1F\x10b\0\x05MWa\x01\0\x80\x83T\x04\x02\x83R\x91` \x01\x91b\0\x05yV[\x82\x01\x91\x90`\0R` `\0 \x90[\x81T\x81R\x90`\x01\x01\x90` \x01\x80\x83\x11b\0\x05[W\x82\x90\x03`\x1F\x16\x82\x01\x91[PPPPP\x81RPP\x81R` \x01\x90`\x01\x01\x90b\0\x04\xA4V[PPP\x90\x82RP`\x01\x91\x90\x91\x01T`\x01`\x01`@\x1B\x03\x16` \x90\x91\x01Rb\0\x0E\x9AV[\x15b\0\x05\xBFWPPV[`\x05\x81\x01\x80T`\x07\x83\x01\x90b\0\x05\xD9\x90\x82\x90\x84\x90b\0\x10YV[P`\x01\x91\x82\x01T\x91\x01\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x90U\x81QQ`\x05\x82\x01T`\0[\x82\x81\x10\x15b\0\x07@W\x81\x81\x10\x15b\0\x06\xB2W\x84Q\x80Q\x82\x90\x81\x10b\0\x063Wb\0\x063b\0\x17zV[` \x02` \x01\x01Q\x84`\x05\x01`\0\x01\x82\x81T\x81\x10b\0\x06VWb\0\x06Vb\0\x17zV[`\0\x91\x82R` \x91\x82\x90 \x83Q`\x03\x92\x90\x92\x02\x01\x90\x81U\x90\x82\x01Q`\x01\x82\x01\x80T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x90U`@\x82\x01Q`\x02\x82\x01\x90b\0\x06\xA8\x90\x82b\0\x1AQV[P\x90PPb\0\x077V[\x84Q\x80Q`\x05\x86\x01\x91\x90\x83\x90\x81\x10b\0\x06\xCFWb\0\x06\xCFb\0\x17zV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q\x82T`\x01\x80\x82\x01\x85U`\0\x94\x85R\x93\x83\x90 \x82Q`\x03\x90\x92\x02\x01\x90\x81U\x91\x81\x01Q\x92\x82\x01\x80T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x90\x94\x16\x93\x90\x93\x17\x90\x92U`@\x82\x01Q`\x02\x82\x01\x90b\0\x073\x90\x82b\0\x1AQV[PPP[`\x01\x01b\0\x06\nV[P` \x84\x01Q`\x06\x84\x01\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x90U\x81\x81\x11\x15b\0\x03\xC7W\x81[\x81\x81\x10\x15b\0\x07\xD8W`\x05\x84\x01\x80T\x80b\0\x07\x91Wb\0\x07\x91b\0\x1B\x1DV[`\0\x82\x81R` \x81 `\x03`\0\x19\x90\x93\x01\x92\x83\x02\x01\x81\x81U`\x01\x81\x01\x80T`\x01`\x01`\xA0\x1B\x03\x19\x16\x90U\x90b\0\x07\xCB`\x02\x83\x01\x82b\0\x10\xEFV[PP\x90U`\x01\x01b\0\x07rV[PPPPPV[`\x01`\x01`\xA0\x1B\x03\x82\x16b\0\x08\x0BW\x80`@Qc\x02\xB8\xDA\x07`\xE2\x1B\x81R`\x04\x01b\0\x02\x8E\x91\x90b\0\x1B3V[`\0\x80Q` b\0\x1E\x11\x839\x81Q\x91RT`@\x80Q``\x81\x01\x90\x91R`!\x80\x82R`\0\x80Q` b\0\x1Ez\x839\x81Q\x91R\x92\x91b\0\x08U\x91\x86\x91\x90b\0\x1E1` \x83\x019b\0\x0FjV[\x82Q`\0[\x81\x81\x10\x15b\0\t\x93W`\0\x85\x82\x81Q\x81\x10b\0\x08zWb\0\x08zb\0\x17zV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R\x91\x87\x90R`@\x90\x91 T\x90\x91P`\x01`\x01`\xA0\x1B\x03\x16\x80\x15b\0\x08\xD9W`@Qc\xEB\xBF]\x07`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[`@\x80Q\x80\x82\x01\x82R`\x01`\x01`\xA0\x1B\x03\x80\x8B\x16\x82Ra\xFF\xFF\x80\x89\x16` \x80\x85\x01\x91\x82R`\x01`\x01`\xE0\x1B\x03\x19\x88\x16`\0\x90\x81R\x8C\x82R\x95\x86 \x94Q\x85T\x92Q\x90\x93\x16`\x01`\xA0\x1B\x02`\x01`\x01`\xB0\x1B\x03\x19\x90\x92\x16\x92\x90\x93\x16\x91\x90\x91\x17\x17\x90\x91U`\x01\x80\x89\x01\x80T\x91\x82\x01\x81U\x83R\x91 `\x08\x82\x04\x01\x80T`\xE0\x85\x90\x1C`\x04`\x07\x90\x94\x16\x93\x90\x93\x02a\x01\0\n\x92\x83\x02c\xFF\xFF\xFF\xFF\x90\x93\x02\x19\x16\x91\x90\x91\x17\x90Ub\0\t\x83\x85b\0\x1BeV[\x94P\x82`\x01\x01\x92PPPb\0\x08ZV[PPPPPPV[`\0\x80Q` b\0\x1Ez\x839\x81Q\x91R`\x01`\x01`\xA0\x1B\x03\x83\x16b\0\t\xD7W\x81`@Qc\xCD\x98\xA9o`\xE0\x1B\x81R`\x04\x01b\0\x02\x8E\x91\x90b\0\x1B3V[b\0\t\xFC\x83`@Q\x80``\x01`@R\x80`(\x81R` \x01b\0\x1ER`(\x919b\0\x0FjV[\x81Q`\0[\x81\x81\x10\x15b\0\x07\xD8W`\0\x84\x82\x81Q\x81\x10b\0\n!Wb\0\n!b\0\x17zV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R\x91\x86\x90R`@\x90\x91 T\x90\x91P`\x01`\x01`\xA0\x1B\x03\x160\x81\x03b\0\n\x81W`@Qc)\x01\x80m`\xE1\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[\x86`\x01`\x01`\xA0\x1B\x03\x16\x81`\x01`\x01`\xA0\x1B\x03\x16\x03b\0\n\xC1W`@Qc\x1A\xC6\xCE\x8D`\xE1\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[`\x01`\x01`\xA0\x1B\x03\x81\x16b\0\n\xF6W`@Qcty\xF99`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[P`\x01`\x01`\xE0\x1B\x03\x19\x16`\0\x90\x81R` \x84\x90R`@\x90 \x80T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x87\x16\x17\x90U`\x01\x01b\0\n\x01V[`\0\x80Q` b\0\x1E\x11\x839\x81Q\x91RT`\0\x80Q` b\0\x1Ez\x839\x81Q\x91R\x90`\x01`\x01`\xA0\x1B\x03\x84\x16\x15b\0\x0B\x88W`@Qc\xD0\x91\xBC\x81`\xE0\x1B\x81R`\x01`\x01`\xA0\x1B\x03\x85\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[\x82Q`\0[\x81\x81\x10\x15b\0\t\x93W`\0\x85\x82\x81Q\x81\x10b\0\x0B\xADWb\0\x0B\xADb\0\x17zV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R\x87\x83R`@\x90\x81\x90 \x81Q\x80\x83\x01\x90\x92RT`\x01`\x01`\xA0\x1B\x03\x81\x16\x80\x83R`\x01`\xA0\x1B\x90\x91\x04a\xFF\xFF\x16\x93\x82\x01\x93\x90\x93R\x90\x92P\x90b\0\x0C*W`@Qcz\x08\xA2-`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[\x80Q0`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x03b\0\x0CdW`@Qc\r\xF5\xFDa`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x02\x8EV[b\0\x0Co\x85b\0\x1B\x89V[\x94P\x84\x81` \x01Qa\xFF\xFF\x16\x14b\0\rSW`\0\x86`\x01\x01\x86\x81T\x81\x10b\0\x0C\x9BWb\0\x0C\x9Bb\0\x17zV[\x90`\0R` `\0 \x90`\x08\x91\x82\x82\x04\x01\x91\x90\x06`\x04\x02\x90T\x90a\x01\0\n\x90\x04`\xE0\x1B\x90P\x80\x87`\x01\x01\x83` \x01Qa\xFF\xFF\x16\x81T\x81\x10b\0\x0C\xE1Wb\0\x0C\xE1b\0\x17zV[`\0\x91\x82R` \x80\x83 `\x08\x83\x04\x01\x80Tc\xFF\xFF\xFF\xFF`\x07\x90\x94\x16`\x04\x02a\x01\0\n\x93\x84\x02\x19\x16`\xE0\x95\x90\x95\x1C\x92\x90\x92\x02\x93\x90\x93\x17\x90U\x83\x82\x01Q`\x01`\x01`\xE0\x1B\x03\x19\x93\x90\x93\x16\x81R\x90\x88\x90R`@\x90 \x80Ta\xFF\xFF`\xA0\x1B\x19\x16`\x01`\xA0\x1Ba\xFF\xFF\x90\x93\x16\x92\x90\x92\x02\x91\x90\x91\x17\x90U[\x85`\x01\x01\x80T\x80b\0\riWb\0\rib\0\x1B\x1DV[`\0\x82\x81R` \x80\x82 `\x08`\0\x19\x90\x94\x01\x93\x84\x04\x01\x80Tc\xFF\xFF\xFF\xFF`\x04`\x07\x87\x16\x02a\x01\0\n\x02\x19\x16\x90U\x91\x90\x92U`\x01`\x01`\xE0\x1B\x03\x19\x90\x93\x16\x81R\x91\x86\x90RP`@\x90 \x80T`\x01`\x01`\xB0\x1B\x03\x19\x16\x90U`\x01\x01b\0\x0B\x8DV[`\x01`\x01`\xA0\x1B\x03\x82\x16b\0\r\xDBWPPV[b\0\x0E\0\x82`@Q\x80``\x01`@R\x80`%\x81R` \x01b\0\x1D\xEC`%\x919b\0\x0FjV[`\0\x80\x83`\x01`\x01`\xA0\x1B\x03\x16\x83`@Qb\0\x0E\x1D\x91\x90b\0\x1B\xA3V[`\0`@Q\x80\x83\x03\x81\x85Z\xF4\x91PP=\x80`\0\x81\x14b\0\x0EZW`@Q\x91P`\x1F\x19`?=\x01\x16\x82\x01`@R=\x82R=`\0` \x84\x01>b\0\x0E_V[``\x91P[P\x91P\x91P\x81b\0\x03\xC7W\x80Q\x15b\0\x0E{W\x80Q\x80\x82` \x01\xFD[\x83\x83`@Qc\x19!\x05\xD7`\xE0\x1B\x81R`\x04\x01b\0\x02\x8E\x92\x91\x90b\0\x1B\xC1V[`\0\x81` \x01Q`\x01`\x01`@\x1B\x03\x16\x83` \x01Q`\x01`\x01`@\x1B\x03\x16\x14b\0\x0E\xC7WP`\0b\0\x0FdV[b\0\x0E\xD2\x82b\0\x0F\x9AV[b\0\x0E\xDD\x84b\0\x0F\x9AV[\x14b\0\x0E\xECWP`\0b\0\x0FdV[\x81QQ\x83QQ\x14b\0\x0F\x01WP`\0b\0\x0FdV[\x82Q`@Q`\0\x91b\0\x0F\x17\x91` \x01b\0\x1B\xEFV[`@\x80Q`\x1F\x19\x81\x84\x03\x01\x81R\x90\x82\x90R\x80Q` \x91\x82\x01 \x85Q\x90\x93P`\0\x92b\0\x0FD\x92\x01b\0\x1B\xEFV[`@Q` \x81\x83\x03\x03\x81R\x90`@R\x80Q\x90` \x01 \x90P\x80\x82\x14\x92PPP[\x92\x91PPV[\x81;`\0\x81\x90\x03b\0\x0F\x95W\x82\x82`@Qc\x91\x984\xB9`\xE0\x1B\x81R`\x04\x01b\0\x02\x8E\x92\x91\x90b\0\x1B\xC1V[PPPV[\x80QQ`\0\x90\x81\x80[\x82\x81\x10\x15b\0\x0F\xE7W\x84Q\x80Q\x82\x90\x81\x10b\0\x0F\xC3Wb\0\x0F\xC3b\0\x17zV[` \x02` \x01\x01Q`\0\x01Q\x82b\0\x0F\xDC\x91\x90b\0\x1C\x04V[\x91P`\x01\x01b\0\x0F\xA3V[P\x93\x92PPPV[\x82\x80T\x82\x82U\x90`\0R` `\0 \x90\x81\x01\x92\x82\x15b\0\x10GW\x91` \x02\x82\x01[\x82\x81\x11\x15b\0\x10GW\x82Q\x82T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x17\x82U` \x90\x92\x01\x91`\x01\x90\x91\x01\x90b\0\x10\x10V[Pb\0\x10U\x92\x91Pb\0\x111V[P\x90V[\x82\x80T\x82\x82U\x90`\0R` `\0 \x90`\x03\x02\x81\x01\x92\x82\x15b\0\x10\xE1W`\0R` `\0 \x91`\x03\x02\x82\x01[\x82\x81\x11\x15b\0\x10\xE1W\x82T\x82U`\x01\x80\x84\x01T\x90\x83\x01\x80T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x90U\x82\x82`\x02\x80\x82\x01\x90b\0\x10\xCE\x90\x84\x01\x82b\0\x1C\x1AV[PPP\x91`\x03\x01\x91\x90`\x03\x01\x90b\0\x10\x85V[Pb\0\x10U\x92\x91Pb\0\x11HV[P\x80Tb\0\x10\xFD\x90b\0\x19\xCBV[`\0\x82U\x80`\x1F\x10b\0\x11\x0EWPPV[`\x1F\x01` \x90\x04\x90`\0R` `\0 \x90\x81\x01\x90b\0\x11.\x91\x90b\0\x111V[PV[[\x80\x82\x11\x15b\0\x10UW`\0\x81U`\x01\x01b\0\x112V[\x80\x82\x11\x15b\0\x10UW`\0\x80\x82U`\x01\x82\x01\x80T`\x01`\x01`\xA0\x1B\x03\x19\x16\x90Ub\0\x11w`\x02\x83\x01\x82b\0\x10\xEFV[P`\x03\x01b\0\x11HV[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[`@\x80Q\x90\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x11\xBCWb\0\x11\xBCb\0\x11\x81V[`@R\x90V[`@Q``\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x11\xBCWb\0\x11\xBCb\0\x11\x81V[`@Q`\xE0\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x11\xBCWb\0\x11\xBCb\0\x11\x81V[`@Q`\x1F\x82\x01`\x1F\x19\x16\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x127Wb\0\x127b\0\x11\x81V[`@R\x91\x90PV[`\0`\x01`\x01`@\x1B\x03\x82\x11\x15b\0\x12[Wb\0\x12[b\0\x11\x81V[P`\x05\x1B` \x01\x90V[\x80Q`\x01`\x01`\xA0\x1B\x03\x81\x16\x81\x14b\0\x12}W`\0\x80\xFD[\x91\x90PV[\x80Q`\x01`\x01`@\x1B\x03\x81\x16\x81\x14b\0\x12}W`\0\x80\xFD[`\0`@\x82\x84\x03\x12\x15b\0\x12\xADW`\0\x80\xFD[b\0\x12\xB7b\0\x11\x97V[\x90Pb\0\x12\xC4\x82b\0\x12\x82V[\x81R` \x82\x81\x01Q`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x12\xE1W`\0\x80\xFD[\x83\x01`\x1F\x81\x01\x85\x13b\0\x12\xF3W`\0\x80\xFD[\x80Qb\0\x13\nb\0\x13\x04\x82b\0\x12?V[b\0\x12\x0CV[\x81\x81R`\x05\x91\x90\x91\x1B\x82\x01\x83\x01\x90\x83\x81\x01\x90\x87\x83\x11\x15b\0\x13*W`\0\x80\xFD[\x92\x84\x01\x92[\x82\x84\x10\x15b\0\x13SWb\0\x13C\x84b\0\x12eV[\x82R\x92\x84\x01\x92\x90\x84\x01\x90b\0\x13/V[\x80\x85\x87\x01RPPPPP\x92\x91PPV[\x80Q`\xFF\x81\x16\x81\x14b\0\x12}W`\0\x80\xFD[`\0[\x83\x81\x10\x15b\0\x13\x92W\x81\x81\x01Q\x83\x82\x01R` \x01b\0\x13xV[PP`\0\x91\x01RV[`\0`\x1F\x83\x81\x84\x01\x12b\0\x13\xAEW`\0\x80\xFD[\x82Q` b\0\x13\xC1b\0\x13\x04\x83b\0\x12?V[\x82\x81R`\x05\x92\x90\x92\x1B\x85\x01\x81\x01\x91\x81\x81\x01\x90\x87\x84\x11\x15b\0\x13\xE1W`\0\x80\xFD[\x82\x87\x01[\x84\x81\x10\x15b\0\x14\xDEW\x80Q`\x01`\x01`@\x1B\x03\x80\x82\x11\x15b\0\x14\x07W`\0\x80\x81\xFD[\x90\x89\x01\x90```\x1F\x19\x83\x8D\x03\x81\x01\x82\x13\x15b\0\x14#W`\0\x80\x81\xFD[b\0\x14-b\0\x11\xC2V[\x88\x85\x01Q\x81R`@b\0\x14B\x81\x87\x01b\0\x12eV[\x82\x8B\x01R\x92\x85\x01Q\x92\x84\x84\x11\x15b\0\x14ZW`\0\x80\x81\xFD[\x83\x86\x01\x95P\x8E`?\x87\x01\x12b\0\x14rW`\0\x93P\x83\x84\xFD[\x89\x86\x01Q\x93P\x84\x84\x11\x15b\0\x14\x8BWb\0\x14\x8Bb\0\x11\x81V[b\0\x14\x9C\x8A\x84\x8E\x87\x01\x16\x01b\0\x12\x0CV[\x94P\x83\x85R\x8E\x81\x85\x88\x01\x01\x11\x15b\0\x14\xB6W`\0\x92P\x82\x83\xFD[b\0\x14\xC7\x84\x8B\x87\x01\x83\x89\x01b\0\x13uV[\x81\x01\x93\x90\x93RPP\x84RP\x91\x83\x01\x91\x83\x01b\0\x13\xE5V[P\x97\x96PPPPPPPV[\x80Qa\xFF\xFF\x81\x16\x81\x14b\0\x12}W`\0\x80\xFD[`\0`\xE0\x82\x84\x03\x12\x15b\0\x15\x10W`\0\x80\xFD[b\0\x15\x1Ab\0\x11\xE7V[\x82Q\x90\x91P`\x01`\x01`@\x1B\x03\x80\x82\x11\x15b\0\x155W`\0\x80\xFD[b\0\x15C\x85\x83\x86\x01b\0\x12\x9AV[\x83Rb\0\x15S` \x85\x01b\0\x12\x82V[` \x84\x01R`@\x84\x01Q`@\x84\x01R``\x84\x01Q``\x84\x01Rb\0\x15z`\x80\x85\x01b\0\x13cV[`\x80\x84\x01R`\xA0\x84\x01Q\x91P\x80\x82\x11\x15b\0\x15\x94W`\0\x80\xFD[Pb\0\x15\xA3\x84\x82\x85\x01b\0\x13\x9BV[`\xA0\x83\x01RPb\0\x15\xB7`\xC0\x83\x01b\0\x14\xEAV[`\xC0\x82\x01R\x92\x91PPV[`\0\x80`@\x83\x85\x03\x12\x15b\0\x15\xD6W`\0\x80\xFD[\x82Q`\x01`\x01`@\x1B\x03\x80\x82\x11\x15b\0\x15\xEEW`\0\x80\xFD[\x81\x85\x01\x91P\x85`\x1F\x83\x01\x12b\0\x16\x03W`\0\x80\xFD[\x81Q` b\0\x16\x16b\0\x13\x04\x83b\0\x12?V[\x82\x81R`\x05\x92\x90\x92\x1B\x84\x01\x81\x01\x91\x81\x81\x01\x90\x89\x84\x11\x15b\0\x166W`\0\x80\xFD[\x82\x86\x01[\x84\x81\x10\x15b\0\x17FW\x80Q\x86\x81\x11\x15b\0\x16SW`\0\x80\xFD[\x87\x01``\x81\x8D\x03`\x1F\x19\x01\x12\x15b\0\x16jW`\0\x80\xFD[b\0\x16tb\0\x11\xC2V[b\0\x16\x81\x86\x83\x01b\0\x12eV[\x81R`@\x82\x01Q`\x03\x81\x10b\0\x16\x96W`\0\x80\xFD[\x81\x87\x01R``\x82\x01Q\x88\x81\x11\x15b\0\x16\xADW`\0\x80\xFD[\x80\x83\x01\x92PP\x8C`?\x83\x01\x12b\0\x16\xC3W`\0\x80\xFD[\x85\x82\x01Qb\0\x16\xD6b\0\x13\x04\x82b\0\x12?V[\x81\x81R`\x05\x91\x90\x91\x1B\x83\x01`@\x01\x90\x87\x81\x01\x90\x8F\x83\x11\x15b\0\x16\xF7W`\0\x80\xFD[`@\x85\x01\x94P[\x82\x85\x10\x15b\0\x170W\x84Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x14b\0\x17 W`\0\x80\xFD[\x82R\x93\x88\x01\x93\x90\x88\x01\x90b\0\x16\xFEV[`@\x84\x01RPP\x84RP\x91\x83\x01\x91\x83\x01b\0\x16:V[P\x91\x88\x01Q\x91\x96P\x90\x93PPP\x80\x82\x11\x15b\0\x17aW`\0\x80\xFD[Pb\0\x17p\x85\x82\x86\x01b\0\x14\xFDV[\x91PP\x92P\x92\x90PV[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[`\x03\x81\x10b\0\x17\xC5WcNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[\x90RV[` \x81\x01b\0\x0Fd\x82\x84b\0\x17\xA6V[`\0\x81Q\x80\x84R` \x80\x85\x01\x94P\x80\x84\x01`\0[\x83\x81\x10\x15b\0\x18\x15W\x81Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x87R\x95\x82\x01\x95\x90\x82\x01\x90`\x01\x01b\0\x17\xEDV[P\x94\x95\x94PPPPPV[`\0\x81Q\x80\x84Rb\0\x18:\x81` \x86\x01` \x86\x01b\0\x13uV[`\x1F\x01`\x1F\x19\x16\x92\x90\x92\x01` \x01\x92\x91PPV[`\0``\x80\x83\x01\x81\x84R\x80\x87Q\x80\x83R`\x80\x86\x01\x91P`\x80\x81`\x05\x1B\x87\x01\x01\x92P` \x80\x8A\x01`\0[\x83\x81\x10\x15b\0\x18\xD9W\x88\x86\x03`\x7F\x19\x01\x85R\x81Q\x80Q`\x01`\x01`\xA0\x1B\x03\x16\x87R\x83\x81\x01Qb\0\x18\xAA\x85\x89\x01\x82b\0\x17\xA6V[P`@\x90\x81\x01Q\x90\x87\x01\x88\x90Rb\0\x18\xC5\x87\x89\x01\x82b\0\x17\xD9V[\x96PP\x93\x82\x01\x93\x90\x82\x01\x90`\x01\x01b\0\x18wV[PP`\x01`\x01`\xA0\x1B\x03\x89\x16\x90\x87\x01RPP\x83\x81\x03`@\x85\x01Rb\0\x18\xFF\x81\x86b\0\x18 V[\x97\x96PPPPPPPV[`\0\x81Q\x80\x84R` \x80\x85\x01\x80\x81\x96P\x83`\x05\x1B\x81\x01\x91P\x82\x86\x01`\0[\x85\x81\x10\x15b\0\x19\x7FW\x82\x84\x03\x89R\x81Q\x80Q\x85R\x85\x81\x01Q`\x01`\x01`\xA0\x1B\x03\x16\x86\x86\x01R`@\x90\x81\x01Q``\x91\x86\x01\x82\x90R\x90b\0\x19j\x81\x87\x01\x83b\0\x18 V[\x9A\x87\x01\x9A\x95PPP\x90\x84\x01\x90`\x01\x01b\0\x19(V[P\x91\x97\x96PPPPPPPV[` \x81R`\0\x82Q`@` \x84\x01Rb\0\x19\xAA``\x84\x01\x82b\0\x19\nV[` \x94\x90\x94\x01Q`\x01`\x01`@\x1B\x03\x16`@\x93\x90\x93\x01\x92\x90\x92RP\x90\x91\x90PV[`\x01\x81\x81\x1C\x90\x82\x16\x80b\0\x19\xE0W`\x7F\x82\x16\x91P[` \x82\x10\x81\x03b\0\x1A\x01WcNH{q`\xE0\x1B`\0R`\"`\x04R`$`\0\xFD[P\x91\x90PV[`\x1F\x82\x11\x15b\0\x0F\x95W`\0\x81\x81R` \x81 `\x1F\x85\x01`\x05\x1C\x81\x01` \x86\x10\x15b\0\x1A0WP\x80[`\x1F\x85\x01`\x05\x1C\x82\x01\x91P[\x81\x81\x10\x15b\0\t\x93W\x82\x81U`\x01\x01b\0\x1A<V[\x81Q`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x1AmWb\0\x1Amb\0\x11\x81V[b\0\x1A\x85\x81b\0\x1A~\x84Tb\0\x19\xCBV[\x84b\0\x1A\x07V[` \x80`\x1F\x83\x11`\x01\x81\x14b\0\x1A\xBDW`\0\x84\x15b\0\x1A\xA4WP\x85\x83\x01Q[`\0\x19`\x03\x86\x90\x1B\x1C\x19\x16`\x01\x85\x90\x1B\x17\x85Ub\0\t\x93V[`\0\x85\x81R` \x81 `\x1F\x19\x86\x16\x91[\x82\x81\x10\x15b\0\x1A\xEEW\x88\x86\x01Q\x82U\x94\x84\x01\x94`\x01\x90\x91\x01\x90\x84\x01b\0\x1A\xCDV[P\x85\x82\x10\x15b\0\x1B\rW\x87\x85\x01Q`\0\x19`\x03\x88\x90\x1B`\xF8\x16\x1C\x19\x16\x81U[PPPPP`\x01\x90\x81\x1B\x01\x90UPV[cNH{q`\xE0\x1B`\0R`1`\x04R`$`\0\xFD[` \x81R`\0b\0\x1BH` \x83\x01\x84b\0\x17\xD9V[\x93\x92PPPV[cNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[`\0a\xFF\xFF\x80\x83\x16\x81\x81\x03b\0\x1B\x7FWb\0\x1B\x7Fb\0\x1BOV[`\x01\x01\x93\x92PPPV[`\0\x81b\0\x1B\x9BWb\0\x1B\x9Bb\0\x1BOV[P`\0\x19\x01\x90V[`\0\x82Qb\0\x1B\xB7\x81\x84` \x87\x01b\0\x13uV[\x91\x90\x91\x01\x92\x91PPV[`\x01`\x01`\xA0\x1B\x03\x83\x16\x81R`@` \x82\x01\x81\x90R`\0\x90b\0\x1B\xE7\x90\x83\x01\x84b\0\x18 V[\x94\x93PPPPV[` \x81R`\0b\0\x1BH` \x83\x01\x84b\0\x19\nV[\x80\x82\x01\x80\x82\x11\x15b\0\x0FdWb\0\x0Fdb\0\x1BOV[\x81\x81\x03b\0\x1C&WPPV[b\0\x1C2\x82Tb\0\x19\xCBV[`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x1CLWb\0\x1CLb\0\x11\x81V[b\0\x1C]\x81b\0\x1A~\x84Tb\0\x19\xCBV[`\0`\x1F\x82\x11`\x01\x81\x14b\0\x1C\x94W`\0\x83\x15b\0\x1C{WP\x84\x82\x01T[`\0\x19`\x03\x85\x90\x1B\x1C\x19\x16`\x01\x84\x90\x1B\x17\x84Ub\0\x07\xD8V[`\0\x85\x81R` \x90 `\x1F\x19\x84\x16\x90`\0\x86\x81R` \x90 \x84[\x83\x81\x10\x15b\0\x1C\xD0W\x82\x86\x01T\x82U`\x01\x95\x86\x01\x95\x90\x91\x01\x90` \x01b\0\x1C\xAEV[P\x85\x83\x10\x15b\0\x1B\rW\x93\x01T`\0\x19`\xF8`\x03\x87\x90\x1B\x16\x1C\x19\x16\x90\x92UPP`\x01\x90\x81\x1B\x01\x90UPV[`\xE2\x80b\0\x1D\n`\09`\0\xF3\xFE`\x80`@R6`\x10W`\x0E`\x13V[\0[`\x0E[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` \x81\x90R`@\x90\x91 T\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80`\x89W`@Qc\n\x82\xDDs`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19`\x005\x16`\x04\x82\x01R`$\x01`@Q\x80\x91\x03\x90\xFD[6`\0\x807`\0\x806`\0\x84Z\xF4=`\0\x80>\x80\x80\x15`\xA7W=`\0\xF3[=`\0\xFD\xFE\xA2dipfsX\"\x12 4\xA8D-\xE68\xC5*\x8E\x8A@\xD2,yR\x91\0\xFC\xD0\x81\xA9\xDA\xE1\xBB\x1B\x8E\x92\xA5\xDB\xB0\x9A\xF9dsolcC\0\x08\x13\x003diamondCut: _init address has no code\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD3diamondCut: Add facet has no codeLibDiamondCut: Replace facet has no code\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2";
    /// The bytecode of the contract.
    pub static GATEWAYDIAMOND_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __BYTECODE,
    );
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@R6`\x10W`\x0E`\x13V[\0[`\x0E[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` \x81\x90R`@\x90\x91 T\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80`\x89W`@Qc\n\x82\xDDs`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19`\x005\x16`\x04\x82\x01R`$\x01`@Q\x80\x91\x03\x90\xFD[6`\0\x807`\0\x806`\0\x84Z\xF4=`\0\x80>\x80\x80\x15`\xA7W=`\0\xF3[=`\0\xFD\xFE\xA2dipfsX\"\x12 4\xA8D-\xE68\xC5*\x8E\x8A@\xD2,yR\x91\0\xFC\xD0\x81\xA9\xDA\xE1\xBB\x1B\x8E\x92\xA5\xDB\xB0\x9A\xF9dsolcC\0\x08\x13\x003";
    /// The deployed bytecode of the contract.
    pub static GATEWAYDIAMOND_DEPLOYED_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __DEPLOYED_BYTECODE,
    );
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
            Self(
                ::ethers::contract::Contract::new(
                    address.into(),
                    GATEWAYDIAMOND_ABI.clone(),
                    client,
                ),
            )
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
    for GatewayDiamond<M> {
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
        Hash
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
        Hash
    )]
    #[etherror(
        name = "CannotAddSelectorsToZeroAddress",
        abi = "CannotAddSelectorsToZeroAddress(bytes4[])"
    )]
    pub struct CannotAddSelectorsToZeroAddress {
        pub selectors: ::std::vec::Vec<[u8; 4]>,
    }
    ///Custom Error type `CannotRemoveFunctionThatDoesNotExist` with signature `CannotRemoveFunctionThatDoesNotExist(bytes4)` and selector `0x7a08a22d`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "CannotRemoveFunctionThatDoesNotExist",
        abi = "CannotRemoveFunctionThatDoesNotExist(bytes4)"
    )]
    pub struct CannotRemoveFunctionThatDoesNotExist {
        pub selector: [u8; 4],
    }
    ///Custom Error type `CannotRemoveImmutableFunction` with signature `CannotRemoveImmutableFunction(bytes4)` and selector `0x6fafeb08`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "CannotRemoveImmutableFunction",
        abi = "CannotRemoveImmutableFunction(bytes4)"
    )]
    pub struct CannotRemoveImmutableFunction {
        pub selector: [u8; 4],
    }
    ///Custom Error type `CannotReplaceFunctionThatDoesNotExists` with signature `CannotReplaceFunctionThatDoesNotExists(bytes4)` and selector `0x7479f939`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "CannotReplaceFunctionThatDoesNotExists",
        abi = "CannotReplaceFunctionThatDoesNotExists(bytes4)"
    )]
    pub struct CannotReplaceFunctionThatDoesNotExists {
        pub selector: [u8; 4],
    }
    ///Custom Error type `CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet` with signature `CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(bytes4)` and selector `0x358d9d1a`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet",
        abi = "CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(bytes4)"
    )]
    pub struct CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet {
        pub selector: [u8; 4],
    }
    ///Custom Error type `CannotReplaceFunctionsFromFacetWithZeroAddress` with signature `CannotReplaceFunctionsFromFacetWithZeroAddress(bytes4[])` and selector `0xcd98a96f`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "CannotReplaceFunctionsFromFacetWithZeroAddress",
        abi = "CannotReplaceFunctionsFromFacetWithZeroAddress(bytes4[])"
    )]
    pub struct CannotReplaceFunctionsFromFacetWithZeroAddress {
        pub selectors: ::std::vec::Vec<[u8; 4]>,
    }
    ///Custom Error type `CannotReplaceImmutableFunction` with signature `CannotReplaceImmutableFunction(bytes4)` and selector `0x520300da`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "CannotReplaceImmutableFunction",
        abi = "CannotReplaceImmutableFunction(bytes4)"
    )]
    pub struct CannotReplaceImmutableFunction {
        pub selector: [u8; 4],
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
        Hash
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
        Hash
    )]
    #[etherror(name = "IncorrectFacetCutAction", abi = "IncorrectFacetCutAction(uint8)")]
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
        Hash
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
        Hash
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
        Hash
    )]
    #[etherror(name = "InvalidMajorityPercentage", abi = "InvalidMajorityPercentage()")]
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
        Hash
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
        Hash
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
        Hash
    )]
    #[etherror(
        name = "NoSelectorsProvidedForFacetForCut",
        abi = "NoSelectorsProvidedForFacetForCut(address)"
    )]
    pub struct NoSelectorsProvidedForFacetForCut {
        pub facet_address: ::ethers::core::types::Address,
    }
    ///Custom Error type `OldConfigurationNumber` with signature `OldConfigurationNumber()` and selector `0x6e8d7c4a`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(name = "OldConfigurationNumber", abi = "OldConfigurationNumber()")]
    pub struct OldConfigurationNumber;
    ///Custom Error type `RemoveFacetAddressMustBeZeroAddress` with signature `RemoveFacetAddressMustBeZeroAddress(address)` and selector `0xd091bc81`
    #[derive(
        Clone,
        ::ethers::contract::EthError,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[etherror(
        name = "RemoveFacetAddressMustBeZeroAddress",
        abi = "RemoveFacetAddressMustBeZeroAddress(address)"
    )]
    pub struct RemoveFacetAddressMustBeZeroAddress {
        pub facet_address: ::ethers::core::types::Address,
    }
    ///Container type for all of the contract's custom errors
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum GatewayDiamondErrors {
        CannotAddFunctionToDiamondThatAlreadyExists(
            CannotAddFunctionToDiamondThatAlreadyExists,
        ),
        CannotAddSelectorsToZeroAddress(CannotAddSelectorsToZeroAddress),
        CannotRemoveFunctionThatDoesNotExist(CannotRemoveFunctionThatDoesNotExist),
        CannotRemoveImmutableFunction(CannotRemoveImmutableFunction),
        CannotReplaceFunctionThatDoesNotExists(CannotReplaceFunctionThatDoesNotExists),
        CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(
            CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet,
        ),
        CannotReplaceFunctionsFromFacetWithZeroAddress(
            CannotReplaceFunctionsFromFacetWithZeroAddress,
        ),
        CannotReplaceImmutableFunction(CannotReplaceImmutableFunction),
        FunctionNotFound(FunctionNotFound),
        IncorrectFacetCutAction(IncorrectFacetCutAction),
        InitializationFunctionReverted(InitializationFunctionReverted),
        InvalidCollateral(InvalidCollateral),
        InvalidMajorityPercentage(InvalidMajorityPercentage),
        InvalidSubmissionPeriod(InvalidSubmissionPeriod),
        NoBytecodeAtAddress(NoBytecodeAtAddress),
        NoSelectorsProvidedForFacetForCut(NoSelectorsProvidedForFacetForCut),
        OldConfigurationNumber(OldConfigurationNumber),
        RemoveFacetAddressMustBeZeroAddress(RemoveFacetAddressMustBeZeroAddress),
        /// The standard solidity revert string, with selector
        /// Error(string) -- 0x08c379a0
        RevertString(::std::string::String),
    }
    impl ::ethers::core::abi::AbiDecode for GatewayDiamondErrors {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) = <::std::string::String as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::RevertString(decoded));
            }
            if let Ok(decoded) = <CannotAddFunctionToDiamondThatAlreadyExists as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotAddFunctionToDiamondThatAlreadyExists(decoded));
            }
            if let Ok(decoded) = <CannotAddSelectorsToZeroAddress as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotAddSelectorsToZeroAddress(decoded));
            }
            if let Ok(decoded) = <CannotRemoveFunctionThatDoesNotExist as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotRemoveFunctionThatDoesNotExist(decoded));
            }
            if let Ok(decoded) = <CannotRemoveImmutableFunction as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotRemoveImmutableFunction(decoded));
            }
            if let Ok(decoded) = <CannotReplaceFunctionThatDoesNotExists as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotReplaceFunctionThatDoesNotExists(decoded));
            }
            if let Ok(decoded) = <CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(
                    Self::CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(
                        decoded,
                    ),
                );
            }
            if let Ok(decoded) = <CannotReplaceFunctionsFromFacetWithZeroAddress as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotReplaceFunctionsFromFacetWithZeroAddress(decoded));
            }
            if let Ok(decoded) = <CannotReplaceImmutableFunction as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotReplaceImmutableFunction(decoded));
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
                return Ok(Self::NoSelectorsProvidedForFacetForCut(decoded));
            }
            if let Ok(decoded) = <OldConfigurationNumber as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::OldConfigurationNumber(decoded));
            }
            if let Ok(decoded) = <RemoveFacetAddressMustBeZeroAddress as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::RemoveFacetAddressMustBeZeroAddress(decoded));
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
                Self::CannotRemoveFunctionThatDoesNotExist(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CannotRemoveImmutableFunction(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CannotReplaceFunctionThatDoesNotExists(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(
                    element,
                ) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::CannotReplaceFunctionsFromFacetWithZeroAddress(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::CannotReplaceImmutableFunction(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::FunctionNotFound(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::IncorrectFacetCutAction(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InitializationFunctionReverted(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InvalidCollateral(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
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
                Self::OldConfigurationNumber(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::RemoveFacetAddressMustBeZeroAddress(element) => {
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
                    == <CannotRemoveFunctionThatDoesNotExist as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CannotRemoveImmutableFunction as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CannotReplaceFunctionThatDoesNotExists as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CannotReplaceFunctionsFromFacetWithZeroAddress as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <CannotReplaceImmutableFunction as ::ethers::contract::EthError>::selector() => {
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
                _ if selector
                    == <OldConfigurationNumber as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <RemoveFacetAddressMustBeZeroAddress as ::ethers::contract::EthError>::selector() => {
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
                Self::CannotRemoveFunctionThatDoesNotExist(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::CannotRemoveImmutableFunction(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::CannotReplaceFunctionThatDoesNotExists(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(
                    element,
                ) => ::core::fmt::Display::fmt(element, f),
                Self::CannotReplaceFunctionsFromFacetWithZeroAddress(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::CannotReplaceImmutableFunction(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::FunctionNotFound(element) => ::core::fmt::Display::fmt(element, f),
                Self::IncorrectFacetCutAction(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InitializationFunctionReverted(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidCollateral(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidMajorityPercentage(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidSubmissionPeriod(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::NoBytecodeAtAddress(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::NoSelectorsProvidedForFacetForCut(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::OldConfigurationNumber(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::RemoveFacetAddressMustBeZeroAddress(element) => {
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
    impl ::core::convert::From<CannotAddFunctionToDiamondThatAlreadyExists>
    for GatewayDiamondErrors {
        fn from(value: CannotAddFunctionToDiamondThatAlreadyExists) -> Self {
            Self::CannotAddFunctionToDiamondThatAlreadyExists(value)
        }
    }
    impl ::core::convert::From<CannotAddSelectorsToZeroAddress>
    for GatewayDiamondErrors {
        fn from(value: CannotAddSelectorsToZeroAddress) -> Self {
            Self::CannotAddSelectorsToZeroAddress(value)
        }
    }
    impl ::core::convert::From<CannotRemoveFunctionThatDoesNotExist>
    for GatewayDiamondErrors {
        fn from(value: CannotRemoveFunctionThatDoesNotExist) -> Self {
            Self::CannotRemoveFunctionThatDoesNotExist(value)
        }
    }
    impl ::core::convert::From<CannotRemoveImmutableFunction> for GatewayDiamondErrors {
        fn from(value: CannotRemoveImmutableFunction) -> Self {
            Self::CannotRemoveImmutableFunction(value)
        }
    }
    impl ::core::convert::From<CannotReplaceFunctionThatDoesNotExists>
    for GatewayDiamondErrors {
        fn from(value: CannotReplaceFunctionThatDoesNotExists) -> Self {
            Self::CannotReplaceFunctionThatDoesNotExists(value)
        }
    }
    impl ::core::convert::From<CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet>
    for GatewayDiamondErrors {
        fn from(
            value: CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet,
        ) -> Self {
            Self::CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(value)
        }
    }
    impl ::core::convert::From<CannotReplaceFunctionsFromFacetWithZeroAddress>
    for GatewayDiamondErrors {
        fn from(value: CannotReplaceFunctionsFromFacetWithZeroAddress) -> Self {
            Self::CannotReplaceFunctionsFromFacetWithZeroAddress(value)
        }
    }
    impl ::core::convert::From<CannotReplaceImmutableFunction> for GatewayDiamondErrors {
        fn from(value: CannotReplaceImmutableFunction) -> Self {
            Self::CannotReplaceImmutableFunction(value)
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
    impl ::core::convert::From<NoSelectorsProvidedForFacetForCut>
    for GatewayDiamondErrors {
        fn from(value: NoSelectorsProvidedForFacetForCut) -> Self {
            Self::NoSelectorsProvidedForFacetForCut(value)
        }
    }
    impl ::core::convert::From<OldConfigurationNumber> for GatewayDiamondErrors {
        fn from(value: OldConfigurationNumber) -> Self {
            Self::OldConfigurationNumber(value)
        }
    }
    impl ::core::convert::From<RemoveFacetAddressMustBeZeroAddress>
    for GatewayDiamondErrors {
        fn from(value: RemoveFacetAddressMustBeZeroAddress) -> Self {
            Self::RemoveFacetAddressMustBeZeroAddress(value)
        }
    }
}
