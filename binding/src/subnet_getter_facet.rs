pub use subnet_getter_facet::*;
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
pub mod subnet_getter_facet {
    #[allow(deprecated)]
    fn __abi() -> ::ethers::core::abi::Abi {
        ::ethers::core::abi::ethabi::Contract {
            constructor: ::core::option::Option::None,
            functions: ::core::convert::From::from([
                (
                    ::std::borrow::ToOwned::to_owned("getGateway"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("getGateway"),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::string::String::new(),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("getSubnetDeployedByNonce"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "getSubnetDeployedByNonce",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("owner"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("nonce"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("uint64"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("subnet"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("getSubnetGetterFacet"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "getSubnetGetterFacet",
                            ),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::string::String::new(),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("getSubnetGetterSelectors"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "getSubnetGetterSelectors",
                            ),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::string::String::new(),
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
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("getSubnetManagerFacet"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "getSubnetManagerFacet",
                            ),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::string::String::new(),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("getSubnetManagerSelectors"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "getSubnetManagerSelectors",
                            ),
                            inputs: ::std::vec![],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::string::String::new(),
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
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("getUserLastNonce"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned("getUserLastNonce"),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("user"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("nonce"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Uint(64usize),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("uint64"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("latestSubnetDeployed"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "latestSubnetDeployed",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("owner"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            outputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("subnet"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                            ],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::View,
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("updateReferenceSubnetContract"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::Function {
                            name: ::std::borrow::ToOwned::to_owned(
                                "updateReferenceSubnetContract",
                            ),
                            inputs: ::std::vec![
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("newGetterFacet"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned("newManagerFacet"),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Address,
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("address"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned(
                                        "newSubnetGetterSelectors",
                                    ),
                                    kind: ::ethers::core::abi::ethabi::ParamType::Array(
                                        ::std::boxed::Box::new(
                                            ::ethers::core::abi::ethabi::ParamType::FixedBytes(4usize),
                                        ),
                                    ),
                                    internal_type: ::core::option::Option::Some(
                                        ::std::borrow::ToOwned::to_owned("bytes4[]"),
                                    ),
                                },
                                ::ethers::core::abi::ethabi::Param {
                                    name: ::std::borrow::ToOwned::to_owned(
                                        "newSubnetManagerSelectors",
                                    ),
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
                            outputs: ::std::vec![],
                            constant: ::core::option::Option::None,
                            state_mutability: ::ethers::core::abi::ethabi::StateMutability::NonPayable,
                        },
                    ],
                ),
            ]),
            events: ::std::collections::BTreeMap::new(),
            errors: ::core::convert::From::from([
                (
                    ::std::borrow::ToOwned::to_owned("CannotFindSubnet"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("CannotFindSubnet"),
                            inputs: ::std::vec![],
                        },
                    ],
                ),
                (
                    ::std::borrow::ToOwned::to_owned("NotOwner"),
                    ::std::vec![
                        ::ethers::core::abi::ethabi::AbiError {
                            name: ::std::borrow::ToOwned::to_owned("NotOwner"),
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
    pub static SUBNETGETTERFACET_ABI: ::ethers::contract::Lazy<
        ::ethers::core::abi::Abi,
    > = ::ethers::contract::Lazy::new(__abi);
    #[rustfmt::skip]
    const __BYTECODE: &[u8] = b"`\x80\x80`@R4a\0\x16Wa\x0C\0\x90\x81a\0\x1C\x829\xF3[`\0\x80\xFD\xFE`\x80`@\x81\x81R`\x04\x91\x826\x10\x15a\0\x16W`\0\x80\xFD[`\0\x92`\xE0\x90\x845\x82\x1C\x92\x83c\x03\x0F`Q\x14a\n\xA4WP\x82c\x11c\xDC\xA5\x14a\n?W\x82c@\x8D\xAC9\x14a\t#W\x82cB\xBF<\xC1\x14a\x08\xFAW\x82cZ\xA0\xECa\x14a\x08\xD0W\x82c\x95Ml\xCC\x14a\x06\xAEW\x82c\x986\xB7_\x14a\x06;W\x82c\xA4m\x04M\x14a\0\xB6WPPc\xE1D\xED\x82\x14a\0\x8BW`\0\x80\xFD[4a\0\xB2W\x81`\x03\x196\x01\x12a\0\xB2W`\x01T\x90Q`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x81R` \x90\xF3[P\x80\xFD[\x91P\x914a\x067W`\x806`\x03\x19\x01\x12a\x067Wa\0\xD2a\n\xE4V[`$\x92`\x01`\x01`\xA0\x1B\x03\x91\x845\x83\x81\x16\x91\x90\x82\x90\x03a\x063Wg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x90`D5\x82\x81\x11a\x06/Wa\x01\r\x906\x90\x86\x01a\x0BDV[\x97\x90\x92`d5\x81\x81\x11a\x06+Wa\x01'\x906\x90\x88\x01a\x0BDV[\x97\x90\x93\x81\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5T\x163\x03a\x06\x1BW\x16\x97\x88\x15a\x05\xDAW\x85\x15a\x05\x99W\x89\x15a\x05JW\x87\x15a\x04\xFAWPk\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF`\xA0\x1B\x94`\x01\x98\x86\x8AT\x16\x17\x89U`\x02\x95\x86T\x16\x17\x85U\x80\x89\x11a\x03\x93Wh\x01\0\0\0\0\0\0\0\0\x90\x81\x8A\x11a\x04\xE8W`\x03\x94\x8A\x86T\x81\x88U\x80\x82\x10a\x04bW[PP\x8C\x90\x9A\x86\x82R\x80\x87\x1C\x90\x82[\x82\x81\x10a\x04\x13WP`\x07\x19\x9C\x81\x8E\x16\x90\x91\x03\x90\x81a\x03\xA5W[PPPP\x87\x11a\x03\x93W\x86\x11a\x03\x82WP\x90\x84\x91\x84T\x83\x86U\x80\x84\x10a\x02\xF6W[P\x93\x89R\x1C\x94\x87[\x86\x81\x10a\x02\x94WP\x83\x16\x80\x84\x03\x93\x03a\x02$W\x86\x80\xF3[\x94\x86\x93\x92\x91\x93\x95\x87\x91[\x83\x83\x10a\x02VWPPPPPP`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x01U8\x80\x80\x80\x80\x80\x86\x80\xF3[\x90\x91\x92\x93` a\x02\x87\x87\x99a\x02k\x84\x99a\x0BuV[\x85\x1C\x90\x87\x87\x1B`\x03\x1B\x91c\xFF\xFF\xFF\xFF\x80\x91\x16\x83\x1B\x92\x1B\x19\x16\x17\x90V[\x98\x01\x95\x94\x93\x01\x91\x90a\x02.V[\x85\x90\x89\x8A[`\x08\x81\x10a\x02\xBAWP\x81`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x01U\x01a\x02\rV[\x95\x91\x92\x90a\x02\xE9` \x91a\x02\xCD\x85a\x0BuV[\x8D\x1C\x90\x89\x89\x1B`\x03\x1B\x91c\xFF\xFF\xFF\xFF\x80\x91\x16\x83\x1B\x92\x1B\x19\x16\x17\x90V[\x92\x01\x95\x01\x90\x87\x92\x91a\x02\x99V[\x90\x91\x92`\x07\x01\x83\x1C`\x07`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x92\x01\x84\x1C\x82\x01\x91`\x1C\x88\x87\x1B\x16\x80a\x03HW[P\x87\x94\x93\x92\x91\x89\x91\x01[\x82\x81\x10a\x03:WPPa\x02\x05V[\x8C\x81U\x88\x95P\x89\x91\x01a\x03,V[\x7F\x8A5\xAC\xFB\xC1_\xF8\x1A9\xAE}4O\xD7\t\xF2\x8E\x86\0\xB4\xAA\x8Ce\xC6\xB6K\xFE\x7F\xE3k\xD1\x9A\x83\x01\x90\x81T\x90`\0\x19\x90` \x03\x88\x1B\x1C\x16\x90U8a\x03\"V[cNH{q`\xE0\x1B\x8AR`A\x85R\x89\xFD[PcNH{q`\xE0\x1B\x8AR`A\x85R\x89\xFD[\x90\x8E\x8D\x8B\x86\x92[\x84\x84\x10a\x03\xD3WPPPPPP`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x01U\x8B8\x80\x80a\x01\xE4V[\x90\x85\x97\x84a\x04\x03\x93a\x03\xE9` \x96\x97\x98\x99a\x0BuV[\x90\x1C\x92\x1B`\x03\x1B\x91c\xFF\xFF\xFF\xFF\x80\x91\x16\x83\x1B\x92\x1B\x19\x16\x17\x90V[\x95\x01\x91\x01\x8F\x8B\x8F\x91\x94\x93\x94a\x03\xACV[\x90\x91\x92\x8E\x81\x90[`\x08\x82\x10a\x04AWPP`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x82\x01U\x8E\x92\x91\x90\x8C\x01a\x01\xCBV[\x81\x9F\x92\x8F\x92a\x04X\x91\x8E\x91` \x94a\x03\xE9\x88a\x0BuV[\x92\x01\x9E\x01\x8Fa\x04\x1AV[`\x07\x82\x01\x88\x1C\x90`\x1C`\x07`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x92\x01\x8A\x1C\x82\x01\x93\x8B\x1B\x16\x80a\x04\xAEW[P\x8C\x91\x01\x8F[\x83\x82\x10a\x04\xA3WPP\x8C\x91Pa\x01\xBDV[\x81U\x01\x8B\x90\x8Fa\x04\x92V[\x7F\xC2WZ\x0E\x9EY<\0\xF9Y\xF8\xC9/\x12\xDB(i\xC39Z;\x05\x02\xD0^%\x16Doq\xF8Z\x83\x01\x90\x81T\x90`\0\x19\x90` \x03\x8C\x1B\x1C\x16\x90U8a\x04\x8CV[cNH{q`\xE0\x1B\x8CR`A\x87R\x82\x8C\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`&\x81\x84\x01R\x7FSubnetManagerSelectors cannot be`D\x82\x01Re empty`\xD0\x1B`d\x82\x01R`\x84\x90\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`%\x81\x84\x01R\x7FSubnetGetterSelectors cannot be `D\x82\x01Rdempty`\xD8\x1B`d\x82\x01R`\x84\x90\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`\x1C\x81\x84\x01R\x7FInvalid managerFacet address\0\0\0\0`D\x82\x01R`d\x90\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`\x1B\x81\x84\x01R\x7FInvalid getterFacet address\0\0\0\0\0`D\x82\x01R`d\x90\xFD[\x89Qc0\xCDtq`\xE0\x1B\x81R\x88\x90\xFD[\x8B\x80\xFD[\x89\x80\xFD[\x87\x80\xFD[\x83\x80\xFD[\x83\x854a\x06\xABW\x81`\x03\x196\x01\x12a\x06\xABWa\x06Ua\n\xE4V[\x90`$5g\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x81\x16\x80\x91\x03a\0\xB2W`\x01`\x01`\xA0\x1B\x03\x92\x83\x16\x82R`\x05` \x90\x81R\x84\x83 \x91\x83RR\x82\x90 T\x16\x90\x81\x15a\x06\x9CW` \x92PQ\x90\x81R\xF3[Qc'nt\xA7`\xE1\x1B\x81R\x90P\xFD[\x80\xFD[\x84\x82\x854a\x08\xCCW\x82`\x03\x196\x01\x12a\x08\xCCW\x80Q\x80\x92`\x03T\x90\x81\x83R` \x80\x93\x01\x91`\x03\x87R`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x84\x88\x91[\x83`\x07\x84\x01\x10a\x08_WT\x93\x83\x83\x10a\x08BW[P\x82\x82\x10a\x08$W[\x82\x82\x10a\x08\x06W[\x82\x82\x10a\x07\xE8W[\x82\x82\x10a\x07\xCAW[\x82\x82\x10a\x07\xAEW[\x82\x82\x10a\x07\x92W[P\x10a\x07~W[P\x83\x90\x03`\x1F\x01`\x1F\x19\x16\x83\x01\x93\x90Pg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x84\x11\x83\x85\x10\x17a\x07kWP\x82\x91\x82a\x07g\x92R\x82a\n\xFFV[\x03\x90\xF3[cNH{q`\xE0\x1B\x81R`A\x85R`$\x90\xFD[`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x01\x80\x86a\x075V[\x83\x81\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07.V[\x83\x87\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07&V[``\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x1EV[`\x80\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x16V[`\xA0\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x0EV[`\xC0\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x06V[\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84\x8Aa\x06\xFDV[\x94`\x08\x91Pa\x01\0`\x01\x91\x87Tc\xFF\xFF\xFF\xFF`\xE0\x1B\x90\x81\x81\x8A\x1B\x16\x83R`\xC0\x82\x82\x82\x1B\x16\x8C\x85\x01R\x8C\x83\x83`\xA0\x92\x82\x82\x85\x1B\x16\x81\x89\x01R`\x80\x83\x83``\x82\x82\x85\x1B\x16\x81\x8D\x01R\x1B\x16\x90\x89\x01R\x1B\x16\x90\x85\x01R\x82\x82\x8D\x1B\x16\x90\x84\x01R\x16\x87\x82\x01R\x01\x95\x01\x91\x01\x90\x85\x90a\x06\xE9V[\x82\x80\xFD[PPP4a\0\xB2W\x81`\x03\x196\x01\x12a\0\xB2W`\x02T\x90Q`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x81R` \x90\xF3[PPP4a\0\xB2W\x81`\x03\x196\x01\x12a\0\xB2W\x90T\x90Q`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x81R` \x90\xF3[\x84\x82\x854a\x08\xCCW\x82`\x03\x196\x01\x12a\x08\xCCW\x80Q\x80\x92\x85T\x90\x81\x83R` \x80\x93\x01\x91\x87\x87R`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x84\x88\x91[\x83`\x07\x84\x01\x10a\t\xD2WT\x93\x83\x83\x10a\x08BWP\x82\x82\x10a\x08$W\x82\x82\x10a\x08\x06W\x82\x82\x10a\x07\xE8W\x82\x82\x10a\x07\xCAW\x82\x82\x10a\x07\xAEW\x82\x82\x10a\x07\x92WP\x10a\x07~WP\x83\x90\x03`\x1F\x01`\x1F\x19\x16\x83\x01\x93\x90Pg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x84\x11\x83\x85\x10\x17a\x07kWP\x82\x91\x82a\x07g\x92R\x82a\n\xFFV[\x94`\x08\x91Pa\x01\0`\x01\x91\x87Tc\xFF\xFF\xFF\xFF`\xE0\x1B\x90\x81\x81\x8A\x1B\x16\x83R`\xC0\x82\x82\x82\x1B\x16\x8C\x85\x01R\x8C\x83\x83`\xA0\x92\x82\x82\x85\x1B\x16\x81\x89\x01R`\x80\x83\x83``\x82\x82\x85\x1B\x16\x81\x8D\x01R\x1B\x16\x90\x89\x01R\x1B\x16\x90\x85\x01R\x82\x82\x8D\x1B\x16\x90\x84\x01R\x16\x87\x82\x01R\x01\x95\x01\x91\x01\x90\x85\x90a\t\\V[\x83\x854a\x06\xABW` 6`\x03\x19\x01\x12a\x06\xABW`\x01`\x01`\xA0\x1B\x03\x90\x82\x90\x82a\nfa\n\xE4V[\x16\x81R`\x06` Rg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF`\0\x19\x81\x84\x84 T\x16\x01\x16`\x05` R\x82\x82 \x90\x82R` R T\x16\x90\x81\x15a\x06\x9CW` \x92PQ\x90\x81R\xF3[\x85\x90\x854a\x08\xCCW` 6`\x03\x19\x01\x12a\x08\xCCW` \x92g\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x91\x90`\x01`\x01`\xA0\x1B\x03a\n\xD6a\n\xE4V[\x16\x81R`\x06\x85R T\x16\x81R\xF3[`\x045\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\n\xFAWV[`\0\x80\xFD[` \x90\x81`@\x81\x83\x01\x92\x82\x81R\x85Q\x80\x94R\x01\x93\x01\x91`\0[\x82\x81\x10a\x0B&WPPPP\x90V[\x83Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x93\x81\x01\x93\x92\x81\x01\x92`\x01\x01a\x0B\x18V[\x91\x81`\x1F\x84\x01\x12\x15a\n\xFAW\x825\x91g\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x83\x11a\n\xFAW` \x80\x85\x01\x94\x84`\x05\x1B\x01\x01\x11a\n\xFAWV[5`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x03a\n\xFAW\x90V\xFE\xC2WZ\x0E\x9EY<\0\xF9Y\xF8\xC9/\x12\xDB(i\xC39Z;\x05\x02\xD0^%\x16Doq\xF8[\x8A5\xAC\xFB\xC1_\xF8\x1A9\xAE}4O\xD7\t\xF2\x8E\x86\0\xB4\xAA\x8Ce\xC6\xB6K\xFE\x7F\xE3k\xD1\x9B\xA2dipfsX\"\x12 \xE7^)\xC9\xEAj\xD1\x94\x03\xC0\xF9j\x13\xBF\x8F\x91i\xB3A$\xC5\xB5\xADX\x0E\x82~2#\x01\x81\xB9dsolcC\0\x08\x13\x003";
    /// The bytecode of the contract.
    pub static SUBNETGETTERFACET_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __BYTECODE,
    );
    #[rustfmt::skip]
    const __DEPLOYED_BYTECODE: &[u8] = b"`\x80`@\x81\x81R`\x04\x91\x826\x10\x15a\0\x16W`\0\x80\xFD[`\0\x92`\xE0\x90\x845\x82\x1C\x92\x83c\x03\x0F`Q\x14a\n\xA4WP\x82c\x11c\xDC\xA5\x14a\n?W\x82c@\x8D\xAC9\x14a\t#W\x82cB\xBF<\xC1\x14a\x08\xFAW\x82cZ\xA0\xECa\x14a\x08\xD0W\x82c\x95Ml\xCC\x14a\x06\xAEW\x82c\x986\xB7_\x14a\x06;W\x82c\xA4m\x04M\x14a\0\xB6WPPc\xE1D\xED\x82\x14a\0\x8BW`\0\x80\xFD[4a\0\xB2W\x81`\x03\x196\x01\x12a\0\xB2W`\x01T\x90Q`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x81R` \x90\xF3[P\x80\xFD[\x91P\x914a\x067W`\x806`\x03\x19\x01\x12a\x067Wa\0\xD2a\n\xE4V[`$\x92`\x01`\x01`\xA0\x1B\x03\x91\x845\x83\x81\x16\x91\x90\x82\x90\x03a\x063Wg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x90`D5\x82\x81\x11a\x06/Wa\x01\r\x906\x90\x86\x01a\x0BDV[\x97\x90\x92`d5\x81\x81\x11a\x06+Wa\x01'\x906\x90\x88\x01a\x0BDV[\x97\x90\x93\x81\x7F\x80n\x0C\xBB\x9F\xCE)k\xBC3jH\xF4+\xF1\xDB\xC6\x97\"\xD1\x8D\x90\xD6\xFEp[u\x82\xC2\xBBK\xD5T\x163\x03a\x06\x1BW\x16\x97\x88\x15a\x05\xDAW\x85\x15a\x05\x99W\x89\x15a\x05JW\x87\x15a\x04\xFAWPk\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF`\xA0\x1B\x94`\x01\x98\x86\x8AT\x16\x17\x89U`\x02\x95\x86T\x16\x17\x85U\x80\x89\x11a\x03\x93Wh\x01\0\0\0\0\0\0\0\0\x90\x81\x8A\x11a\x04\xE8W`\x03\x94\x8A\x86T\x81\x88U\x80\x82\x10a\x04bW[PP\x8C\x90\x9A\x86\x82R\x80\x87\x1C\x90\x82[\x82\x81\x10a\x04\x13WP`\x07\x19\x9C\x81\x8E\x16\x90\x91\x03\x90\x81a\x03\xA5W[PPPP\x87\x11a\x03\x93W\x86\x11a\x03\x82WP\x90\x84\x91\x84T\x83\x86U\x80\x84\x10a\x02\xF6W[P\x93\x89R\x1C\x94\x87[\x86\x81\x10a\x02\x94WP\x83\x16\x80\x84\x03\x93\x03a\x02$W\x86\x80\xF3[\x94\x86\x93\x92\x91\x93\x95\x87\x91[\x83\x83\x10a\x02VWPPPPPP`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x01U8\x80\x80\x80\x80\x80\x86\x80\xF3[\x90\x91\x92\x93` a\x02\x87\x87\x99a\x02k\x84\x99a\x0BuV[\x85\x1C\x90\x87\x87\x1B`\x03\x1B\x91c\xFF\xFF\xFF\xFF\x80\x91\x16\x83\x1B\x92\x1B\x19\x16\x17\x90V[\x98\x01\x95\x94\x93\x01\x91\x90a\x02.V[\x85\x90\x89\x8A[`\x08\x81\x10a\x02\xBAWP\x81`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x01U\x01a\x02\rV[\x95\x91\x92\x90a\x02\xE9` \x91a\x02\xCD\x85a\x0BuV[\x8D\x1C\x90\x89\x89\x1B`\x03\x1B\x91c\xFF\xFF\xFF\xFF\x80\x91\x16\x83\x1B\x92\x1B\x19\x16\x17\x90V[\x92\x01\x95\x01\x90\x87\x92\x91a\x02\x99V[\x90\x91\x92`\x07\x01\x83\x1C`\x07`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x92\x01\x84\x1C\x82\x01\x91`\x1C\x88\x87\x1B\x16\x80a\x03HW[P\x87\x94\x93\x92\x91\x89\x91\x01[\x82\x81\x10a\x03:WPPa\x02\x05V[\x8C\x81U\x88\x95P\x89\x91\x01a\x03,V[\x7F\x8A5\xAC\xFB\xC1_\xF8\x1A9\xAE}4O\xD7\t\xF2\x8E\x86\0\xB4\xAA\x8Ce\xC6\xB6K\xFE\x7F\xE3k\xD1\x9A\x83\x01\x90\x81T\x90`\0\x19\x90` \x03\x88\x1B\x1C\x16\x90U8a\x03\"V[cNH{q`\xE0\x1B\x8AR`A\x85R\x89\xFD[PcNH{q`\xE0\x1B\x8AR`A\x85R\x89\xFD[\x90\x8E\x8D\x8B\x86\x92[\x84\x84\x10a\x03\xD3WPPPPPP`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x01U\x8B8\x80\x80a\x01\xE4V[\x90\x85\x97\x84a\x04\x03\x93a\x03\xE9` \x96\x97\x98\x99a\x0BuV[\x90\x1C\x92\x1B`\x03\x1B\x91c\xFF\xFF\xFF\xFF\x80\x91\x16\x83\x1B\x92\x1B\x19\x16\x17\x90V[\x95\x01\x91\x01\x8F\x8B\x8F\x91\x94\x93\x94a\x03\xACV[\x90\x91\x92\x8E\x81\x90[`\x08\x82\x10a\x04AWPP`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x82\x01U\x8E\x92\x91\x90\x8C\x01a\x01\xCBV[\x81\x9F\x92\x8F\x92a\x04X\x91\x8E\x91` \x94a\x03\xE9\x88a\x0BuV[\x92\x01\x9E\x01\x8Fa\x04\x1AV[`\x07\x82\x01\x88\x1C\x90`\x1C`\x07`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x92\x01\x8A\x1C\x82\x01\x93\x8B\x1B\x16\x80a\x04\xAEW[P\x8C\x91\x01\x8F[\x83\x82\x10a\x04\xA3WPP\x8C\x91Pa\x01\xBDV[\x81U\x01\x8B\x90\x8Fa\x04\x92V[\x7F\xC2WZ\x0E\x9EY<\0\xF9Y\xF8\xC9/\x12\xDB(i\xC39Z;\x05\x02\xD0^%\x16Doq\xF8Z\x83\x01\x90\x81T\x90`\0\x19\x90` \x03\x8C\x1B\x1C\x16\x90U8a\x04\x8CV[cNH{q`\xE0\x1B\x8CR`A\x87R\x82\x8C\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`&\x81\x84\x01R\x7FSubnetManagerSelectors cannot be`D\x82\x01Re empty`\xD0\x1B`d\x82\x01R`\x84\x90\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`%\x81\x84\x01R\x7FSubnetGetterSelectors cannot be `D\x82\x01Rdempty`\xD8\x1B`d\x82\x01R`\x84\x90\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`\x1C\x81\x84\x01R\x7FInvalid managerFacet address\0\0\0\0`D\x82\x01R`d\x90\xFD[QbF\x1B\xCD`\xE5\x1B\x81R` \x81\x88\x01R`\x1B\x81\x84\x01R\x7FInvalid getterFacet address\0\0\0\0\0`D\x82\x01R`d\x90\xFD[\x89Qc0\xCDtq`\xE0\x1B\x81R\x88\x90\xFD[\x8B\x80\xFD[\x89\x80\xFD[\x87\x80\xFD[\x83\x80\xFD[\x83\x854a\x06\xABW\x81`\x03\x196\x01\x12a\x06\xABWa\x06Ua\n\xE4V[\x90`$5g\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x81\x16\x80\x91\x03a\0\xB2W`\x01`\x01`\xA0\x1B\x03\x92\x83\x16\x82R`\x05` \x90\x81R\x84\x83 \x91\x83RR\x82\x90 T\x16\x90\x81\x15a\x06\x9CW` \x92PQ\x90\x81R\xF3[Qc'nt\xA7`\xE1\x1B\x81R\x90P\xFD[\x80\xFD[\x84\x82\x854a\x08\xCCW\x82`\x03\x196\x01\x12a\x08\xCCW\x80Q\x80\x92`\x03T\x90\x81\x83R` \x80\x93\x01\x91`\x03\x87R`\0\x80Q` a\x0B\x8B\x839\x81Q\x91R\x84\x88\x91[\x83`\x07\x84\x01\x10a\x08_WT\x93\x83\x83\x10a\x08BW[P\x82\x82\x10a\x08$W[\x82\x82\x10a\x08\x06W[\x82\x82\x10a\x07\xE8W[\x82\x82\x10a\x07\xCAW[\x82\x82\x10a\x07\xAEW[\x82\x82\x10a\x07\x92W[P\x10a\x07~W[P\x83\x90\x03`\x1F\x01`\x1F\x19\x16\x83\x01\x93\x90Pg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x84\x11\x83\x85\x10\x17a\x07kWP\x82\x91\x82a\x07g\x92R\x82a\n\xFFV[\x03\x90\xF3[cNH{q`\xE0\x1B\x81R`A\x85R`$\x90\xFD[`\x01`\x01`\xE0\x1B\x03\x19\x16\x81R\x01\x80\x86a\x075V[\x83\x81\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07.V[\x83\x87\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07&V[``\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x1EV[`\x80\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x16V[`\xA0\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x0EV[`\xC0\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84a\x07\x06V[\x84\x90\x1B`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x90\x93\x01\x92`\x01\x01\x84\x8Aa\x06\xFDV[\x94`\x08\x91Pa\x01\0`\x01\x91\x87Tc\xFF\xFF\xFF\xFF`\xE0\x1B\x90\x81\x81\x8A\x1B\x16\x83R`\xC0\x82\x82\x82\x1B\x16\x8C\x85\x01R\x8C\x83\x83`\xA0\x92\x82\x82\x85\x1B\x16\x81\x89\x01R`\x80\x83\x83``\x82\x82\x85\x1B\x16\x81\x8D\x01R\x1B\x16\x90\x89\x01R\x1B\x16\x90\x85\x01R\x82\x82\x8D\x1B\x16\x90\x84\x01R\x16\x87\x82\x01R\x01\x95\x01\x91\x01\x90\x85\x90a\x06\xE9V[\x82\x80\xFD[PPP4a\0\xB2W\x81`\x03\x196\x01\x12a\0\xB2W`\x02T\x90Q`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x81R` \x90\xF3[PPP4a\0\xB2W\x81`\x03\x196\x01\x12a\0\xB2W\x90T\x90Q`\x01`\x01`\xA0\x1B\x03\x90\x91\x16\x81R` \x90\xF3[\x84\x82\x854a\x08\xCCW\x82`\x03\x196\x01\x12a\x08\xCCW\x80Q\x80\x92\x85T\x90\x81\x83R` \x80\x93\x01\x91\x87\x87R`\0\x80Q` a\x0B\xAB\x839\x81Q\x91R\x84\x88\x91[\x83`\x07\x84\x01\x10a\t\xD2WT\x93\x83\x83\x10a\x08BWP\x82\x82\x10a\x08$W\x82\x82\x10a\x08\x06W\x82\x82\x10a\x07\xE8W\x82\x82\x10a\x07\xCAW\x82\x82\x10a\x07\xAEW\x82\x82\x10a\x07\x92WP\x10a\x07~WP\x83\x90\x03`\x1F\x01`\x1F\x19\x16\x83\x01\x93\x90Pg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x84\x11\x83\x85\x10\x17a\x07kWP\x82\x91\x82a\x07g\x92R\x82a\n\xFFV[\x94`\x08\x91Pa\x01\0`\x01\x91\x87Tc\xFF\xFF\xFF\xFF`\xE0\x1B\x90\x81\x81\x8A\x1B\x16\x83R`\xC0\x82\x82\x82\x1B\x16\x8C\x85\x01R\x8C\x83\x83`\xA0\x92\x82\x82\x85\x1B\x16\x81\x89\x01R`\x80\x83\x83``\x82\x82\x85\x1B\x16\x81\x8D\x01R\x1B\x16\x90\x89\x01R\x1B\x16\x90\x85\x01R\x82\x82\x8D\x1B\x16\x90\x84\x01R\x16\x87\x82\x01R\x01\x95\x01\x91\x01\x90\x85\x90a\t\\V[\x83\x854a\x06\xABW` 6`\x03\x19\x01\x12a\x06\xABW`\x01`\x01`\xA0\x1B\x03\x90\x82\x90\x82a\nfa\n\xE4V[\x16\x81R`\x06` Rg\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF`\0\x19\x81\x84\x84 T\x16\x01\x16`\x05` R\x82\x82 \x90\x82R` R T\x16\x90\x81\x15a\x06\x9CW` \x92PQ\x90\x81R\xF3[\x85\x90\x854a\x08\xCCW` 6`\x03\x19\x01\x12a\x08\xCCW` \x92g\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x91\x90`\x01`\x01`\xA0\x1B\x03a\n\xD6a\n\xE4V[\x16\x81R`\x06\x85R T\x16\x81R\xF3[`\x045\x90`\x01`\x01`\xA0\x1B\x03\x82\x16\x82\x03a\n\xFAWV[`\0\x80\xFD[` \x90\x81`@\x81\x83\x01\x92\x82\x81R\x85Q\x80\x94R\x01\x93\x01\x91`\0[\x82\x81\x10a\x0B&WPPPP\x90V[\x83Q`\x01`\x01`\xE0\x1B\x03\x19\x16\x85R\x93\x81\x01\x93\x92\x81\x01\x92`\x01\x01a\x0B\x18V[\x91\x81`\x1F\x84\x01\x12\x15a\n\xFAW\x825\x91g\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x83\x11a\n\xFAW` \x80\x85\x01\x94\x84`\x05\x1B\x01\x01\x11a\n\xFAWV[5`\x01`\x01`\xE0\x1B\x03\x19\x81\x16\x81\x03a\n\xFAW\x90V\xFE\xC2WZ\x0E\x9EY<\0\xF9Y\xF8\xC9/\x12\xDB(i\xC39Z;\x05\x02\xD0^%\x16Doq\xF8[\x8A5\xAC\xFB\xC1_\xF8\x1A9\xAE}4O\xD7\t\xF2\x8E\x86\0\xB4\xAA\x8Ce\xC6\xB6K\xFE\x7F\xE3k\xD1\x9B\xA2dipfsX\"\x12 \xE7^)\xC9\xEAj\xD1\x94\x03\xC0\xF9j\x13\xBF\x8F\x91i\xB3A$\xC5\xB5\xADX\x0E\x82~2#\x01\x81\xB9dsolcC\0\x08\x13\x003";
    /// The deployed bytecode of the contract.
    pub static SUBNETGETTERFACET_DEPLOYED_BYTECODE: ::ethers::core::types::Bytes = ::ethers::core::types::Bytes::from_static(
        __DEPLOYED_BYTECODE,
    );
    pub struct SubnetGetterFacet<M>(::ethers::contract::Contract<M>);
    impl<M> ::core::clone::Clone for SubnetGetterFacet<M> {
        fn clone(&self) -> Self {
            Self(::core::clone::Clone::clone(&self.0))
        }
    }
    impl<M> ::core::ops::Deref for SubnetGetterFacet<M> {
        type Target = ::ethers::contract::Contract<M>;
        fn deref(&self) -> &Self::Target {
            &self.0
        }
    }
    impl<M> ::core::ops::DerefMut for SubnetGetterFacet<M> {
        fn deref_mut(&mut self) -> &mut Self::Target {
            &mut self.0
        }
    }
    impl<M> ::core::fmt::Debug for SubnetGetterFacet<M> {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            f.debug_tuple(::core::stringify!(SubnetGetterFacet))
                .field(&self.address())
                .finish()
        }
    }
    impl<M: ::ethers::providers::Middleware> SubnetGetterFacet<M> {
        /// Creates a new contract instance with the specified `ethers` client at
        /// `address`. The contract derefs to a `ethers::Contract` object.
        pub fn new<T: Into<::ethers::core::types::Address>>(
            address: T,
            client: ::std::sync::Arc<M>,
        ) -> Self {
            Self(
                ::ethers::contract::Contract::new(
                    address.into(),
                    SUBNETGETTERFACET_ABI.clone(),
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
                SUBNETGETTERFACET_ABI.clone(),
                SUBNETGETTERFACET_BYTECODE.clone().into(),
                client,
            );
            let deployer = factory.deploy(constructor_args)?;
            let deployer = ::ethers::contract::ContractDeployer::new(deployer);
            Ok(deployer)
        }
        ///Calls the contract's `getGateway` (0x42bf3cc1) function
        pub fn get_gateway(
            &self,
        ) -> ::ethers::contract::builders::ContractCall<
            M,
            ::ethers::core::types::Address,
        > {
            self.0
                .method_hash([66, 191, 60, 193], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getSubnetDeployedByNonce` (0x9836b75f) function
        pub fn get_subnet_deployed_by_nonce(
            &self,
            owner: ::ethers::core::types::Address,
            nonce: u64,
        ) -> ::ethers::contract::builders::ContractCall<
            M,
            ::ethers::core::types::Address,
        > {
            self.0
                .method_hash([152, 54, 183, 95], (owner, nonce))
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getSubnetGetterFacet` (0xe144ed82) function
        pub fn get_subnet_getter_facet(
            &self,
        ) -> ::ethers::contract::builders::ContractCall<
            M,
            ::ethers::core::types::Address,
        > {
            self.0
                .method_hash([225, 68, 237, 130], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getSubnetGetterSelectors` (0x954d6ccc) function
        pub fn get_subnet_getter_selectors(
            &self,
        ) -> ::ethers::contract::builders::ContractCall<M, ::std::vec::Vec<[u8; 4]>> {
            self.0
                .method_hash([149, 77, 108, 204], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getSubnetManagerFacet` (0x5aa0ec61) function
        pub fn get_subnet_manager_facet(
            &self,
        ) -> ::ethers::contract::builders::ContractCall<
            M,
            ::ethers::core::types::Address,
        > {
            self.0
                .method_hash([90, 160, 236, 97], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getSubnetManagerSelectors` (0x408dac39) function
        pub fn get_subnet_manager_selectors(
            &self,
        ) -> ::ethers::contract::builders::ContractCall<M, ::std::vec::Vec<[u8; 4]>> {
            self.0
                .method_hash([64, 141, 172, 57], ())
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `getUserLastNonce` (0x030f6051) function
        pub fn get_user_last_nonce(
            &self,
            user: ::ethers::core::types::Address,
        ) -> ::ethers::contract::builders::ContractCall<M, u64> {
            self.0
                .method_hash([3, 15, 96, 81], user)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `latestSubnetDeployed` (0x1163dca5) function
        pub fn latest_subnet_deployed(
            &self,
            owner: ::ethers::core::types::Address,
        ) -> ::ethers::contract::builders::ContractCall<
            M,
            ::ethers::core::types::Address,
        > {
            self.0
                .method_hash([17, 99, 220, 165], owner)
                .expect("method not found (this should never happen)")
        }
        ///Calls the contract's `updateReferenceSubnetContract` (0xa46d044d) function
        pub fn update_reference_subnet_contract(
            &self,
            new_getter_facet: ::ethers::core::types::Address,
            new_manager_facet: ::ethers::core::types::Address,
            new_subnet_getter_selectors: ::std::vec::Vec<[u8; 4]>,
            new_subnet_manager_selectors: ::std::vec::Vec<[u8; 4]>,
        ) -> ::ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash(
                    [164, 109, 4, 77],
                    (
                        new_getter_facet,
                        new_manager_facet,
                        new_subnet_getter_selectors,
                        new_subnet_manager_selectors,
                    ),
                )
                .expect("method not found (this should never happen)")
        }
    }
    impl<M: ::ethers::providers::Middleware> From<::ethers::contract::Contract<M>>
    for SubnetGetterFacet<M> {
        fn from(contract: ::ethers::contract::Contract<M>) -> Self {
            Self::new(contract.address(), contract.client())
        }
    }
    ///Custom Error type `CannotFindSubnet` with signature `CannotFindSubnet()` and selector `0x4edce94e`
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
    #[etherror(name = "CannotFindSubnet", abi = "CannotFindSubnet()")]
    pub struct CannotFindSubnet;
    ///Custom Error type `NotOwner` with signature `NotOwner()` and selector `0x30cd7471`
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
    #[etherror(name = "NotOwner", abi = "NotOwner()")]
    pub struct NotOwner;
    ///Container type for all of the contract's custom errors
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetGetterFacetErrors {
        CannotFindSubnet(CannotFindSubnet),
        NotOwner(NotOwner),
        /// The standard solidity revert string, with selector
        /// Error(string) -- 0x08c379a0
        RevertString(::std::string::String),
    }
    impl ::ethers::core::abi::AbiDecode for SubnetGetterFacetErrors {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) = <::std::string::String as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::RevertString(decoded));
            }
            if let Ok(decoded) = <CannotFindSubnet as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::CannotFindSubnet(decoded));
            }
            if let Ok(decoded) = <NotOwner as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::NotOwner(decoded));
            }
            Err(::ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ::ethers::core::abi::AbiEncode for SubnetGetterFacetErrors {
        fn encode(self) -> ::std::vec::Vec<u8> {
            match self {
                Self::CannotFindSubnet(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::NotOwner(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::RevertString(s) => ::ethers::core::abi::AbiEncode::encode(s),
            }
        }
    }
    impl ::ethers::contract::ContractRevert for SubnetGetterFacetErrors {
        fn valid_selector(selector: [u8; 4]) -> bool {
            match selector {
                [0x08, 0xc3, 0x79, 0xa0] => true,
                _ if selector
                    == <CannotFindSubnet as ::ethers::contract::EthError>::selector() => {
                    true
                }
                _ if selector
                    == <NotOwner as ::ethers::contract::EthError>::selector() => true,
                _ => false,
            }
        }
    }
    impl ::core::fmt::Display for SubnetGetterFacetErrors {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::CannotFindSubnet(element) => ::core::fmt::Display::fmt(element, f),
                Self::NotOwner(element) => ::core::fmt::Display::fmt(element, f),
                Self::RevertString(s) => ::core::fmt::Display::fmt(s, f),
            }
        }
    }
    impl ::core::convert::From<::std::string::String> for SubnetGetterFacetErrors {
        fn from(value: String) -> Self {
            Self::RevertString(value)
        }
    }
    impl ::core::convert::From<CannotFindSubnet> for SubnetGetterFacetErrors {
        fn from(value: CannotFindSubnet) -> Self {
            Self::CannotFindSubnet(value)
        }
    }
    impl ::core::convert::From<NotOwner> for SubnetGetterFacetErrors {
        fn from(value: NotOwner) -> Self {
            Self::NotOwner(value)
        }
    }
    ///Container type for all input parameters for the `getGateway` function with signature `getGateway()` and selector `0x42bf3cc1`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "getGateway", abi = "getGateway()")]
    pub struct GetGatewayCall;
    ///Container type for all input parameters for the `getSubnetDeployedByNonce` function with signature `getSubnetDeployedByNonce(address,uint64)` and selector `0x9836b75f`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(
        name = "getSubnetDeployedByNonce",
        abi = "getSubnetDeployedByNonce(address,uint64)"
    )]
    pub struct GetSubnetDeployedByNonceCall {
        pub owner: ::ethers::core::types::Address,
        pub nonce: u64,
    }
    ///Container type for all input parameters for the `getSubnetGetterFacet` function with signature `getSubnetGetterFacet()` and selector `0xe144ed82`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "getSubnetGetterFacet", abi = "getSubnetGetterFacet()")]
    pub struct GetSubnetGetterFacetCall;
    ///Container type for all input parameters for the `getSubnetGetterSelectors` function with signature `getSubnetGetterSelectors()` and selector `0x954d6ccc`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "getSubnetGetterSelectors", abi = "getSubnetGetterSelectors()")]
    pub struct GetSubnetGetterSelectorsCall;
    ///Container type for all input parameters for the `getSubnetManagerFacet` function with signature `getSubnetManagerFacet()` and selector `0x5aa0ec61`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "getSubnetManagerFacet", abi = "getSubnetManagerFacet()")]
    pub struct GetSubnetManagerFacetCall;
    ///Container type for all input parameters for the `getSubnetManagerSelectors` function with signature `getSubnetManagerSelectors()` and selector `0x408dac39`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "getSubnetManagerSelectors", abi = "getSubnetManagerSelectors()")]
    pub struct GetSubnetManagerSelectorsCall;
    ///Container type for all input parameters for the `getUserLastNonce` function with signature `getUserLastNonce(address)` and selector `0x030f6051`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "getUserLastNonce", abi = "getUserLastNonce(address)")]
    pub struct GetUserLastNonceCall {
        pub user: ::ethers::core::types::Address,
    }
    ///Container type for all input parameters for the `latestSubnetDeployed` function with signature `latestSubnetDeployed(address)` and selector `0x1163dca5`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(name = "latestSubnetDeployed", abi = "latestSubnetDeployed(address)")]
    pub struct LatestSubnetDeployedCall {
        pub owner: ::ethers::core::types::Address,
    }
    ///Container type for all input parameters for the `updateReferenceSubnetContract` function with signature `updateReferenceSubnetContract(address,address,bytes4[],bytes4[])` and selector `0xa46d044d`
    #[derive(
        Clone,
        ::ethers::contract::EthCall,
        ::ethers::contract::EthDisplay,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    #[ethcall(
        name = "updateReferenceSubnetContract",
        abi = "updateReferenceSubnetContract(address,address,bytes4[],bytes4[])"
    )]
    pub struct UpdateReferenceSubnetContractCall {
        pub new_getter_facet: ::ethers::core::types::Address,
        pub new_manager_facet: ::ethers::core::types::Address,
        pub new_subnet_getter_selectors: ::std::vec::Vec<[u8; 4]>,
        pub new_subnet_manager_selectors: ::std::vec::Vec<[u8; 4]>,
    }
    ///Container type for all of the contract's call
    #[derive(Clone, ::ethers::contract::EthAbiType, Debug, PartialEq, Eq, Hash)]
    pub enum SubnetGetterFacetCalls {
        GetGateway(GetGatewayCall),
        GetSubnetDeployedByNonce(GetSubnetDeployedByNonceCall),
        GetSubnetGetterFacet(GetSubnetGetterFacetCall),
        GetSubnetGetterSelectors(GetSubnetGetterSelectorsCall),
        GetSubnetManagerFacet(GetSubnetManagerFacetCall),
        GetSubnetManagerSelectors(GetSubnetManagerSelectorsCall),
        GetUserLastNonce(GetUserLastNonceCall),
        LatestSubnetDeployed(LatestSubnetDeployedCall),
        UpdateReferenceSubnetContract(UpdateReferenceSubnetContractCall),
    }
    impl ::ethers::core::abi::AbiDecode for SubnetGetterFacetCalls {
        fn decode(
            data: impl AsRef<[u8]>,
        ) -> ::core::result::Result<Self, ::ethers::core::abi::AbiError> {
            let data = data.as_ref();
            if let Ok(decoded) = <GetGatewayCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetGateway(decoded));
            }
            if let Ok(decoded) = <GetSubnetDeployedByNonceCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetSubnetDeployedByNonce(decoded));
            }
            if let Ok(decoded) = <GetSubnetGetterFacetCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetSubnetGetterFacet(decoded));
            }
            if let Ok(decoded) = <GetSubnetGetterSelectorsCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetSubnetGetterSelectors(decoded));
            }
            if let Ok(decoded) = <GetSubnetManagerFacetCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetSubnetManagerFacet(decoded));
            }
            if let Ok(decoded) = <GetSubnetManagerSelectorsCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetSubnetManagerSelectors(decoded));
            }
            if let Ok(decoded) = <GetUserLastNonceCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::GetUserLastNonce(decoded));
            }
            if let Ok(decoded) = <LatestSubnetDeployedCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::LatestSubnetDeployed(decoded));
            }
            if let Ok(decoded) = <UpdateReferenceSubnetContractCall as ::ethers::core::abi::AbiDecode>::decode(
                data,
            ) {
                return Ok(Self::UpdateReferenceSubnetContract(decoded));
            }
            Err(::ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ::ethers::core::abi::AbiEncode for SubnetGetterFacetCalls {
        fn encode(self) -> Vec<u8> {
            match self {
                Self::GetGateway(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::GetSubnetDeployedByNonce(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::GetSubnetGetterFacet(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::GetSubnetGetterSelectors(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::GetSubnetManagerFacet(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::GetSubnetManagerSelectors(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::GetUserLastNonce(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::LatestSubnetDeployed(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
                Self::UpdateReferenceSubnetContract(element) => {
                    ::ethers::core::abi::AbiEncode::encode(element)
                }
            }
        }
    }
    impl ::core::fmt::Display for SubnetGetterFacetCalls {
        fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
            match self {
                Self::GetGateway(element) => ::core::fmt::Display::fmt(element, f),
                Self::GetSubnetDeployedByNonce(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::GetSubnetGetterFacet(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::GetSubnetGetterSelectors(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::GetSubnetManagerFacet(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::GetSubnetManagerSelectors(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::GetUserLastNonce(element) => ::core::fmt::Display::fmt(element, f),
                Self::LatestSubnetDeployed(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
                Self::UpdateReferenceSubnetContract(element) => {
                    ::core::fmt::Display::fmt(element, f)
                }
            }
        }
    }
    impl ::core::convert::From<GetGatewayCall> for SubnetGetterFacetCalls {
        fn from(value: GetGatewayCall) -> Self {
            Self::GetGateway(value)
        }
    }
    impl ::core::convert::From<GetSubnetDeployedByNonceCall> for SubnetGetterFacetCalls {
        fn from(value: GetSubnetDeployedByNonceCall) -> Self {
            Self::GetSubnetDeployedByNonce(value)
        }
    }
    impl ::core::convert::From<GetSubnetGetterFacetCall> for SubnetGetterFacetCalls {
        fn from(value: GetSubnetGetterFacetCall) -> Self {
            Self::GetSubnetGetterFacet(value)
        }
    }
    impl ::core::convert::From<GetSubnetGetterSelectorsCall> for SubnetGetterFacetCalls {
        fn from(value: GetSubnetGetterSelectorsCall) -> Self {
            Self::GetSubnetGetterSelectors(value)
        }
    }
    impl ::core::convert::From<GetSubnetManagerFacetCall> for SubnetGetterFacetCalls {
        fn from(value: GetSubnetManagerFacetCall) -> Self {
            Self::GetSubnetManagerFacet(value)
        }
    }
    impl ::core::convert::From<GetSubnetManagerSelectorsCall>
    for SubnetGetterFacetCalls {
        fn from(value: GetSubnetManagerSelectorsCall) -> Self {
            Self::GetSubnetManagerSelectors(value)
        }
    }
    impl ::core::convert::From<GetUserLastNonceCall> for SubnetGetterFacetCalls {
        fn from(value: GetUserLastNonceCall) -> Self {
            Self::GetUserLastNonce(value)
        }
    }
    impl ::core::convert::From<LatestSubnetDeployedCall> for SubnetGetterFacetCalls {
        fn from(value: LatestSubnetDeployedCall) -> Self {
            Self::LatestSubnetDeployed(value)
        }
    }
    impl ::core::convert::From<UpdateReferenceSubnetContractCall>
    for SubnetGetterFacetCalls {
        fn from(value: UpdateReferenceSubnetContractCall) -> Self {
            Self::UpdateReferenceSubnetContract(value)
        }
    }
    ///Container type for all return fields from the `getGateway` function with signature `getGateway()` and selector `0x42bf3cc1`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetGatewayReturn(pub ::ethers::core::types::Address);
    ///Container type for all return fields from the `getSubnetDeployedByNonce` function with signature `getSubnetDeployedByNonce(address,uint64)` and selector `0x9836b75f`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetSubnetDeployedByNonceReturn {
        pub subnet: ::ethers::core::types::Address,
    }
    ///Container type for all return fields from the `getSubnetGetterFacet` function with signature `getSubnetGetterFacet()` and selector `0xe144ed82`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetSubnetGetterFacetReturn(pub ::ethers::core::types::Address);
    ///Container type for all return fields from the `getSubnetGetterSelectors` function with signature `getSubnetGetterSelectors()` and selector `0x954d6ccc`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetSubnetGetterSelectorsReturn(pub ::std::vec::Vec<[u8; 4]>);
    ///Container type for all return fields from the `getSubnetManagerFacet` function with signature `getSubnetManagerFacet()` and selector `0x5aa0ec61`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetSubnetManagerFacetReturn(pub ::ethers::core::types::Address);
    ///Container type for all return fields from the `getSubnetManagerSelectors` function with signature `getSubnetManagerSelectors()` and selector `0x408dac39`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetSubnetManagerSelectorsReturn(pub ::std::vec::Vec<[u8; 4]>);
    ///Container type for all return fields from the `getUserLastNonce` function with signature `getUserLastNonce(address)` and selector `0x030f6051`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct GetUserLastNonceReturn {
        pub nonce: u64,
    }
    ///Container type for all return fields from the `latestSubnetDeployed` function with signature `latestSubnetDeployed(address)` and selector `0x1163dca5`
    #[derive(
        Clone,
        ::ethers::contract::EthAbiType,
        ::ethers::contract::EthAbiCodec,
        Default,
        Debug,
        PartialEq,
        Eq,
        Hash
    )]
    pub struct LatestSubnetDeployedReturn {
        pub subnet: ::ethers::core::types::Address,
    }
}
