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
                                ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                ::ethers::core::abi::ethabi::ParamType::Array(
                                    ::std::boxed::Box::new(
                                        ::ethers::core::abi::ethabi::ParamType::Tuple(
                                            ::std::vec![
                                                ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                                ::ethers::core::abi::ethabi::ParamType::Tuple(
                                                    ::std::vec![
                                                        ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                                                        ::ethers::core::abi::ethabi::ParamType::Bytes,
                                                    ],
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
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
                    ::std::borrow::ToOwned::to_owned("ValidatorWeightIsZero"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "ValidatorWeightIsZero",
                            ),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned(
                        "ValidatorsAndWeightsLengthMismatch",
                    ),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned(
                                "ValidatorsAndWeightsLengthMismatch",
                            ),
                            inputs: ::std::vec![],
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
    const __BYTECODE: &[u8] = b"`\x80`@R4\x80\x15b\0\0\x11W`\0\x80\xFD[P`@Qb\0!\x968\x03\x80b\0!\x96\x839\x81\x01`@\x81\x90Rb\0\x004\x91b\0\x18GV[\x80``\x01Q`\0\x03b\0\0ZW`@Qch\xF7\xA6u`\xE1\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x80` \x01Q`\x01`\x01`@\x1B\x03\x16`\0\x03b\0\0\x89W`@Qc1/\x8E\x05`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[`3\x81`\xA0\x01Q`\xFF\x16\x10\x80b\0\0\xA7WP`d\x81`\xA0\x01Q`\xFF\x16\x11[\x15b\0\0\xC6W`@Qcu\xC3\xB4'`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5\x80T`\x01`\x01`\xA0\x1B\x03\x19\x163\x17\x90U`@\x80Q`\0\x80\x82R` \x82\x01\x90\x92Rb\0\x01\x14\x91\x84\x91b\0\x03WV[\x80Q\x80Q`\x15\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x81U` \x80\x83\x01Q\x80Qb\0\x01O\x92`\x16\x92\x01\x90b\0\x127V[PPP``\x81\x01Q`\x17U` \x81\x01Q`\x1A\x80T`\x01`\x01`@\x1B\x03\x92\x83\x16h\x01\0\0\0\0\0\0\0\0\x02`\x01`@\x1B`\x01`\x80\x1B\x03\x19\x90\x91\x16\x17\x90U`@\x82\x01Q`\x19\x80T`\x80\x85\x01Q`\x18U`\xA0\x85\x01Q`\xFF\x16`\xFF\x19\x93\x85\x16`\x01`\x88\x1B\x02\x93\x90\x93\x16`\xFF`\x01`\x88\x1B\x03`\x01`\xC8\x1B\x03\x19\x90\x91\x16\x17\x91\x90\x91\x17\x90U`\x0F\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01\x17\x90U`\xC0\x82\x01QQ\x90`\0\x90\x82\x90\x81\x11\x15b\0\x01\xFEWb\0\x01\xFEb\0\x13\xE3V[`@Q\x90\x80\x82R\x80` \x02` \x01\x82\x01`@R\x80\x15b\0\x02FW\x81` \x01[`@\x80Q\x80\x82\x01\x90\x91R`\0\x81R``` \x82\x01R\x81R` \x01\x90`\x01\x90\x03\x90\x81b\0\x02\x1DW\x90P[P\x90P`\0\x82`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x02fWb\0\x02fb\0\x13\xE3V[`@Q\x90\x80\x82R\x80` \x02` \x01\x82\x01`@R\x80\x15b\0\x02\x90W\x81` \x01` \x82\x02\x806\x837\x01\x90P[P\x90P`\0[\x83\x81\x10\x15b\0\x032W\x84`\xC0\x01Q\x81\x81Q\x81\x10b\0\x02\xB8Wb\0\x02\xB8b\0\x19\xFFV[` \x02` \x01\x01Q` \x01Q\x83\x82\x81Q\x81\x10b\0\x02\xD9Wb\0\x02\xD9b\0\x19\xFFV[` \x02` \x01\x01\x81\x90RP\x84`\xC0\x01Q\x81\x81Q\x81\x10b\0\x02\xFDWb\0\x02\xFDb\0\x19\xFFV[` \x02` \x01\x01Q`\0\x01Q\x82\x82\x81Q\x81\x10b\0\x03\x1EWb\0\x03\x1Eb\0\x19\xFFV[` \x90\x81\x02\x91\x90\x91\x01\x01R`\x01\x01b\0\x02\x96V[Pb\0\x03A`\0\x83\x83b\0\x04\xC6V[b\0\x03Kb\0\x07jV[PPPPPPb\0 _V[\x82Q`\0[\x81\x81\x10\x15b\0\x04vW`\0\x85\x82\x81Q\x81\x10b\0\x03|Wb\0\x03|b\0\x19\xFFV[` \x02` \x01\x01Q`@\x01Q\x90P`\0\x86\x83\x81Q\x81\x10b\0\x03\xA1Wb\0\x03\xA1b\0\x19\xFFV[` \x02` \x01\x01Q`\0\x01Q\x90P\x81Q`\0\x03b\0\x03\xE2W`@Qc\xE7g\xF9\x1F`\xE0\x1B\x81R`\x01`\x01`\xA0\x1B\x03\x82\x16`\x04\x82\x01R`$\x01[`@Q\x80\x91\x03\x90\xFD[`\0\x87\x84\x81Q\x81\x10b\0\x03\xF9Wb\0\x03\xF9b\0\x19\xFFV[` \x02` \x01\x01Q` \x01Q\x90P`\0`\x02\x81\x11\x15b\0\x04\x1DWb\0\x04\x1Db\0\x1A\x15V[\x81`\x02\x81\x11\x15b\0\x042Wb\0\x042b\0\x1A\x15V[\x03b\0\x04JWb\0\x04D\x82\x84b\0\rgV[b\0\x04gV[\x80`@Qc?\xF4\xD2\x0F`\xE1\x1B\x81R`\x04\x01b\0\x03\xD9\x91\x90b\0\x1ANV[\x83`\x01\x01\x93PPPPb\0\x03\\V[P\x7F\x8F\xAAp\x87\x86q\xCC\xD2\x12\xD2\x07q\xB7\x95\xC5\n\xF8\xFD?\xF6\xCF'\xF4\xBD\xE5~]M\xE0\xAE\xB6s\x84\x84\x84`@Qb\0\x04\xAC\x93\x92\x91\x90b\0\x1A\xD3V[`@Q\x80\x91\x03\x90\xA1b\0\x04\xC0\x83\x83b\0\x0FEV[PPPPV[\x7F#qD8\x80\xFA\xCD\xDA\xC9\n+'h\r8\x15'\xA6ps\xAD\xFE\x98Q,\xAC\x1B\x9DhaB\x8C\x83\x83\x83`@Qb\0\x04\xFB\x93\x92\x91\x90b\0\x1B\xBBV[`@Q\x80\x91\x03\x90\xA1\x80Q\x82Q\x14b\0\x05&W`@QcF_\n}`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[`\0`\x01`\x01`@\x1B\x03\x84\x16\x15\x80b\0\x05NWP`\n\x81\x01T`\x01`\x01`@\x1B\x03\x85\x81\x16\x91\x16\x14[\x15b\0\x05ZWPPPPV[`\n\x81\x01T`\x01`\x01`@\x1B\x03\x90\x81\x16\x90\x85\x16\x10\x15b\0\x05\x8DW`@Qc7F\xBE%`\xE1\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[\x82Q`\n\x82\x01\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x87\x16\x17\x90U`\0b\0\x05\xBD`\t\x84\x01\x82b\0\x12\xA1V[`\0b\0\x05\xCA\x81b\0\x10\x17V[\x90P`\0[\x83\x81\x10\x15b\0\x07YWb\0\x06\x06\x87\x82\x81Q\x81\x10b\0\x05\xF1Wb\0\x05\xF1b\0\x19\xFFV[` \x02` \x01\x01Q\x83b\0\x10\xC3` \x1B` \x1CV[b\0\x07PW`\0\x86\x82\x81Q\x81\x10b\0\x06\"Wb\0\x06\"b\0\x19\xFFV[` \x02` \x01\x01Q\x90P\x80`\0\x03b\0\x06NW`@Qc8\x9BE}`\xE0\x1B\x81R`\x04\x01`@Q\x80\x91\x03\x90\xFD[`\x01`\x01`@\x1B\x03\x89\x16`\0\x90\x81R`\x05\x87\x01` R`@\x81 \x89Q\x83\x92\x90b\0\x06\x9B\x90\x8C\x90\x87\x90\x81\x10b\0\x06\x87Wb\0\x06\x87b\0\x19\xFFV[` \x02` \x01\x01Qb\0\x11\x13` \x1B` \x1CV[\x81R` \x01\x90\x81R` \x01`\0 \x81\x90UP\x85`\t\x01`\0\x01`@Q\x80`@\x01`@R\x80\x83\x81R` \x01\x8A\x85\x81Q\x81\x10b\0\x06\xDAWb\0\x06\xDAb\0\x19\xFFV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q\x90\x91R\x82T`\x01\x80\x82\x01\x85U`\0\x94\x85R\x93\x82\x90 \x83Q`\x03\x90\x92\x02\x01\x90\x81U\x82\x82\x01Q\x80Q\x94\x82\x01\x80T`\xFF\x19\x16`\xFF\x90\x96\x16\x95\x90\x95\x17\x85U\x91\x82\x01Q\x92\x93\x90\x92`\x02\x84\x01\x90b\0\x079\x90\x82b\0\x1C\xF0V[PPPPP\x80\x84b\0\x07L\x91\x90b\0\x1D\xD2V[\x93PP[`\x01\x01b\0\x05\xCFV[PP`\x0B\x90\x92\x01\x91\x90\x91UPPPPV[b\0\x07\x98`@Q\x80``\x01`@R\x80``\x81R` \x01`\0`\x01`\x01`@\x1B\x03\x16\x81R` \x01`\0\x81RP\x90V[`@\x80Q`\x06\x80T`\x80` \x82\x02\x84\x01\x81\x01\x90\x94R``\x83\x01\x81\x81R`\0\x94b\0\n4\x94\x93\x92\x84\x92\x91\x84\x91\x90\x88\x90\x85\x01[\x82\x82\x10\x15b\0\x08\xBEW`\0\x84\x81R` \x90\x81\x90 `@\x80Q\x80\x82\x01\x82R`\x03\x86\x02\x90\x92\x01\x80T\x83R\x81Q\x80\x83\x01\x90\x92R`\x01\x81\x01\x80T`\xFF\x16\x83R`\x02\x82\x01\x80T\x94\x95\x92\x94\x86\x84\x01\x94\x93\x84\x01\x91\x90b\0\x08\"\x90b\0\x1CjV[\x80`\x1F\x01` \x80\x91\x04\x02` \x01`@Q\x90\x81\x01`@R\x80\x92\x91\x90\x81\x81R` \x01\x82\x80Tb\0\x08P\x90b\0\x1CjV[\x80\x15b\0\x08\xA1W\x80`\x1F\x10b\0\x08uWa\x01\0\x80\x83T\x04\x02\x83R\x91` \x01\x91b\0\x08\xA1V[\x82\x01\x91\x90`\0R` `\0 \x90[\x81T\x81R\x90`\x01\x01\x90` \x01\x80\x83\x11b\0\x08\x83W\x82\x90\x03`\x1F\x16\x82\x01\x91[PPPPP\x81RPP\x81RPP\x81R` \x01\x90`\x01\x01\x90b\0\x07\xC9V[PPP\x90\x82RP`\x01\x82\x01T`\x01`\x01`@\x1B\x03\x16` \x80\x83\x01\x91\x90\x91R`\x02\x90\x92\x01T`@\x91\x82\x01R\x80Q`\t\x86\x01\x80T`\x80\x94\x81\x02\x83\x01\x85\x01\x90\x93R``\x82\x01\x83\x81R\x91\x93\x90\x92\x84\x92\x91\x84\x91\x90`\0\x90\x85\x01[\x82\x82\x10\x15b\0\n\x08W`\0\x84\x81R` \x90\x81\x90 `@\x80Q\x80\x82\x01\x82R`\x03\x86\x02\x90\x92\x01\x80T\x83R\x81Q\x80\x83\x01\x90\x92R`\x01\x81\x01\x80T`\xFF\x16\x83R`\x02\x82\x01\x80T\x94\x95\x92\x94\x86\x84\x01\x94\x93\x84\x01\x91\x90b\0\tl\x90b\0\x1CjV[\x80`\x1F\x01` \x80\x91\x04\x02` \x01`@Q\x90\x81\x01`@R\x80\x92\x91\x90\x81\x81R` \x01\x82\x80Tb\0\t\x9A\x90b\0\x1CjV[\x80\x15b\0\t\xEBW\x80`\x1F\x10b\0\t\xBFWa\x01\0\x80\x83T\x04\x02\x83R\x91` \x01\x91b\0\t\xEBV[\x82\x01\x91\x90`\0R` `\0 \x90[\x81T\x81R\x90`\x01\x01\x90` \x01\x80\x83\x11b\0\t\xCDW\x82\x90\x03`\x1F\x16\x82\x01\x91[PPPPP\x81RPP\x81RPP\x81R` \x01\x90`\x01\x01\x90b\0\t\x13V[PPP\x90\x82RP`\x01\x82\x01T`\x01`\x01`@\x1B\x03\x16` \x82\x01R`\x02\x90\x91\x01T`@\x90\x91\x01Rb\0\x11EV[\x15b\0\x0B\x89W`@\x80Q`\x06\x83\x01\x80T`\x80` \x82\x02\x84\x01\x81\x01\x90\x94R``\x83\x01\x81\x81R\x92\x93\x91\x92\x84\x92\x90\x91\x84\x91`\0\x90\x85\x01[\x82\x82\x10\x15b\0\x0B]W`\0\x84\x81R` \x90\x81\x90 `@\x80Q\x80\x82\x01\x82R`\x03\x86\x02\x90\x92\x01\x80T\x83R\x81Q\x80\x83\x01\x90\x92R`\x01\x81\x01\x80T`\xFF\x16\x83R`\x02\x82\x01\x80T\x94\x95\x92\x94\x86\x84\x01\x94\x93\x84\x01\x91\x90b\0\n\xC1\x90b\0\x1CjV[\x80`\x1F\x01` \x80\x91\x04\x02` \x01`@Q\x90\x81\x01`@R\x80\x92\x91\x90\x81\x81R` \x01\x82\x80Tb\0\n\xEF\x90b\0\x1CjV[\x80\x15b\0\x0B@W\x80`\x1F\x10b\0\x0B\x14Wa\x01\0\x80\x83T\x04\x02\x83R\x91` \x01\x91b\0\x0B@V[\x82\x01\x91\x90`\0R` `\0 \x90[\x81T\x81R\x90`\x01\x01\x90` \x01\x80\x83\x11b\0\x0B\"W\x82\x90\x03`\x1F\x16\x82\x01\x91[PPPPP\x81RPP\x81RPP\x81R` \x01\x90`\x01\x01\x90b\0\nhV[PPP\x90\x82RP`\x01\x82\x01T`\x01`\x01`@\x1B\x03\x16` \x82\x01R`\x02\x90\x91\x01T`@\x90\x91\x01R\x92\x91PPV[`\t\x81\x01\x80T`\x06\x83\x01\x90b\0\x0B\xA3\x90\x82\x90\x84\x90b\0\x12\xC7V[P`\x01\x82\x81\x01T\x90\x82\x01\x80T`\x01`\x01`@\x1B\x03\x19\x16`\x01`\x01`@\x1B\x03\x90\x92\x16\x91\x90\x91\x17\x90U`\x02\x91\x82\x01T\x91\x01U`@\x80Q`\x06\x83\x01\x80T`\x80` \x82\x02\x84\x01\x81\x01\x90\x94R``\x83\x01\x81\x81R`\0\x94\x84\x92\x84\x91\x87\x90\x85\x01[\x82\x82\x10\x15b\0\x0C\xF2W`\0\x84\x81R` \x90\x81\x90 `@\x80Q\x80\x82\x01\x82R`\x03\x86\x02\x90\x92\x01\x80T\x83R\x81Q\x80\x83\x01\x90\x92R`\x01\x81\x01\x80T`\xFF\x16\x83R`\x02\x82\x01\x80T\x94\x95\x92\x94\x86\x84\x01\x94\x93\x84\x01\x91\x90b\0\x0CV\x90b\0\x1CjV[\x80`\x1F\x01` \x80\x91\x04\x02` \x01`@Q\x90\x81\x01`@R\x80\x92\x91\x90\x81\x81R` \x01\x82\x80Tb\0\x0C\x84\x90b\0\x1CjV[\x80\x15b\0\x0C\xD5W\x80`\x1F\x10b\0\x0C\xA9Wa\x01\0\x80\x83T\x04\x02\x83R\x91` \x01\x91b\0\x0C\xD5V[\x82\x01\x91\x90`\0R` `\0 \x90[\x81T\x81R\x90`\x01\x01\x90` \x01\x80\x83\x11b\0\x0C\xB7W\x82\x90\x03`\x1F\x16\x82\x01\x91[PPPPP\x81RPP\x81RPP\x81R` \x01\x90`\x01\x01\x90b\0\x0B\xFDV[PPP\x90\x82RP`\x01\x82\x01T`\x01`\x01`@\x1B\x03\x16` \x80\x83\x01\x91\x90\x91R`\x02\x90\x92\x01T`@\x91\x82\x01R\x90\x82\x01Q\x82Q\x83\x83\x01Q\x92Q\x93\x94P\x7F1\x17\x1D\tv\x8D\xF3\xAF2y\x8D\xB5\x1B\x92Y\xE0Yb\xA1\x8C\x15i\\\xBES\xF8\x82\xF2\xED.\x19W\x93b\0\rY\x93\x90b\0\x1EUV[`@Q\x80\x91\x03\x90\xA1\x92\x91PPV[`\x01`\x01`\xA0\x1B\x03\x82\x16b\0\r\x93W\x80`@Qc\x02\xB8\xDA\x07`\xE2\x1B\x81R`\x04\x01b\0\x03\xD9\x91\x90b\0\x1E\x8BV[\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD3T`@\x80Q``\x81\x01\x90\x91R`!\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2\x92\x91b\0\r\xFF\x91\x86\x91\x90b\0!u` \x83\x019b\0\x12\x07V[\x82Q`\0[\x81\x81\x10\x15b\0\x0F=W`\0\x85\x82\x81Q\x81\x10b\0\x0E$Wb\0\x0E$b\0\x19\xFFV[` \x90\x81\x02\x91\x90\x91\x01\x81\x01Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R\x91\x87\x90R`@\x90\x91 T\x90\x91P`\x01`\x01`\xA0\x1B\x03\x16\x80\x15b\0\x0E\x83W`@Qc\xEB\xBF]\x07`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x83\x16`\x04\x82\x01R`$\x01b\0\x03\xD9V[`@\x80Q\x80\x82\x01\x82R`\x01`\x01`\xA0\x1B\x03\x80\x8B\x16\x82Ra\xFF\xFF\x80\x89\x16` \x80\x85\x01\x91\x82R`\x01`\x01`\xE0\x1B\x03\x19\x88\x16`\0\x90\x81R\x8C\x82R\x95\x86 \x94Q\x85T\x92Q\x90\x93\x16`\x01`\xA0\x1B\x02`\x01`\x01`\xB0\x1B\x03\x19\x90\x92\x16\x92\x90\x93\x16\x91\x90\x91\x17\x17\x90\x91U`\x01\x80\x89\x01\x80T\x91\x82\x01\x81U\x83R\x91 `\x08\x82\x04\x01\x80T`\xE0\x85\x90\x1C`\x04`\x07\x90\x94\x16\x93\x90\x93\x02a\x01\0\n\x92\x83\x02c\xFF\xFF\xFF\xFF\x90\x93\x02\x19\x16\x91\x90\x91\x17\x90Ub\0\x0F-\x85b\0\x1E\xA0V[\x94P\x82`\x01\x01\x92PPPb\0\x0E\x04V[PPPPPPV[`\x01`\x01`\xA0\x1B\x03\x82\x16b\0\x0FXWPPV[b\0\x0F}\x82`@Q\x80``\x01`@R\x80`%\x81R` \x01b\0!P`%\x919b\0\x12\x07V[`\0\x80\x83`\x01`\x01`\xA0\x1B\x03\x16\x83`@Qb\0\x0F\x9A\x91\x90b\0\x1E\xC4V[`\0`@Q\x80\x83\x03\x81\x85Z\xF4\x91PP=\x80`\0\x81\x14b\0\x0F\xD7W`@Q\x91P`\x1F\x19`?=\x01\x16\x82\x01`@R=\x82R=`\0` \x84\x01>b\0\x0F\xDCV[``\x91P[P\x91P\x91P\x81b\0\x04\xC0W\x80Q\x15b\0\x0F\xF8W\x80Q\x80\x82` \x01\xFD[\x83\x83`@Qc\x19!\x05\xD7`\xE0\x1B\x81R`\x04\x01b\0\x03\xD9\x92\x91\x90b\0\x1E\xE2V[`@\x80Q\x80\x82\x01\x90\x91R`\0\x81R``` \x82\x01R`\0`@Q\x80``\x01`@R\x80`\n`\x01`\x01`@\x1B\x03\x16\x81R` \x01`\x14`\x01`\x01`\x80\x1B\x03\x16\x81R` \x01\x84`@Q` \x01b\0\x10~\x91\x90``\x91\x90\x91\x1B`\x01`\x01``\x1B\x03\x19\x16\x81R`\x14\x01\x90V[`@\x80Q`\x1F\x19\x81\x84\x03\x01\x81R\x91\x81R\x91RQb\0\x10\xA0\x91\x90` \x01b\0\x1F\x08V[`@\x80Q`\x1F\x19\x81\x84\x03\x01\x81R\x82\x82\x01\x90\x91R`\x04\x82R` \x82\x01R\x93\x92PPPV[\x80Q\x82Q`\0\x91`\xFF\x91\x82\x16\x91\x16\x14\x80\x15b\0\x10\xE8WP\x81` \x01QQ\x83` \x01QQ\x14[\x80\x15b\0\x11\nWP\x81` \x01Q\x80Q\x90` \x01 \x83` \x01Q\x80Q\x90` \x01 \x14[\x90P[\x92\x91PPV[`\0\x81`@Q` \x01b\0\x11(\x91\x90b\0\x1FLV[`@Q` \x81\x83\x03\x03\x81R\x90`@R\x80Q\x90` \x01 \x90P\x91\x90PV[`\0\x81` \x01Q`\x01`\x01`@\x1B\x03\x16\x83` \x01Q`\x01`\x01`@\x1B\x03\x16\x14b\0\x11rWP`\0b\0\x11\rV[\x81`@\x01Q\x83`@\x01Q\x14b\0\x11\x8BWP`\0b\0\x11\rV[\x81QQ\x83QQ\x14b\0\x11\xA0WP`\0b\0\x11\rV[\x82Q`@Q`\0\x91b\0\x11\xB6\x91` \x01b\0\x1FaV[`@\x80Q`\x1F\x19\x81\x84\x03\x01\x81R\x90\x82\x90R\x80Q` \x91\x82\x01 \x85Q\x90\x93P`\0\x92b\0\x11\xE3\x92\x01b\0\x1FaV[`@\x80Q`\x1F\x19\x81\x84\x03\x01\x81R\x91\x90R\x80Q` \x90\x91\x01 \x91\x90\x91\x14\x94\x93PPPPV[\x81;`\0\x81\x90\x03b\0\x122W\x82\x82`@Qc\x91\x984\xB9`\xE0\x1B\x81R`\x04\x01b\0\x03\xD9\x92\x91\x90b\0\x1E\xE2V[PPPV[\x82\x80T\x82\x82U\x90`\0R` `\0 \x90\x81\x01\x92\x82\x15b\0\x12\x8FW\x91` \x02\x82\x01[\x82\x81\x11\x15b\0\x12\x8FW\x82Q\x82T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x17\x82U` \x90\x92\x01\x91`\x01\x90\x91\x01\x90b\0\x12XV[Pb\0\x12\x9D\x92\x91Pb\0\x13WV[P\x90V[P\x80T`\0\x82U`\x03\x02\x90`\0R` `\0 \x90\x81\x01\x90b\0\x12\xC4\x91\x90b\0\x13nV[PV[\x82\x80T\x82\x82U\x90`\0R` `\0 \x90`\x03\x02\x81\x01\x92\x82\x15b\0\x13IW`\0R` `\0 \x91`\x03\x02\x82\x01[\x82\x81\x11\x15b\0\x13IW\x82T\x82U`\x01\x80\x84\x01\x80T\x91\x84\x01\x80T`\xFF\x19\x16`\xFF\x90\x93\x16\x92\x90\x92\x17\x82U\x84\x91\x84\x91\x90`\x02\x80\x84\x01\x90b\0\x134\x90\x86\x01\x82b\0\x1FvV[PPPPP\x91`\x03\x01\x91\x90`\x03\x01\x90b\0\x12\xF3V[Pb\0\x12\x9D\x92\x91Pb\0\x13nV[[\x80\x82\x11\x15b\0\x12\x9DW`\0\x81U`\x01\x01b\0\x13XV[\x80\x82\x11\x15b\0\x12\x9DW`\0\x80\x82U`\x01\x82\x01\x80T`\xFF\x19\x16\x81U\x81b\0\x13\x98`\x02\x85\x01\x82b\0\x13\xA4V[PPP`\x03\x01b\0\x13nV[P\x80Tb\0\x13\xB2\x90b\0\x1CjV[`\0\x82U\x80`\x1F\x10b\0\x13\xC3WPPV[`\x1F\x01` \x90\x04\x90`\0R` `\0 \x90\x81\x01\x90b\0\x12\xC4\x91\x90b\0\x13WV[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[`@\x80Q\x90\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x14\x1EWb\0\x14\x1Eb\0\x13\xE3V[`@R\x90V[`@Q`\xE0\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x14\x1EWb\0\x14\x1Eb\0\x13\xE3V[`@Q``\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x14\x1EWb\0\x14\x1Eb\0\x13\xE3V[`@Q`\x1F\x82\x01`\x1F\x19\x16\x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17\x15b\0\x14\x99Wb\0\x14\x99b\0\x13\xE3V[`@R\x91\x90PV[`\0`\x01`\x01`@\x1B\x03\x82\x11\x15b\0\x14\xBDWb\0\x14\xBDb\0\x13\xE3V[P`\x05\x1B` \x01\x90V[\x80Q`\x01`\x01`\xA0\x1B\x03\x81\x16\x81\x14b\0\x14\xDFW`\0\x80\xFD[\x91\x90PV[\x80Q`\x01`\x01`@\x1B\x03\x81\x16\x81\x14b\0\x14\xDFW`\0\x80\xFD[`\0`@\x82\x84\x03\x12\x15b\0\x15\x0FW`\0\x80\xFD[b\0\x15\x19b\0\x13\xF9V[\x90Pb\0\x15&\x82b\0\x14\xE4V[\x81R` \x82\x81\x01Q`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x15CW`\0\x80\xFD[\x83\x01`\x1F\x81\x01\x85\x13b\0\x15UW`\0\x80\xFD[\x80Qb\0\x15lb\0\x15f\x82b\0\x14\xA1V[b\0\x14nV[\x81\x81R`\x05\x91\x90\x91\x1B\x82\x01\x83\x01\x90\x83\x81\x01\x90\x87\x83\x11\x15b\0\x15\x8CW`\0\x80\xFD[\x92\x84\x01\x92[\x82\x84\x10\x15b\0\x15\xB5Wb\0\x15\xA5\x84b\0\x14\xC7V[\x82R\x92\x84\x01\x92\x90\x84\x01\x90b\0\x15\x91V[\x80\x85\x87\x01RPPPPP\x92\x91PPV[\x80Q`\xFF\x81\x16\x81\x14b\0\x14\xDFW`\0\x80\xFD[`\0[\x83\x81\x10\x15b\0\x15\xF4W\x81\x81\x01Q\x83\x82\x01R` \x01b\0\x15\xDAV[PP`\0\x91\x01RV[`\0\x82`\x1F\x83\x01\x12b\0\x16\x0FW`\0\x80\xFD[\x81Q` b\0\x16\"b\0\x15f\x83b\0\x14\xA1V[\x82\x81R`\x05\x92\x90\x92\x1B\x84\x01\x81\x01\x91\x81\x81\x01\x90\x86\x84\x11\x15b\0\x16BW`\0\x80\xFD[\x82\x86\x01[\x84\x81\x10\x15b\0\x17wW\x80Q`\x01`\x01`@\x1B\x03\x80\x82\x11\x15b\0\x16hW`\0\x80\x81\xFD[\x90\x88\x01\x90`@`\x1F\x19\x83\x8C\x03\x81\x01\x82\x13\x15b\0\x16\x84W`\0\x80\x81\xFD[b\0\x16\x8Eb\0\x13\xF9V[\x88\x85\x01Q\x81R\x82\x85\x01Q\x84\x81\x11\x15b\0\x16\xA7W`\0\x80\x81\xFD[\x80\x86\x01\x95PP\x82\x82\x86\x8F\x03\x01\x12\x15b\0\x16\xC0W`\0\x80\x81\xFD[b\0\x16\xCAb\0\x13\xF9V[b\0\x16\xD7\x8A\x87\x01b\0\x15\xC5V[\x81R\x83\x86\x01Q\x85\x81\x11\x15b\0\x16\xECW`\0\x80\x81\xFD[\x80\x87\x01\x96PP\x8D`?\x87\x01\x12b\0\x17\x03W`\0\x80\x81\xFD[\x89\x86\x01Q\x85\x81\x11\x15b\0\x17\x1AWb\0\x17\x1Ab\0\x13\xE3V[b\0\x17,\x8B\x85`\x1F\x84\x01\x16\x01b\0\x14nV[\x95P\x80\x86R\x8E\x85\x82\x89\x01\x01\x11\x15b\0\x17FW`\0\x93P\x83\x84\xFD[b\0\x17W\x81\x8C\x88\x01\x87\x8A\x01b\0\x15\xD7V[P\x80\x8A\x01\x94\x90\x94R\x80\x89\x01\x93\x90\x93RPP\x84RP\x91\x83\x01\x91\x83\x01b\0\x16FV[P\x96\x95PPPPPPV[`\0`\xE0\x82\x84\x03\x12\x15b\0\x17\x95W`\0\x80\xFD[b\0\x17\x9Fb\0\x14$V[\x82Q\x90\x91P`\x01`\x01`@\x1B\x03\x80\x82\x11\x15b\0\x17\xBAW`\0\x80\xFD[b\0\x17\xC8\x85\x83\x86\x01b\0\x14\xFCV[\x83Rb\0\x17\xD8` \x85\x01b\0\x14\xE4V[` \x84\x01Rb\0\x17\xEB`@\x85\x01b\0\x14\xE4V[`@\x84\x01R``\x84\x01Q``\x84\x01R`\x80\x84\x01Q`\x80\x84\x01Rb\0\x18\x12`\xA0\x85\x01b\0\x15\xC5V[`\xA0\x84\x01R`\xC0\x84\x01Q\x91P\x80\x82\x11\x15b\0\x18,W`\0\x80\xFD[Pb\0\x18;\x84\x82\x85\x01b\0\x15\xFDV[`\xC0\x83\x01RP\x92\x91PPV[`\0\x80`@\x83\x85\x03\x12\x15b\0\x18[W`\0\x80\xFD[\x82Q`\x01`\x01`@\x1B\x03\x80\x82\x11\x15b\0\x18sW`\0\x80\xFD[\x81\x85\x01\x91P\x85`\x1F\x83\x01\x12b\0\x18\x88W`\0\x80\xFD[\x81Q` b\0\x18\x9Bb\0\x15f\x83b\0\x14\xA1V[\x82\x81R`\x05\x92\x90\x92\x1B\x84\x01\x81\x01\x91\x81\x81\x01\x90\x89\x84\x11\x15b\0\x18\xBBW`\0\x80\xFD[\x82\x86\x01[\x84\x81\x10\x15b\0\x19\xCBW\x80Q\x86\x81\x11\x15b\0\x18\xD8W`\0\x80\xFD[\x87\x01``\x81\x8D\x03`\x1F\x19\x01\x12\x15b\0\x18\xEFW`\0\x80\xFD[b\0\x18\xF9b\0\x14IV[b\0\x19\x06\x86\x83\x01b\0\x14\xC7V[\x81R`@\x82\x01Q`\x03\x81\x10b\0\x19\x1BW`\0\x80\xFD[\x81\x87\x01R``\x82\x01Q\x88\x81\x11\x15b\0\x192W`\0\x80\xFD[\x80\x83\x01\x92PP\x8C`?\x83\x01\x12b\0\x19HW`\0\x80\xFD[\x85\x82\x01Qb\0\x19[b\0\x15f\x82b\0\x14\xA1V[\x81\x81R`\x05\x91\x90\x91\x1B\x83\x01`@\x01\x90\x87\x81\x01\x90\x8F\x83\x11\x15b\0\x19|W`\0\x80\xFD[`@\x85\x01\x94P[\x82\x85\x10\x15b\0\x19\xB5W\x84Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x14b\0\x19\xA5W`\0\x80\xFD[\x82R\x93\x88\x01\x93\x90\x88\x01\x90b\0\x19\x83V[`@\x84\x01RPP\x84RP\x91\x83\x01\x91\x83\x01b\0\x18\xBFV[P\x91\x88\x01Q\x91\x96P\x90\x93PPP\x80\x82\x11\x15b\0\x19\xE6W`\0\x80\xFD[Pb\0\x19\xF5\x85\x82\x86\x01b\0\x17\x82V[\x91PP\x92P\x92\x90PV[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[`\x03\x81\x10b\0\x1AJWcNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[\x90RV[` \x81\x01b\0\x11\r\x82\x84b\0\x1A+V[`\0\x81Q\x80\x84R` \x80\x85\x01\x94P\x80\x84\x01`\0[\x83\x81\x10\x15b\0\x1A\x9AW\x81Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x87R\x95\x82\x01\x95\x90\x82\x01\x90`\x01\x01b\0\x1ArV[P\x94\x95\x94PPPPPV[`\0\x81Q\x80\x84Rb\0\x1A\xBF\x81` \x86\x01` \x86\x01b\0\x15\xD7V[`\x1F\x01`\x1F\x19\x16\x92\x90\x92\x01` \x01\x92\x91PPV[`\0``\x80\x83\x01\x81\x84R\x80\x87Q\x80\x83R`\x80\x86\x01\x91P`\x80\x81`\x05\x1B\x87\x01\x01\x92P` \x80\x8A\x01`\0[\x83\x81\x10\x15b\0\x1B^W\x88\x86\x03`\x7F\x19\x01\x85R\x81Q\x80Q`\x01`\x01`\xA0\x1B\x03\x16\x87R\x83\x81\x01Qb\0\x1B/\x85\x89\x01\x82b\0\x1A+V[P`@\x90\x81\x01Q\x90\x87\x01\x88\x90Rb\0\x1BJ\x87\x89\x01\x82b\0\x1A^V[\x96PP\x93\x82\x01\x93\x90\x82\x01\x90`\x01\x01b\0\x1A\xFCV[PP`\x01`\x01`\xA0\x1B\x03\x89\x16\x90\x87\x01RPP\x83\x81\x03`@\x85\x01Rb\0\x1B\x84\x81\x86b\0\x1A\xA5V[\x97\x96PPPPPPPV[`\xFF\x81Q\x16\x82R`\0` \x82\x01Q`@` \x85\x01Rb\0\x1B\xB3`@\x85\x01\x82b\0\x1A\xA5V[\x94\x93PPPPV[`\0``\x82\x01`\x01\x80`@\x1B\x03\x86\x16\x83R` ``\x81\x85\x01R\x81\x86Q\x80\x84R`\x80\x86\x01\x91P`\x80\x81`\x05\x1B\x87\x01\x01\x93P\x82\x88\x01`\0[\x82\x81\x10\x15b\0\x1C#W`\x7F\x19\x88\x87\x03\x01\x84Rb\0\x1C\x10\x86\x83Qb\0\x1B\x8FV[\x95P\x92\x84\x01\x92\x90\x84\x01\x90`\x01\x01b\0\x1B\xF1V[PPPP\x83\x82\x03`@\x85\x01R\x84Q\x80\x83R\x81\x86\x01\x92\x82\x01\x90`\0[\x81\x81\x10\x15b\0\x1C\\W\x84Q\x83R\x93\x83\x01\x93\x91\x83\x01\x91`\x01\x01b\0\x1C>V[P\x90\x98\x97PPPPPPPPV[`\x01\x81\x81\x1C\x90\x82\x16\x80b\0\x1C\x7FW`\x7F\x82\x16\x91P[` \x82\x10\x81\x03b\0\x1C\xA0WcNH{q`\xE0\x1B`\0R`\"`\x04R`$`\0\xFD[P\x91\x90PV[`\x1F\x82\x11\x15b\0\x122W`\0\x81\x81R` \x81 `\x1F\x85\x01`\x05\x1C\x81\x01` \x86\x10\x15b\0\x1C\xCFWP\x80[`\x1F\x85\x01`\x05\x1C\x82\x01\x91P[\x81\x81\x10\x15b\0\x0F=W\x82\x81U`\x01\x01b\0\x1C\xDBV[\x81Q`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x1D\x0CWb\0\x1D\x0Cb\0\x13\xE3V[b\0\x1D$\x81b\0\x1D\x1D\x84Tb\0\x1CjV[\x84b\0\x1C\xA6V[` \x80`\x1F\x83\x11`\x01\x81\x14b\0\x1D\\W`\0\x84\x15b\0\x1DCWP\x85\x83\x01Q[`\0\x19`\x03\x86\x90\x1B\x1C\x19\x16`\x01\x85\x90\x1B\x17\x85Ub\0\x0F=V[`\0\x85\x81R` \x81 `\x1F\x19\x86\x16\x91[\x82\x81\x10\x15b\0\x1D\x8DW\x88\x86\x01Q\x82U\x94\x84\x01\x94`\x01\x90\x91\x01\x90\x84\x01b\0\x1DlV[P\x85\x82\x10\x15b\0\x1D\xACW\x87\x85\x01Q`\0\x19`\x03\x88\x90\x1B`\xF8\x16\x1C\x19\x16\x81U[PPPPP`\x01\x90\x81\x1B\x01\x90UPV[cNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[\x80\x82\x01\x80\x82\x11\x15b\0\x11\rWb\0\x11\rb\0\x1D\xBCV[`\0\x81Q\x80\x84R` \x80\x85\x01\x80\x81\x96P\x83`\x05\x1B\x81\x01\x91P\x82\x86\x01`\0[\x85\x81\x10\x15b\0\x1EHW\x82\x84\x03\x89R\x81Q\x80Q\x85R\x85\x01Q`@\x86\x86\x01\x81\x90Rb\0\x1E3\x81\x87\x01\x83b\0\x1B\x8FV[\x9A\x87\x01\x9A\x95PPP\x90\x84\x01\x90`\x01\x01b\0\x1E\x06V[P\x91\x97\x96PPPPPPPV[`\x01`\x01`@\x1B\x03\x84\x16\x81R``` \x82\x01\x81\x90R`\0\x90b\0\x1E{\x90\x83\x01\x85b\0\x1D\xE8V[\x90P\x82`@\x83\x01R\x94\x93PPPPV[` \x81R`\0b\0\x11\n` \x83\x01\x84b\0\x1A^V[`\0a\xFF\xFF\x80\x83\x16\x81\x81\x03b\0\x1E\xBAWb\0\x1E\xBAb\0\x1D\xBCV[`\x01\x01\x93\x92PPPV[`\0\x82Qb\0\x1E\xD8\x81\x84` \x87\x01b\0\x15\xD7V[\x91\x90\x91\x01\x92\x91PPV[`\x01`\x01`\xA0\x1B\x03\x83\x16\x81R`@` \x82\x01\x81\x90R`\0\x90b\0\x1B\xB3\x90\x83\x01\x84b\0\x1A\xA5V[` \x80\x82R\x82Q`\x01`\x01`@\x1B\x03\x16\x82\x82\x01R\x82\x01Q`\x01`\x01`\x80\x1B\x03\x16`@\x80\x83\x01\x91\x90\x91R\x82\x01Q``\x80\x83\x01R`\0\x90b\0\x1B\xB3`\x80\x84\x01\x82b\0\x1A\xA5V[` \x81R`\0b\0\x11\n` \x83\x01\x84b\0\x1B\x8FV[` \x81R`\0b\0\x11\n` \x83\x01\x84b\0\x1D\xE8V[\x81\x81\x03b\0\x1F\x82WPPV[b\0\x1F\x8E\x82Tb\0\x1CjV[`\x01`\x01`@\x1B\x03\x81\x11\x15b\0\x1F\xA8Wb\0\x1F\xA8b\0\x13\xE3V[b\0\x1F\xB9\x81b\0\x1D\x1D\x84Tb\0\x1CjV[`\0`\x1F\x82\x11`\x01\x81\x14b\0\x1F\xF0W`\0\x83\x15b\0\x1F\xD7WP\x84\x82\x01T[`\0\x19`\x03\x85\x90\x1B\x1C\x19\x16`\x01\x84\x90\x1B\x17\x84Ub\0 XV[`\0\x85\x81R` \x90 `\x1F\x19\x84\x16\x90`\0\x86\x81R` \x90 \x84[\x83\x81\x10\x15b\0 ,W\x82\x86\x01T\x82U`\x01\x95\x86\x01\x95\x90\x91\x01\x90` \x01b\0 \nV[P\x85\x83\x10\x15b\0 KW\x81\x85\x01T`\0\x19`\x03\x88\x90\x1B`\xF8\x16\x1C\x19\x16\x81U[PPP`\x01\x83`\x01\x1B\x01\x84U[PPPPPV[`\xE2\x80b\0 n`\09`\0\xF3\xFE`\x80`@R6`\x10W`\x0E`\x13V[\0[`\x0E[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` \x81\x90R`@\x90\x91 T\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80`\x89W`@Qc\n\x82\xDDs`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19`\x005\x16`\x04\x82\x01R`$\x01`@Q\x80\x91\x03\x90\xFD[6`\0\x807`\0\x806`\0\x84Z\xF4=`\0\x80>\x80\x80\x15`\xA7W=`\0\xF3[=`\0\xFD\xFE\xA2dipfsX\"\x12 (\xA2\xB6\xC8\xC9\xA8\xC6\xACE5\xB6\x90\xC4\x8Dm\xFC\xAES\xFA*\xB5\x7FJECF#\xB3-\x17\xCA\x8EdsolcC\0\x08\x13\x003diamondCut: _init address has no codediamondCut: Add facet has no code";
    /// The bytecode of the contract.
    pub static GATEWAYDIAMOND_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __BYTECODE,
    );
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@R6`\x10W`\x0E`\x13V[\0[`\x0E[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` \x81\x90R`@\x90\x91 T\x81\x90`\x01`\x01`\xA0\x1B\x03\x16\x80`\x89W`@Qc\n\x82\xDDs`\xE3\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19`\x005\x16`\x04\x82\x01R`$\x01`@Q\x80\x91\x03\x90\xFD[6`\0\x807`\0\x806`\0\x84Z\xF4=`\0\x80>\x80\x80\x15`\xA7W=`\0\xF3[=`\0\xFD\xFE\xA2dipfsX\"\x12 (\xA2\xB6\xC8\xC9\xA8\xC6\xACE5\xB6\x90\xC4\x8Dm\xFC\xAES\xFA*\xB5\x7FJECF#\xB3-\x17\xCA\x8EdsolcC\0\x08\x13\x003";
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
    ///Custom Error type `ValidatorWeightIsZero` with signature `ValidatorWeightIsZero()` and selector `0x389b457d`
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
    #[etherror(name = "ValidatorWeightIsZero", abi = "ValidatorWeightIsZero()")]
    pub struct ValidatorWeightIsZero;
    ///Custom Error type `ValidatorsAndWeightsLengthMismatch` with signature `ValidatorsAndWeightsLengthMismatch()` and selector `0x465f0a7d`
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
        name = "ValidatorsAndWeightsLengthMismatch",
        abi = "ValidatorsAndWeightsLengthMismatch()"
    )]
    pub struct ValidatorsAndWeightsLengthMismatch;
    ///Container type for all of the contract's custom errors
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum GatewayDiamondErrors {
        CannotAddFunctionToDiamondThatAlreadyExists(
            CannotAddFunctionToDiamondThatAlreadyExists,
        ),
        CannotAddSelectorsToZeroAddress(CannotAddSelectorsToZeroAddress),
        FunctionNotFound(FunctionNotFound),
        IncorrectFacetCutAction(IncorrectFacetCutAction),
        InitializationFunctionReverted(InitializationFunctionReverted),
        InvalidCollateral(InvalidCollateral),
        InvalidMajorityPercentage(InvalidMajorityPercentage),
        InvalidSubmissionPeriod(InvalidSubmissionPeriod),
        NoBytecodeAtAddress(NoBytecodeAtAddress),
        NoSelectorsProvidedForFacetForCut(NoSelectorsProvidedForFacetForCut),
        OldConfigurationNumber(OldConfigurationNumber),
        ValidatorWeightIsZero(ValidatorWeightIsZero),
        ValidatorsAndWeightsLengthMismatch(ValidatorsAndWeightsLengthMismatch),
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
            if let Ok(decoded) = <ValidatorWeightIsZero as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::ValidatorWeightIsZero(decoded));
            }
            if let Ok(decoded) = <ValidatorsAndWeightsLengthMismatch as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::ValidatorsAndWeightsLengthMismatch(decoded));
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
                Self::ValidatorWeightIsZero(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::ValidatorsAndWeightsLengthMismatch(element) => {
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
                _ if selector
                    == <OldConfigurationNumber as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <ValidatorWeightIsZero as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <ValidatorsAndWeightsLengthMismatch as ::ethers::contract::EthError>::selector() => {
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
                Self::ValidatorWeightIsZero(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::ValidatorsAndWeightsLengthMismatch(element) => {
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
    impl ::core::convert::From<ValidatorWeightIsZero> for GatewayDiamondErrors {
        fn from(value: ValidatorWeightIsZero) -> Self {
            Self::ValidatorWeightIsZero(value)
        }
    }
    impl ::core::convert::From<ValidatorsAndWeightsLengthMismatch>
    for GatewayDiamondErrors {
        fn from(value: ValidatorsAndWeightsLengthMismatch) -> Self {
            Self::ValidatorsAndWeightsLengthMismatch(value)
        }
    }
}
