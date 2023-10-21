// DO NOT EDIT! This file was generated by build.rs
#[macro_use]
mod convert;
#[allow(clippy::all)]
pub mod gateway_diamond;
#[allow(clippy::all)]
pub mod gateway_getter_facet;
#[allow(clippy::all)]
pub mod gateway_manager_facet;
#[allow(clippy::all)]
pub mod gateway_messenger_facet;
#[allow(clippy::all)]
pub mod gateway_router_facet;
#[allow(clippy::all)]
pub mod i_diamond;
#[allow(clippy::all)]
pub mod subnet_actor_diamond;
#[allow(clippy::all)]
pub mod subnet_actor_getter_facet;
#[allow(clippy::all)]
pub mod subnet_actor_manager_facet;
#[allow(clippy::all)]
pub mod subnet_registry;

// The list of contracts need to convert FvmAddress to fvm_shared::Address
fvm_address_conversion!(gateway_manager_facet);
fvm_address_conversion!(gateway_getter_facet);
fvm_address_conversion!(gateway_router_facet);
fvm_address_conversion!(gateway_messenger_facet);
fvm_address_conversion!(subnet_actor_manager_facet);

// The list of contracts that need to convert common types between each other
common_type_conversion!(gateway_getter_facet, subnet_actor_manager_facet);
common_type_conversion!(subnet_actor_getter_facet, gateway_router_facet);
