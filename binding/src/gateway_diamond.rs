pub use gateway_diamond::*;
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
pub mod gateway_diamond {
    #[allow(deprecated)]
    fn __abi() -> ::ethers::core::abi::Abi {
        ::ethers::core::abi::ethabi::Contract {
            constructor: ::core::option::Option::Some(::ethers::core::abi::ethabi::Constructor {
                inputs: ::std::vec![
                    ::ethers::core::abi::ethabi::Param {
                        name: ::std::borrow::ToOwned::to_owned("_diamondCut"),
                        kind: ::ethers::core::abi::ethabi::ParamType::Array(
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
                        ),
                    },
                    ::ethers::core::abi::ethabi::Param {
                        name: ::std::borrow::ToOwned::to_owned("params"),
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
                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                            ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                            ::ethers::core::abi::ethabi::ParamType::Uint(8usize),
                            ::ethers::core::abi::ethabi::ParamType::Array(::std::boxed::Box::new(
                                ::ethers::core::abi::ethabi::ParamType::Tuple(::std::vec![
                                    ::ethers::core::abi::ethabi::ParamType::Uint(256usize),
                                    ::ethers::core::abi::ethabi::ParamType::Address,
                                    ::ethers::core::abi::ethabi::ParamType::Bytes,
                                ],),
                            ),),
                        ],),
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
                ),
                (
                    ::std::borrow::ToOwned::to_owned("OldConfigurationNumber"),
                    ::std::vec![::ethers::core::abi::ethabi::AbiError {
                        name: ::std::borrow::ToOwned::to_owned("OldConfigurationNumber",),
                        inputs: ::std::vec![],
                    },],
                ),
            ]),
            receive: true,
            fallback: true,
        }
    }
    ///The parsed JSON ABI of the contract.
    pub static GATEWAYDIAMOND_ABI: ::ethers::contract::Lazy<::ethers::core::abi::Abi> =
        ::ethers::contract::Lazy::new(__abi);
    #[rustfmt::skip]
    const __BYTECODE: &[u8] = b"`\x80`@R4b\0\taWb\0\x16x\x808\x03\x80\x91b\0\0 \x82`\x80b\0\n\xD8V[`\x809`@\x81\x12b\0\taW`\x80Q`\x01`\x01`@\x1B\x03\x81\x11b\0\taW`\x80\x82\x01`\x9F\x82\x01\x12\x15b\0\taW\x80`\x80\x01Q\x90b\0\0^\x82b\0\n\xFCV[\x91b\0\0n`@Q\x93\x84b\0\n\xD8V[\x80\x83R` \x83\x01\x80\x92\x85`\x80\x01` \x84`\x05\x1B\x83`\x80\x01\x01\x01\x11b\0\taW`\xA0\x81\x01\x91[`\xA0`\x05\x85\x90\x1B\x83\x01\x01\x83\x10b\0\t\x96WPP`\xA0Q\x91PP`\x01`\x01`@\x1B\x03\x81\x11b\0\taW`\xC0\x81\x85\x03\x12b\0\taW`@Q\x93`\x01`\x01`@\x1B\x03`\xC0\x86\x01\x90\x81\x11\x90\x86\x11\x17b\0\x04\xAAW`\xC0\x85\x01`@R`\x80\x82\x01Q`\x01`\x01`@\x1B\x03\x81\x11b\0\taW\x82`\x80\x01\x01`@\x81\x83`\x80\x01\x03\x12b\0\taWb\0\x01\x1E`\xC0\x87\x01b\0\n\xBCV[b\0\x01)\x81b\0\x0B)V[`\xC0\x87\x01R` \x81\x01Q`\x01`\x01`@\x1B\x03\x81\x11b\0\taW\x82`\x80\x01`\x1F\x82\x84\x01\x01\x12\x15b\0\taW\x80\x82\x01Qb\0\x01b\x81b\0\n\xFCV[\x92b\0\x01r`@Q\x94\x85b\0\n\xD8V[\x81\x84R` \x80\x85\x01\x92`\x05\x1B\x84\x83\x01\x01\x01\x92\x85`\x80\x01\x84\x11b\0\taW\x01` \x01\x90[\x82\x82\x10b\0\t{WPPP`\xE0\x86\x01R`\xC0\x85\x01\x85Rb\0\x01\xB9`\xA0\x83\x01b\0\x0B)V[` \x86\x01R`\xC0\x82\x01Q`@\x86\x01R`\xE0\x82\x01Q``\x86\x01Ra\x01\0\x82\x01Q`\xFF\x81\x16\x81\x03b\0\taW`\x80\x86\x01Ra\x01 \x82\x01Q\x90`\x01`\x01`@\x1B\x03\x82\x11b\0\taW`\x80\x81\x01`\x9F\x84\x84\x01\x01\x12\x15b\0\taW\x81\x83`\x80\x01\x01Q\x90b\0\x02\"\x82b\0\n\xFCV[\x93b\0\x022`@Q\x95\x86b\0\n\xD8V[\x82\x85R` \x85\x01\x93`\x80\x83\x01`\xA0\x83\x83\x01`\x05\x87\x90\x1B\x01\x01\x11b\0\taW`\xA0\x82\x82\x01\x01\x94[`\xA0\x83\x83\x01`\x05\x87\x90\x1B\x01\x01\x86\x10b\0\x08{WPPPPPP`\xA0\x84\x01R`@\x83\x01Q\x15b\0\x08iW` \x83\x01Q`\x01`\x01`@\x1B\x03\x16\x15b\0\x08WW`\xFF`\x80\x84\x01Q\x16`3\x81\x10\x90\x81\x15b\0\x08KW[Pb\0\x089W\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5\x80T`\x01`\x01`\xA0\x1B\x03\x19\x163\x17\x90U`@Q` \x81\x01`\x01`\x01`@\x1B\x03\x81\x11\x82\x82\x10\x17b\0\x04\xAAW`@R`\0\x81R\x82Q`\0[\x81\x81\x10b\0\x05\x1AWPP`@Q\x92``\x84\x01\x90``\x85RQ\x80\x91R`\x80\x84\x01\x90`\x80\x81`\x05\x1B\x86\x01\x01\x93\x91`\0\x90[\x82\x82\x10b\0\x04\xC0W\x87\x7F\x8F\xAAp\x87\x86q\xCC\xD2\x12\xD2\x07q\xB7\x95\xC5\n\xF8\xFD?\xF6\xCF'\xF4\xBD\xE5~]M\xE0\xAE\xB6s\x88\x80b\0\x03}\x8A\x8A`\0` \x85\x01R\x83\x82\x03`@\x85\x01Rb\0\x0B\xDFV[\x03\x90\xA1\x80Q\x80Q`\x13\x80T`\x01`\x01`@\x1B\x03\x19\x90\x81\x16`\x01`\x01`@\x1B\x03\x93\x84\x16\x17\x90\x91U` \x90\x92\x01Q\x80Q\x93\x92\x91\x84\x11b\0\x04\xAAWh\x01\0\0\0\0\0\0\0\0\x84\x11b\0\x04\xAAW` \x90`\x14T\x85`\x14U\x80\x86\x10b\0\x04\x89W[P\x01\x92`\x14`\0R` `\0 `\0[\x82\x81\x10b\0\x04kWb\0\x04[`\xA0\x86`\x01\x87`@\x83\x01Q`\x15U\x81\x80`@\x1B\x03` \x84\x01Q\x16\x81`\x18T\x16\x17`\x18U``\x83\x01Q`\x16U`\xFF`\x80\x84\x01Q\x16`\xFF\x19`\x17T\x16\x17`\x17U`\rT\x16\x17`\rU\x01Q`@Q\x90b\0\x04L\x82b\0\n\xBCV[\x81R`\0` \x82\x01Rb\0\x0FCV[`@Qa\x013\x90\x81b\0\x15\x05\x829\xF3[\x85Q`\x01`\x01`\xA0\x1B\x03\x16\x81\x83\x01U` \x90\x95\x01\x94`\x01\x01b\0\x03\xE9V[b\0\x04\xA3\x90`\x14`\0R\x86\x84`\0 \x91\x82\x01\x91\x01b\0\x0BcV[\x85b\0\x03\xD9V[cNH{q`\xE0\x1B`\0R`A`\x04R`$`\0\xFD[\x90\x91\x92\x94` \x80b\0\x05\x0B`\x01\x93`\x7F\x19\x8B\x82\x03\x01\x86R```@\x8BQ\x87\x80`\xA0\x1B\x03\x81Q\x16\x84Rb\0\x04\xFA\x86\x82\x01Q\x87\x86\x01\x90b\0\x0B\x91V[\x01Q\x91\x81`@\x82\x01R\x01\x90b\0\x0B\x9FV[\x97\x01\x92\x01\x92\x01\x90\x92\x91b\0\x036V[`@b\0\x05(\x82\x87b\0\x0B|V[Q\x01Q`\x01`\x01`\xA0\x1B\x03b\0\x05?\x83\x88b\0\x0B|V[QQ\x16\x90\x80Q\x15b\0\x08 W` b\0\x05Y\x84\x89b\0\x0B|V[Q\x01Q`\x03\x81\x10\x15b\0\x08\nW\x80b\0\x07\xE8WP\x81\x15b\0\x07\xC1Wa\xFF\xFF`\0\x80Q` b\0\x168\x839\x81Q\x91RT\x16\x91`@Qb\0\x05\x98\x81b\0\n\xA0V[`!\x81R\x7FdiamondCut: Add facet has no cod` \x82\x01R`e`\xF8\x1B`@\x82\x01R\x81;\x15b\0\x07\x91WP\x81Q\x91`\0\x93[\x83\x85\x10b\0\x05\xF2WPPPPP`\x01\x01b\0\x03\x07V[b\0\x05\xFE\x85\x83b\0\x0B|V[Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16`\0\x90\x81R`\0\x80Q` b\0\x16X\x839\x81Q\x91R` R`@\x90 T`\x01`\x01`\xA0\x1B\x03\x16b\0\x07nW`@Qb\0\x06C\x81b\0\n\xBCV[\x84\x81Ra\xFF\xFF\x83\x16` \x80\x83\x01\x91\x82R`\x01`\x01`\xE0\x1B\x03\x19\x84\x16`\0\x90\x81R`\0\x80Q` b\0\x16X\x839\x81Q\x91R\x90\x91R`@\x90 \x91Q\x82T\x91Q`\x01`\x01`\xB0\x1B\x03\x19\x90\x92\x16`\x01`\x01`\xA0\x1B\x03\x91\x90\x91\x16\x17`\xA0\x91\x90\x91\x1Ba\xFF\xFF`\xA0\x1B\x16\x17\x90U`\0\x80Q` b\0\x168\x839\x81Q\x91RT\x90h\x01\0\0\0\0\0\0\0\0\x82\x10\x15b\0\x04\xAAW`\x01\x82\x01\x80`\0\x80Q` b\0\x168\x839\x81Q\x91RU\x82\x10\x15b\0\x07XW`\0\x80Q` b\0\x168\x839\x81Q\x91R`\0R` `\0 \x82`\x03\x1C\x01\x91c\xFF\xFF\xFF\xFF`\xE0\x84T\x92`\x05\x1B\x16\x92`\xE0\x1C\x83\x1B\x92\x1B\x19\x16\x17\x90Ua\xFF\xFF\x80\x82\x16\x14b\0\x07BW`\x01a\xFF\xFF\x81\x92\x16\x01\x94\x01\x93b\0\x05\xDCV[cNH{q`\xE0\x1B`\0R`\x11`\x04R`$`\0\xFD[cNH{q`\xE0\x1B`\0R`2`\x04R`$`\0\xFD[`@Qc\xEB\xBF]\x07`\xE0\x1B\x81R`\x01`\x01`\xE0\x1B\x03\x19\x90\x91\x16`\x04\x82\x01R`$\x90\xFD[\x90b\0\x07\xBD`@Q\x92\x83\x92c\x91\x984\xB9`\xE0\x1B\x84R`\x04\x84\x01R`@`$\x84\x01R`D\x83\x01\x90b\0\x0B\xDFV[\x03\x90\xFD[`@Qc\x02\xB8\xDA\x07`\xE2\x1B\x81R` `\x04\x82\x01R\x90\x81\x90b\0\x07\xBD\x90`$\x83\x01\x90b\0\x0B\x9FV[`@Qc?\xF4\xD2\x0F`\xE1\x1B\x81R`$\x91b\0\x08\x08\x90`\x04\x83\x01\x90b\0\x0B\x91V[\xFD[cNH{q`\xE0\x1B`\0R`!`\x04R`$`\0\xFD[`@Qc\xE7g\xF9\x1F`\xE0\x1B\x81R`\x04\x81\x01\x83\x90R`$\x90\xFD[`@Qcu\xC3\xB4'`\xE0\x1B\x81R`\x04\x90\xFD[`d\x91P\x118b\0\x02\xAAV[`@Qc1/\x8E\x05`\xE0\x1B\x81R`\x04\x90\xFD[`@Qch\xF7\xA6u`\xE1\x1B\x81R`\x04\x90\xFD[\x85Q`\x01`\x01`@\x1B\x03\x81\x11b\0\taW`\x1F\x19\x91\x90\x84\x84\x01\x01`\x80\x81\x01\x90``\x90\x87\x03\x84\x01\x12b\0\taW`@Q\x90b\0\x08\xB6\x82b\0\n\xA0V[` \x81\x01Q\x82Rb\0\x08\xCB`@\x82\x01b\0\x0B\x14V[` \x83\x01R``\x81\x01Q\x90`\x01`\x01`@\x1B\x03\x82\x11b\0\taW\x01\x91\x86`\x80\x01`?\x84\x01\x12\x15b\0\taW` \x83\x01Q\x91`\x01`\x01`@\x1B\x03\x83\x11b\0\tfWb\0\t\"` `@Q\x96`\x1F\x86\x01\x16\x01\x86b\0\n\xD8V[\x82\x85R\x87`\x80\x01`@\x84\x86\x01\x01\x11b\0\taW\x84b\0\tN` \x96\x94\x87\x96`@\x88\x80\x98\x01\x91\x01b\0\x0B>V[`@\x82\x01R\x81R\x01\x96\x01\x95\x90Pb\0\x02XV[`\0\x80\xFD[`$`\0cNH{q`\xE0\x1B\x81R`A`\x04R\xFD[` \x80\x91b\0\t\x8A\x84b\0\x0B\x14V[\x81R\x01\x91\x01\x90b\0\x01\x95V[\x82Q`\x01`\x01`@\x1B\x03\x81\x11b\0\taW``\x90\x83\x01`\x80\x81\x01\x90\x89\x03`\x1F\x19\x01\x82\x13b\0\taW`@Q\x91b\0\t\xCD\x83b\0\n\xA0V[b\0\t\xDB` \x83\x01b\0\x0B\x14V[\x83R`@\x82\x01Q`\x03\x81\x10\x15b\0\taW` \x84\x01R\x81\x01Q\x90`\x01`\x01`@\x1B\x03\x82\x11b\0\taW\x01\x88`\x80\x01`?\x82\x01\x12\x15b\0\taW` \x81\x01Q\x90b\0\n%\x82b\0\n\xFCV[\x91b\0\n5`@Q\x93\x84b\0\n\xD8V[\x80\x83R` \x83\x01\x8B`\x80\x01`@\x83`\x05\x1B\x85\x01\x01\x11b\0\taW`@\x83\x01\x90[`@\x83`\x05\x1B\x85\x01\x01\x82\x10b\0\n}WPPPP`@\x82\x01R\x81R` \x92\x83\x01\x92\x01b\0\0\x93V[\x81Q`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x03b\0\taW\x81R` \x91\x82\x01\x91\x01b\0\nUV[``\x81\x01\x90\x81\x10`\x01`\x01`@\x1B\x03\x82\x11\x17b\0\x04\xAAW`@RV[`@\x81\x01\x90\x81\x10`\x01`\x01`@\x1B\x03\x82\x11\x17b\0\x04\xAAW`@RV[`\x1F\x90\x91\x01`\x1F\x19\x16\x81\x01\x90`\x01`\x01`@\x1B\x03\x82\x11\x90\x82\x10\x17b\0\x04\xAAW`@RV[`\x01`\x01`@\x1B\x03\x81\x11b\0\x04\xAAW`\x05\x1B` \x01\x90V[Q\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03b\0\taWV[Q\x90`\x01`\x01`@\x1B\x03\x82\x16\x82\x03b\0\taWV[`\0[\x83\x81\x10b\0\x0BRWPP`\0\x91\x01RV[\x81\x81\x01Q\x83\x82\x01R` \x01b\0\x0BAV[\x81\x81\x10b\0\x0BoWPPV[`\0\x81U`\x01\x01b\0\x0BcV[\x80Q\x82\x10\x15b\0\x07XW` \x91`\x05\x1B\x01\x01\x90V[\x90`\x03\x82\x10\x15b\0\x08\nWRV[\x90\x81Q\x80\x82R` \x80\x80\x93\x01\x93\x01\x91`\0[\x82\x81\x10b\0\x0B\xC0WPPPP\x90V[\x83Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x93\x81\x01\x93\x92\x81\x01\x92`\x01\x01b\0\x0B\xB1V[\x90` \x91b\0\x0B\xFA\x81Q\x80\x92\x81\x85R\x85\x80\x86\x01\x91\x01b\0\x0B>V[`\x1F\x01`\x1F\x19\x16\x01\x01\x90V[\x90\x80\x81\x83Q\x91\x82\x82R` \x80\x80\x80\x94\x01\x95\x85`\x05\x1B\x01\x01\x95\x01\x93`\0\x91[\x84\x83\x10b\0\x0C5WPPPPPP\x90V[\x90\x91\x92\x93\x94\x95\x84\x80b\0\x0Cx`\x01\x93`\x1F\x19\x86\x82\x03\x01\x87R\x8AQ\x80Q\x82R\x85\x80`\xA0\x1B\x03\x84\x82\x01Q\x16\x84\x83\x01R`@\x80\x91\x01Q\x91``\x80\x92\x82\x01R\x01\x90b\0\x0B\xDFV[\x98\x01\x93\x01\x93\x01\x91\x94\x93\x92\x90b\0\x0C$V[\x90`\x01\x82\x81\x1C\x92\x16\x80\x15b\0\x0C\xBBW[` \x83\x10\x14b\0\x0C\xA5WV[cNH{q`\xE0\x1B`\0R`\"`\x04R`$`\0\xFD[\x91`\x7F\x16\x91b\0\x0C\x99V[\x91\x90`\x1F\x81\x11b\0\x0C\xD6WPPPV[b\0\r\x05\x92`\0R` `\0 \x90` `\x1F\x84\x01`\x05\x1C\x83\x01\x93\x10b\0\r\x07W[`\x1F\x01`\x05\x1C\x01\x90b\0\x0BcV[V[\x90\x91P\x81\x90b\0\x0C\xF7V[\x90\x80\x82\x14b\0\r\xFBWb\0\r'\x81Tb\0\x0C\x89V[\x90`\x01`\x01`@\x1B\x03\x82\x11b\0\x04\xAAW\x81\x90b\0\rQ\x82b\0\rJ\x86Tb\0\x0C\x89V[\x86b\0\x0C\xC6V[`\0\x90`\x1F\x83\x11`\x01\x14b\0\r\x8BW`\0\x92b\0\r\x7FW[PP\x81`\x01\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90UV[\x01T\x90P8\x80b\0\riV[\x81R` \x80\x82 \x85\x83R\x81\x83 \x93P\x90`\x1F\x19\x85\x16\x90\x83\x90[\x82\x82\x10b\0\r\xE1WPP\x90\x84`\x01\x95\x94\x93\x92\x10b\0\r\xC7W[PPP\x81\x1B\x01\x90UV[\x01T`\0\x19`\xF8\x84`\x03\x1B\x16\x1C\x19\x16\x90U8\x80\x80b\0\r\xBDV[\x84\x95\x81\x92\x95\x85\x01T\x81U`\x01\x80\x91\x01\x96\x01\x94\x01\x90b\0\r\xA4V[PPV[`\x06T\x81\x10\x15b\0\x07XW`\x06`\0R`\x03` `\0 \x91\x02\x01\x90`\0\x90V[\x90b\0\x0F-W\x81Q\x81U` \x80\x83\x01Q`\x01\x80\x84\x01\x80T`\x01`\x01`\xA0\x1B\x03\x19\x16`\x01`\x01`\xA0\x1B\x03\x93\x90\x93\x16\x92\x90\x92\x17\x90\x91U`@\x90\x93\x01Q\x80Q`\x02\x90\x93\x01\x93\x92\x91\x90`\x01`\x01`@\x1B\x03\x83\x11b\0\x04\xAAWb\0\x0E\x8B\x83b\0\x0E\x84\x87Tb\0\x0C\x89V[\x87b\0\x0C\xC6V[\x81`\x1F\x84\x11`\x01\x14b\0\x0E\xC7WP\x92\x82\x93\x91\x83\x92`\0\x94b\0\x0E\xBBW[PP\x1B\x91`\0\x19\x90`\x03\x1B\x1C\x19\x16\x17\x90UV[\x01Q\x92P8\x80b\0\x0E\xA8V[\x91\x90\x83`\x1F\x19\x81\x16\x87`\0R\x84`\0 \x94`\0\x90[\x88\x83\x83\x10b\0\x0F\x12WPPP\x10b\0\x0E\xF8WPPP\x81\x1B\x01\x90UV[\x01Q`\0\x19`\xF8\x84`\x03\x1B\x16\x1C\x19\x16\x90U8\x80\x80b\0\r\xBDV[\x85\x87\x01Q\x88U\x90\x96\x01\x95\x94\x85\x01\x94\x87\x93P\x90\x81\x01\x90b\0\x0E\xDCV[cNH{q`\xE0\x1B`\0R`\0`\x04R`$`\0\xFD[`@\x90\x81Q\x90` \x92\x83\x83Rb\0\x0Fe\x82Q\x82\x86\x86\x01R``\x85\x01\x90b\0\x0C\x06V[\x92\x7F~\xCD\xACH#4\xC3o\xCC\xBE7C\x18\xCF\xE7N\xA0\xC8\x18\x13\x94\x89\r\xDE\xC8\x94\xA1\x0F\x0F\xCCt\x81\x85\x84\x01\x91\x80`\x01\x80`@\x1B\x03\x96\x87\x85Q\x16\x86\x83\x01R\x03\x90\xA1\x83\x80`\x07T\x16\x91\x82b\0\x12\x83W[PPPP`\x06\x80T\x91h\x01\0\0\0\0\0\0\0\0\x93\x84\x84\x11b\0\x04\xAAW`\x08T\x84`\x08U\x80\x85\x10b\0\x11\xCBW[P`\0\x93\x83\x85R\x86\x85 `\x08\x86R\x87\x86 \x90\x86\x90[\x83\x82\x10b\0\x11uWPPPP`\x07T\x16`\x01\x80`@\x1B\x03\x19`\tT\x16\x17`\tU\x80QQ\x90\x82T\x94\x84[\x83\x81\x10b\0\x10\xF3WPPP\x80\x84\x11b\0\x102W[PPPPPV[\x83\x81\x10\x15b\0\x10+W\x81T\x80\x15b\0\x10\xDFW`\0\x19\x01\x90b\0\x10T\x82b\0\r\xFFV[\x92\x90\x92b\0\x10\xCBW\x84\x83U\x84`\x02`\x01\x94\x82\x86\x82\x01U\x01b\0\x10w\x81Tb\0\x0C\x89V[\x80b\0\x10\x8AW[PPP\x83U\x01b\0\x102V[\x82`\x1F\x80\x83\x11`\x01\x14b\0\x10\xA6WPPPU[\x848\x80b\0\x10~V[\x83\x82R\x8B\x82 \x93\x91\x92b\0\x10\xC3\x91\x01`\x05\x1C\x84\x01\x88\x85\x01b\0\x0BcV[UUb\0\x10\x9DV[cNH{q`\xE0\x1B\x85R`\x04\x85\x90R`$\x85\xFD[cNH{q`\xE0\x1B\x84R`1`\x04R`$\x84\xFD[\x86\x81\x10\x15b\0\x11*W\x80b\0\x11#b\0\x11\x10`\x01\x93\x86Qb\0\x0B|V[Qb\0\x11\x1C\x83b\0\r\xFFV[\x90b\0\x0E\x1FV[\x01b\0\x10\x17V[b\0\x117\x81\x84Qb\0\x0B|V[Q\x85T\x83\x81\x10\x15b\0\x11aW`\x01\x92\x91b\0\x11\x1C\x82\x85b\0\x11[\x94\x01\x8AUb\0\r\xFFV[b\0\x11#V[cNH{q`\xE0\x1B\x88R`A`\x04R`$\x88\xFD[\x80`\x01\x91\x84\x03b\0\x11\x92W[`\x03\x80\x91\x01\x93\x01\x91\x01\x90\x91b\0\x0F\xEEV[\x80T\x84U\x81\x80\x85\x01\x90\x83\x80`\xA0\x1B\x03\x90\x83\x01T\x16\x83\x80`\xA0\x1B\x03\x19\x82T\x16\x17\x90Ub\0\x11\xC5`\x02\x80\x83\x01\x90\x86\x01b\0\r\x12V[b\0\x11\x81V[`\x03\x90\x80\x82\x02\x90\x82\x82\x04\x03b\0\x07BW\x85\x82\x02\x82\x81\x04\x87\x03b\0\x07BW`\0\x90`\x08\x82R\x89\x82 \x92\x83\x01\x92\x01[\x82\x81\x10b\0\x12\tWPPPb\0\x0F\xD9V[\x80\x82\x85\x92U\x82\x8B`\x01\x82\x81\x85\x01U`\x02\x84\x01\x90b\0\x12(\x82Tb\0\x0C\x89V[\x90\x81b\0\x12<W[PPPPP\x01b\0\x11\xF8V[\x84\x90`\x1F\x80\x84\x11`\x01\x14b\0\x12^WPPPP\x90PU[\x82\x8B8\x80\x80b\0\x120V[\x84\x93\x95\x83\x95b\0\x12{\x94R\x85 \x95\x01`\x05\x1C\x85\x01\x90\x85\x01b\0\x0BcV[UUb\0\x12SV[Q\x16\x84`\tT\x16\x90\x81\x81\x14b\0\x14\x01W\x10b\0\x13\xF0W\x81Q\x91b\0\x12\xA7\x83b\0\n\xBCV[`\x06Tb\0\x12\xB5\x81b\0\n\xFCV[\x91b\0\x12\xC4\x81Q\x93\x84b\0\n\xD8V[\x81\x83R\x87\x83\x01\x90`\x06`\0R\x88`\0 \x90`\0\x92[\x84\x84\x10b\0\x13\rWPPP\x91\x84RPP\x84\x82\x01Rb\0\x12\xF9\x90\x82b\0\x14\nV[b\0\x13\x08W8\x80\x83\x81b\0\x0F\xADV[PPPV[\x8A\x82Qb\0\x13\x1B\x81b\0\n\xA0V[\x84T\x81R`\x01\x85\x01T`\x01`\x01`\xA0\x1B\x03\x16\x82\x82\x01R\x83Q`\x02\x86\x01\x80T`\0\x91b\0\x13G\x82b\0\x0C\x89V[\x80\x85R\x91`\x01\x81\x16\x90\x81\x15b\0\x13\xD0WP`\x01\x14b\0\x13\x8CW[PP\x91\x81b\0\x13y`\x01\x96\x93`\x03\x96\x95\x03\x82b\0\n\xD8V[\x86\x82\x01R\x81R\x01\x93\x01\x93\x01\x92\x91b\0\x12\xD9V[`\0\x90\x81R\x85\x81 \x90\x92P[\x81\x83\x10b\0\x13\xB1WPP\x81\x01\x83\x01\x81b\0\x13yb\0\x13aV[\x80`\x01\x91\x96\x92\x93\x94\x95\x96T\x83\x86\x88\x01\x01R\x01\x92\x01\x90\x8F\x94\x93\x92b\0\x13\x98V[`\xFF\x19\x16\x85\x88\x01RPP\x15\x15`\x05\x1B\x82\x01\x84\x01\x90P\x81b\0\x13yb\0\x13aV[\x81Qc7F\xBE%`\xE1\x1B\x81R`\x04\x90\xFD[PPPPPPPV[` \x80\x82\x01Q\x83\x82\x01Q\x91\x92\x91`\x01`\x01`@\x1B\x03\x91\x82\x16\x91\x16\x03b\0\x14\xBCWb\0\x145\x81b\0\x14\xC4V[b\0\x14@\x84b\0\x14\xC4V[\x03b\0\x14\xBCWQ\x80Q\x83QQ\x03b\0\x14\xBCWb\0\x14\xB5b\0\x14\xA8\x91`@Q\x90\x81b\0\x14v\x86\x82\x01\x92\x87\x84R`@\x83\x01\x90b\0\x0C\x06V[\x03\x91b\0\x14\x8C`\x1F\x19\x93\x84\x81\x01\x83R\x82b\0\n\xD8V[Q\x90 \x94Q`@Q\x93\x84\x91\x86\x83\x01\x96\x87R`@\x83\x01\x90b\0\x0C\x06V[\x03\x90\x81\x01\x83R\x82b\0\n\xD8V[Q\x90 \x14\x90V[PPP`\0\x90V[\x80QQ\x90`\0\x91\x82\x91[\x81\x83\x10b\0\x14\xDCWPPP\x90V[\x90\x91\x92b\0\x14\xEC\x84\x83Qb\0\x0B|V[QQ\x81\x01\x80\x91\x11b\0\x07BW\x92`\x01\x01\x91\x90b\0\x14\xCEV\xFE`\x80`@R6\x15`\x87W`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`oWP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[=\x90\xFD[`$\x90`@Q\x90c\n\x82\xDDs`\xE3\x1B\x82R`\x04\x82\x01R\xFD[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`\xE9WP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[c\n\x82\xDDs`\xE3\x1B`\x80R`\x84R`$`\x80\xFD\xFE\xA2dipfsX\"\x12 \xF2M~\xF2\x18!h<\xD5L\xBA\xF7TR\x9DyY[\x0FV\xD7\xA1\xB7\xCE6@\xCBE\xB5\x91\x1A\xE0dsolcC\0\x08\x13\x003\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD3\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2";
    /// The bytecode of the contract.
    pub static GATEWAYDIAMOND_BYTECODE: ::ethers::core::types::Bytes =
        ::ethers::core::types::Bytes::from_static(__BYTECODE);
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@R6\x15`\x87W`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`oWP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[=\x90\xFD[`$\x90`@Q\x90c\n\x82\xDDs`\xE3\x1B\x82R`\x04\x82\x01R\xFD[`\0\x805`\x01`\x01`\xE0\x1B\x03\x19\x16\x80\x82R\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD2` R`@\x82 T`\x01`\x01`\xA0\x1B\x03\x16\x90\x81\x15`\xE9WP\x81\x80\x916\x82\x807\x816\x91Z\xF4=\x82\x80>\x15`kW=\x90\xF3[c\n\x82\xDDs`\xE3\x1B`\x80R`\x84R`$`\x80\xFD\xFE\xA2dipfsX\"\x12 \xF2M~\xF2\x18!h<\xD5L\xBA\xF7TR\x9DyY[\x0FV\xD7\xA1\xB7\xCE6@\xCBE\xB5\x91\x1A\xE0dsolcC\0\x08\x13\x003";
    /// The deployed bytecode of the contract.
    pub static GATEWAYDIAMOND_DEPLOYED_BYTECODE: ::ethers::core::types::Bytes =
        ::ethers::core::types::Bytes::from_static(__DEPLOYED_BYTECODE);
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
            Self(::ethers::contract::Contract::new(
                address.into(),
                GATEWAYDIAMOND_ABI.clone(),
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
        for GatewayDiamond<M>
    {
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
        Hash,
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
        Hash,
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
        Hash,
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
        Hash,
    )]
    #[etherror(
        name = "IncorrectFacetCutAction",
        abi = "IncorrectFacetCutAction(uint8)"
    )]
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
        Hash,
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
        Hash,
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
        Hash,
    )]
    #[etherror(
        name = "InvalidMajorityPercentage",
        abi = "InvalidMajorityPercentage()"
    )]
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
        Hash,
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
        Hash,
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
        Hash,
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
        Hash,
    )]
    #[etherror(name = "OldConfigurationNumber", abi = "OldConfigurationNumber()")]
    pub struct OldConfigurationNumber;
    ///Container type for all of the contract's custom errors
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum GatewayDiamondErrors {
        CannotAddFunctionToDiamondThatAlreadyExists(CannotAddFunctionToDiamondThatAlreadyExists),
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
        /// The standard solidity revert string, with selector
        /// Error(string) -- 0x08c379a0
        RevertString(::std::string::String),
    }
    impl ::ethers::core::abi::AbiDecode for GatewayDiamondErrors {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) =
                <::std::string::String as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::RevertString(decoded));
            }
            if let Ok(decoded) = <CannotAddFunctionToDiamondThatAlreadyExists as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotAddFunctionToDiamondThatAlreadyExists(decoded));
            }
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
                return Ok(Self::NoSelectorsProvidedForFacetForCut(decoded));
            }
            if let Ok(decoded) =
                <OldConfigurationNumber as ::ethers::core::abi::AbiDecode>::decode(data)
            {
                return Ok(Self::OldConfigurationNumber(decoded));
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
                Self::FunctionNotFound(element) => ::ethers::core::abi::AbiEncode::encode(element),
                Self::IncorrectFacetCutAction(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InitializationFunctionReverted(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::InvalidCollateral(element) => ::ethers::core::abi::AbiEncode::encode(element),
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
                Self::IncorrectFacetCutAction(element) => ::core::fmt::Display::fmt(element, f),
                Self::InitializationFunctionReverted(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::InvalidCollateral(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidMajorityPercentage(element) => ::core::fmt::Display::fmt(element, f),
                Self::InvalidSubmissionPeriod(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoBytecodeAtAddress(element) => ::core::fmt::Display::fmt(element, f),
                Self::NoSelectorsProvidedForFacetForCut(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::OldConfigurationNumber(element) => ::core::fmt::Display::fmt(element, f),
                Self::RevertString(s) => ::core::fmt::Display::fmt(s, f),
            }
        }
    }
    impl ::core::convert::From<::std::string::String> for GatewayDiamondErrors {
        fn from(value: String) -> Self {
            Self::RevertString(value)
        }
    }
    impl ::core::convert::From<CannotAddFunctionToDiamondThatAlreadyExists> for GatewayDiamondErrors {
        fn from(value: CannotAddFunctionToDiamondThatAlreadyExists) -> Self {
            Self::CannotAddFunctionToDiamondThatAlreadyExists(value)
        }
    }
    impl ::core::convert::From<CannotAddSelectorsToZeroAddress> for GatewayDiamondErrors {
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
    impl ::core::convert::From<NoSelectorsProvidedForFacetForCut> for GatewayDiamondErrors {
        fn from(value: NoSelectorsProvidedForFacetForCut) -> Self {
            Self::NoSelectorsProvidedForFacetForCut(value)
        }
    }
    impl ::core::convert::From<OldConfigurationNumber> for GatewayDiamondErrors {
        fn from(value: OldConfigurationNumber) -> Self {
            Self::OldConfigurationNumber(value)
        }
    }
}
