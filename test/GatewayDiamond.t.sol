// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "forge-std/StdInvariant.sol";
import "../src/Gateway.sol";
import "../src/SubnetActor.sol";
import "../src/lib/SubnetIDHelper.sol";
import "../src/lib/CheckpointHelper.sol";
import "../src/lib/CrossMsgHelper.sol";
import "../src/structs/FvmAddress.sol";
import "../src/GatewayDiamond.sol";
import {IDiamond} from "../src//interfaces/IDiamond.sol";
import {IDiamondCut} from "../src//interfaces/IDiamondCut.sol";
import {RouterFacet} from "../src/facets/RouterFacet.sol";
import {SubnetManagerFacet} from "../src/facets/SubnetManagerFacet.sol";
import {InfoFacet} from "../src/facets/InfoFacet.sol";

contract GatewayDiamondDeploymentTest is StdInvariant, Test {
    using SubnetIDHelper for SubnetID;
    using CheckpointHelper for BottomUpCheckpoint;
    using CrossMsgHelper for CrossMsg;
    using StorableMsgHelper for StorableMsg;

    uint64 constant MIN_COLLATERAL_AMOUNT = 1 ether;
    uint64 constant MAX_NONCE = type(uint64).max;
    address constant BLS_ACCOUNT_ADDREESS = address(0xfF000000000000000000000000000000bEefbEEf);
    bytes32 private constant DEFAULT_NETWORK_NAME = bytes32("test");
    uint64 private constant DEFAULT_MIN_VALIDATORS = 1;
    uint8 private constant DEFAULT_MAJORITY_PERCENTAGE = 70;
    uint64 constant DEFAULT_CHECKPOINT_PERIOD = 10;
    string private constant DEFAULT_NET_ADDR = "netAddr";
    bytes private constant GENESIS = EMPTY_BYTES;
    uint256 constant CROSS_MSG_FEE = 10 gwei;
    address constant CHILD_NETWORK_ADDRESS = address(10);
    address constant CHILD_NETWORK_ADDRESS_2 = address(11);
    uint64 constant EPOCH_ONE = 1 * DEFAULT_CHECKPOINT_PERIOD;
    uint256 constant INITIAL_VALIDATOR_FUNDS = 1 ether;

    bytes4[] routerSelectors;
    bytes4[] managerSelectors;
    bytes4[] infoSelectors;

    GatewayDiamond gatewayDiamond;
    SubnetManagerFacet gwManager;
    InfoFacet gwInfo;
    RouterFacet gwRouter;

    GatewayDiamond gatewayDiamond2;
    SubnetManagerFacet gwManager2;
    InfoFacet gwInfo2;
    RouterFacet gwRouter2;

    SubnetActor sa;

    uint64 private constant ROOTNET_CHAINID = 123;
    address public constant ROOTNET_ADDRESS = address(1);

    address private constant TOPDOWN_VALIDATOR_1 = address(12);

    error NotSystemActor();
    error NotSignableAccount();
    error NotEnoughFee();
    error NotEnoughFunds();
    error NotEnoughFundsToRelease();
    error CannotReleaseZero();
    error NotEnoughBalance();
    error NotInitialized();
    error NotValidator();
    error NotEnoughSubnetCircSupply();
    error NotEmptySubnetCircSupply();
    error NotRegisteredSubnet();
    error AlreadyRegisteredSubnet();
    error AlreadyInitialized();
    error AlreadyCommittedCheckpoint();
    error InconsistentPrevCheckpoint();
    error InvalidPostboxOwner();
    error InvalidCheckpointEpoch();
    error InvalidCheckpointSource();
    error InvalidCrossMsgNonce();
    error InvalidCrossMsgDestinationSubnet();
    error InvalidCrossMsgDestinationAddress();
    error InvalidCrossMsgsSortOrder();
    error InvalidCrossMsgFromSubnetId();
    error InvalidCrossMsgFromRawAddress();
    error CannotSendCrossMsgToItself();
    error SubnetNotActive();
    error PostboxNotExist();
    error ValidatorAlreadyVoted();
    error MessagesNotSorted();
    error ValidatorsAndWeightsLengthMismatch();
    error ValidatorWeightIsZero();
    error NotEnoughFundsForMembership();
    error EpochNotVotable();
    error EpochAlreadyExecuted();

    constructor() {
        routerSelectors = generateSelectors("RouterFacet");
        infoSelectors = generateSelectors("InfoFacet");
        managerSelectors = generateSelectors("SubnetManagerFacet");
    }

    function createDiamond(GatewayDiamond.ConstructorParams memory params) public returns (GatewayDiamond) {
        gwRouter = new RouterFacet();
        gwManager = new SubnetManagerFacet();
        gwInfo = new InfoFacet();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](3);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(gwRouter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: routerSelectors
            })
        );

        diamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(gwManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: managerSelectors
            })
        );

        diamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(gwInfo),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: infoSelectors
            })
        );

        gatewayDiamond = new GatewayDiamond(diamondCut, params);

        return gatewayDiamond;
    }

    function setUp() public {
        address[] memory path = new address[](1);
        path[0] = ROOTNET_ADDRESS;

        address[] memory path2 = new address[](2);
        path2[0] = CHILD_NETWORK_ADDRESS;
        path2[1] = CHILD_NETWORK_ADDRESS_2;

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });

        gwRouter = new RouterFacet();
        gwManager = new SubnetManagerFacet();
        gwInfo = new InfoFacet();

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](3);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(gwRouter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: routerSelectors
            })
        );

        diamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(gwManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: managerSelectors
            })
        );

        diamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(gwInfo),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: infoSelectors
            })
        );

        gatewayDiamond = new GatewayDiamond(diamondCut, constructorParams);
        gwInfo = InfoFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwRouter = RouterFacet(address(gatewayDiamond));

        addValidator(TOPDOWN_VALIDATOR_1, 100);

        constructorParams.networkName = SubnetID({root: ROOTNET_CHAINID, route: path2});

        gatewayDiamond2 = new GatewayDiamond(diamondCut, constructorParams);
        gwInfo2 = InfoFacet(address(gatewayDiamond2));
        gwManager2 = SubnetManagerFacet(address(gatewayDiamond2));
        gwRouter2 = RouterFacet(address(gatewayDiamond2));

        SubnetActor.ConstructParams memory subnetConstructorParams = SubnetActor.ConstructParams({
            parentId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            name: DEFAULT_NETWORK_NAME,
            ipcGatewayAddr: address(gatewayDiamond),
            consensus: ConsensusType.Mir,
            minActivationCollateral: MIN_COLLATERAL_AMOUNT,
            minValidators: DEFAULT_MIN_VALIDATORS,
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE,
            genesis: GENESIS
        });
        sa = new SubnetActor(subnetConstructorParams);

        targetContract(address(gatewayDiamond));
    }

    function invariant_CrossMsgFee() public view {
        require(gwInfo.crossMsgFee() == CROSS_MSG_FEE);
    }

    function testGatewayDiamond_GatewayDiamond_Constructor() public view {
        require(gwInfo.totalSubnets() == 0, "totalSubnets");
        require(gwInfo.bottomUpNonce() == 0, "bottomUpNonce");
        require(gwInfo.minStake() == MIN_COLLATERAL_AMOUNT, "minStake");

        require(gwInfo.crossMsgFee() == CROSS_MSG_FEE, "crossMsgFee");
        require(gwInfo.bottomUpCheckPeriod() == DEFAULT_CHECKPOINT_PERIOD, "bottomUpCheckPeriod");
        require(gwInfo.topDownCheckPeriod() == DEFAULT_CHECKPOINT_PERIOD, "topDownCheckPeriod");
        require(
            gwInfo.getNetworkName().equals(SubnetID({root: ROOTNET_CHAINID, route: new address[](0)})),
            "getNetworkName"
        );
        require(gwInfo.majorityPercentage() == DEFAULT_MAJORITY_PERCENTAGE, "majorityPercentage");
    }

    function testGatewayDiamond_GatewayDiamond_Deployment_Works_Root(uint64 checkpointPeriod) public {
        vm.assume(checkpointPeriod >= DEFAULT_CHECKPOINT_PERIOD);

        GatewayDiamond dep;
        SubnetManagerFacet depManager = new SubnetManagerFacet();
        InfoFacet depInfo = new InfoFacet();
        RouterFacet depRouter = new RouterFacet();

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
            bottomUpCheckPeriod: checkpointPeriod,
            topDownCheckPeriod: checkpointPeriod,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });

        dep = createDiamond(constructorParams);
        depInfo = InfoFacet(address(dep));
        depManager = SubnetManagerFacet(address(dep));
        depRouter = RouterFacet(address(dep));

        SubnetID memory networkName = depInfo.getNetworkName();

        require(networkName.isRoot(), "networkName.isRoot()");
        require(depInfo.initialized() == true, "gw.initialized() == true");
        require(depInfo.minStake() == MIN_COLLATERAL_AMOUNT, "gw.minStake() == MIN_COLLATERAL_AMOUNT");
        require(depInfo.bottomUpCheckPeriod() == checkpointPeriod, "gw.bottomUpCheckPeriod() == checkpointPeriod");
        require(depInfo.topDownCheckPeriod() == checkpointPeriod, "gw.topDownCheckPeriod() == checkpointPeriod");
        require(
            depInfo.majorityPercentage() == DEFAULT_MAJORITY_PERCENTAGE,
            "gw.majorityPercentage() == DEFAULT_MAJORITY_PERCENTAGE"
        );
    }

    function testGatewayDiamond_GatewayDiamond_Deployment_Works_NotRoot(uint64 checkpointPeriod) public {
        vm.assume(checkpointPeriod >= DEFAULT_CHECKPOINT_PERIOD);

        address[] memory path = new address[](2);
        path[0] = address(0);
        path[1] = address(1);

        GatewayDiamond dep;
        SubnetManagerFacet depManager = new SubnetManagerFacet();
        InfoFacet depInfo = new InfoFacet();
        RouterFacet depRouter = new RouterFacet();

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: checkpointPeriod,
            topDownCheckPeriod: checkpointPeriod,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: 100
        });

        IDiamond.FacetCut[] memory diamondCut = new IDiamond.FacetCut[](3);

        diamondCut[0] = (
            IDiamond.FacetCut({
                facetAddress: address(depRouter),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: routerSelectors
            })
        );

        diamondCut[1] = (
            IDiamond.FacetCut({
                facetAddress: address(depManager),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: managerSelectors
            })
        );

        diamondCut[2] = (
            IDiamond.FacetCut({
                facetAddress: address(depInfo),
                action: IDiamond.FacetCutAction.Add,
                functionSelectors: infoSelectors
            })
        );

        dep = new GatewayDiamond(diamondCut, constructorParams);

        depInfo = InfoFacet(address(dep));
        depManager = SubnetManagerFacet(address(dep));
        depRouter = RouterFacet(address(dep));

        SubnetID memory networkName = depInfo.getNetworkName();

        require(networkName.isRoot() == false, "networkName.isRoot()");
        require(depInfo.initialized() == false, "gw.initialized() == false");
        require(depInfo.minStake() == MIN_COLLATERAL_AMOUNT, "gw.minStake() == MIN_COLLATERAL_AMOUNT");
        require(depInfo.bottomUpCheckPeriod() == checkpointPeriod, "gw.bottomUpCheckPeriod() == checkpointPeriod");
        require(depInfo.topDownCheckPeriod() == checkpointPeriod, "gw.topDownCheckPeriod() == checkpointPeriod");
        require(depInfo.majorityPercentage() == 100, "gw.majorityPercentage() == 100");
    }

    function testGatewayDiamond_GatewayDiamond_Register_Works_SingleSubnet(uint256 subnetCollateral) public {
        vm.assume(subnetCollateral >= MIN_COLLATERAL_AMOUNT && subnetCollateral < type(uint64).max);
        address subnetAddress = vm.addr(100);
        vm.prank(subnetAddress);
        vm.deal(subnetAddress, subnetCollateral);

        registerSubnet(subnetCollateral, subnetAddress);
        require(gwInfo.totalSubnets() == 1);

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);

        (bool ok, Subnet memory targetSubnet) = gwInfo.getSubnet(subnetId);

        require(ok, "subnet found");

        (SubnetID memory id, uint256 stake, , , , Status status) = getSubnet(subnetAddress);

        require(targetSubnet.status == Status.Active);
        require(targetSubnet.status == status);
        require(targetSubnet.stake == stake);
        require(targetSubnet.stake == subnetCollateral);
        require(id.equals(subnetId));
    }

    function testGatewayDiamond_GatewayDiamond_InitGenesisEpoch_Works() public {
        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager2.initGenesisEpoch(50);

        require(gwInfo2.initialized() == true);
        require(gwInfo2.getGenesisEpoch() == 50);
    }

    function testGatewayDiamond_GatewayDiamond_InitGenesisEpoch_Fails_NotSystemActor() public {
        vm.expectRevert(NotSystemActor.selector);
        gwManager.initGenesisEpoch(50);
    }

    function testGatewayDiamond_GatewayDiamond_InitGenesisEpoch_Fails_AlreadyInitialized() public {
        vm.prank(FilAddress.SYSTEM_ACTOR);
        vm.expectRevert(AlreadyInitialized.selector);
        gwManager.initGenesisEpoch(50);
    }

    function testGatewayDiamond_GatewayDiamond_Register_Works_MultipleSubnets(uint8 numberOfSubnets) public {
        vm.assume(numberOfSubnets > 0);

        for (uint256 i = 1; i <= numberOfSubnets; i++) {
            address subnetAddress = vm.addr(i);
            vm.prank(subnetAddress);
            vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

            registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);
        }

        require(gwInfo.totalSubnets() == numberOfSubnets);
    }

    function testGatewayDiamond_GatewayDiamond_Register_Fail_InsufficientCollateral(uint256 collateral) public {
        vm.assume(collateral < MIN_COLLATERAL_AMOUNT);
        vm.expectRevert(NotEnoughFunds.selector);

        gwManager.register{value: collateral}();
    }

    function testGatewayDiamond_GatewayDiamond_Register_Fail_SubnetAlreadyExists() public {
        registerSubnet(MIN_COLLATERAL_AMOUNT, address(this));

        vm.expectRevert(AlreadyRegisteredSubnet.selector);

        gwManager.register{value: MIN_COLLATERAL_AMOUNT}();
    }

    function testGatewayDiamond_AddStake_Works_SingleStaking(uint256 stakeAmount, uint256 registerAmount) public {
        address subnetAddress = vm.addr(100);
        vm.assume(registerAmount >= MIN_COLLATERAL_AMOUNT && registerAmount < type(uint64).max);
        vm.assume(stakeAmount > 0 && stakeAmount < type(uint256).max - registerAmount);

        uint256 totalAmount = stakeAmount + registerAmount;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, totalAmount);

        registerSubnet(registerAmount, subnetAddress);
        addStake(stakeAmount, subnetAddress);

        (, uint256 totalStaked, , , , ) = getSubnet(subnetAddress);

        require(totalStaked == totalAmount);
    }

    function testGatewayDiamond_AddStake_Works_Reactivate() public {
        address subnetAddress = vm.addr(100);
        uint256 registerAmount = MIN_COLLATERAL_AMOUNT;
        uint256 stakeAmount = MIN_COLLATERAL_AMOUNT;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, registerAmount);

        registerSubnet(registerAmount, subnetAddress);
        gwManager.releaseStake(registerAmount);

        (, , , , , Status statusInactive) = getSubnet(subnetAddress);
        require(statusInactive == Status.Inactive);

        vm.deal(subnetAddress, stakeAmount);
        addStake(stakeAmount, subnetAddress);

        (, uint256 staked, , , , Status statusActive) = getSubnet(subnetAddress);

        require(staked == stakeAmount);
        require(statusActive == Status.Active);
    }

    function testGatewayDiamond_AddStake_Works_NotEnoughFundsToReactivate() public {
        address subnetAddress = vm.addr(100);
        uint256 registerAmount = MIN_COLLATERAL_AMOUNT;
        uint256 stakeAmount = MIN_COLLATERAL_AMOUNT - 1;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, registerAmount);

        registerSubnet(registerAmount, subnetAddress);
        gwManager.releaseStake(registerAmount);

        vm.deal(subnetAddress, stakeAmount);
        addStake(stakeAmount, subnetAddress);

        (, uint256 staked, , , , Status status) = getSubnet(subnetAddress);

        require(staked == stakeAmount);
        require(status == Status.Inactive);
    }

    function testGatewayDiamond_AddStake_Works_MultipleStakings(uint8 numberOfStakes) public {
        vm.assume(numberOfStakes > 0);

        address subnetAddress = address(1);
        uint256 singleStakeAmount = 1 ether;
        uint256 registerAmount = MIN_COLLATERAL_AMOUNT;
        uint256 expectedStakedAmount = registerAmount;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, registerAmount + singleStakeAmount * numberOfStakes);

        registerSubnet(registerAmount, subnetAddress);

        for (uint256 i = 0; i < numberOfStakes; i++) {
            addStake(singleStakeAmount, subnetAddress);

            expectedStakedAmount += singleStakeAmount;
        }

        (, uint256 totalStake, , , , ) = getSubnet(subnetAddress);

        require(totalStake == expectedStakedAmount);
    }

    function testGatewayDiamond_AddStake_Fail_ZeroAmount() public {
        registerSubnet(MIN_COLLATERAL_AMOUNT, address(this));

        vm.expectRevert(NotEnoughFunds.selector);

        gwManager.addStake{value: 0}();
    }

    function testGatewayDiamond_AddStake_Fail_SubnetNotExists() public {
        vm.expectRevert(NotRegisteredSubnet.selector);

        gwManager.addStake{value: 1}();
    }

    function testGatewayDiamond_ReleaseStake_Works_FullAmount(uint256 stakeAmount) public {
        address subnetAddress = CHILD_NETWORK_ADDRESS;
        uint256 registerAmount = MIN_COLLATERAL_AMOUNT;

        vm.assume(stakeAmount > 0 && stakeAmount < type(uint256).max - registerAmount);

        uint256 fullAmount = stakeAmount + registerAmount;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, fullAmount);

        registerSubnet(registerAmount, subnetAddress);
        addStake(stakeAmount, subnetAddress);

        gwManager.releaseStake(fullAmount);

        (, uint256 stake, , , , Status status) = getSubnet(subnetAddress);

        require(stake == 0);
        require(status == Status.Inactive);
        require(subnetAddress.balance == fullAmount);
    }

    function testGatewayDiamond_ReleaseStake_Works_SubnetInactive() public {
        address subnetAddress = vm.addr(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        gwManager.releaseStake(MIN_COLLATERAL_AMOUNT / 2);

        (, uint256 stake, , , , Status status) = getSubnet(subnetAddress);
        require(stake == MIN_COLLATERAL_AMOUNT / 2, "stake == MIN_COLLATERAL_AMOUNT / 2");
        require(status == Status.Inactive, "status == Status.Inactive");
    }

    function testGatewayDiamond_ReleaseStake_Works_PartialAmount(uint256 partialAmount) public {
        address subnetAddress = CHILD_NETWORK_ADDRESS;
        uint256 registerAmount = MIN_COLLATERAL_AMOUNT;

        vm.assume(partialAmount > registerAmount && partialAmount < type(uint256).max - registerAmount);

        uint256 totalAmount = partialAmount + registerAmount;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, totalAmount);

        registerSubnet(registerAmount, subnetAddress);
        addStake(partialAmount, subnetAddress);

        gwManager.releaseStake(partialAmount);

        (, uint256 stake, , , , Status status) = getSubnet(subnetAddress);

        require(stake == registerAmount);
        require(status == Status.Active);
        require(subnetAddress.balance == partialAmount);
    }

    function testGatewayDiamond_ReleaseStake_Fail_ZeroAmount() public {
        registerSubnet(MIN_COLLATERAL_AMOUNT, address(this));

        vm.expectRevert(CannotReleaseZero.selector);

        gwManager.releaseStake(0);
    }

    function testGatewayDiamond_ReleaseStake_Fail_InsufficientSubnetBalance(
        uint256 releaseAmount,
        uint256 subnetBalance
    ) public {
        vm.assume(subnetBalance > MIN_COLLATERAL_AMOUNT);
        vm.assume(releaseAmount > subnetBalance && releaseAmount < type(uint256).max - subnetBalance);

        address subnetAddress = vm.addr(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, releaseAmount);

        registerSubnet(subnetBalance, subnetAddress);

        vm.expectRevert(NotEnoughFundsToRelease.selector);

        gwManager.releaseStake(releaseAmount);
    }

    function testGatewayDiamond_ReleaseStake_Fail_NotRegisteredSubnet() public {
        vm.expectRevert(NotRegisteredSubnet.selector);

        gwManager.releaseStake(1);
    }

    function testGatewayDiamond_ReleaseStake_Works_TransitionToInactive() public {
        address subnetAddress = vm.addr(100);

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        gwManager.releaseStake(10);

        (, uint256 stake, , , , Status status) = getSubnet(subnetAddress);

        require(stake == MIN_COLLATERAL_AMOUNT - 10, "stake should be MIN_COLLATERAL_AMOUNT - 10");
        require(status == Status.Inactive, "status should be Inactive");
    }

    function testGatewayDiamond_ReleaseRewards_Fails_CannotReleaseZero() public {
        vm.expectRevert(CannotReleaseZero.selector);

        gwManager.releaseRewards(0);
    }

    function testGatewayDiamond_ReleaseRewards_Fails_NotRegisteredSubnet() public {
        vm.expectRevert(NotRegisteredSubnet.selector);
        vm.deal(address(gatewayDiamond), 1);
        gwManager.releaseRewards(1);
    }

    function testGatewayDiamond_ReleaseRewards_Works() public {
        address subnetAddress = CHILD_NETWORK_ADDRESS;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);
        vm.stopPrank();
        vm.prank(subnetAddress);
        vm.deal(address(gatewayDiamond), 1);
        gwManager.releaseRewards(1);
    }

    function testGatewayDiamond_Kill_Works() public {
        address subnetAddress = CHILD_NETWORK_ADDRESS;

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        require(subnetAddress.balance == 0);

        gwManager.kill();

        (SubnetID memory id, uint256 stake, uint256 nonce, , uint256 circSupply, Status status) = getSubnet(
            subnetAddress
        );

        require(id.toHash() == SubnetID(0, new address[](0)).toHash());
        require(stake == 0);
        require(nonce == 0);
        require(circSupply == 0);
        require(status == Status.Unset);
        require(gwInfo.totalSubnets() == 0);
        require(subnetAddress.balance == MIN_COLLATERAL_AMOUNT);
    }

    function testGatewayDiamond_Kill_Fail_SubnetNotExists() public {
        vm.expectRevert(NotRegisteredSubnet.selector);

        gwManager.kill();
    }

    function testGatewayDiamond_Kill_Fail_CircSupplyMoreThanZero() public {
        address validatorAddress = address(100);
        _join(validatorAddress);

        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        fund(funderAddress, fundAmount);

        vm.stopPrank();
        vm.startPrank(address(sa));
        vm.expectRevert(NotEmptySubnetCircSupply.selector);

        gwManager.kill();
    }

    function testGatewayDiamond_CommitChildCheck_Works() public {
        address subnetAddress = address(100);

        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);

        gwRouter.commitChildCheck(checkpoint);

        require(gwInfo.bottomUpNonce() == 0);
    }

    function testGatewayDiamond_CommitChildCheck_Works_WithCrossMsgs() public {
        address subnetAddress = address(sa);
        address validatorAddress = address(100);
        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        _join(validatorAddress);

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        fund(funderAddress, fundAmount);

        vm.stopPrank();
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        SubnetID memory networkName = gwInfo.getNetworkName();
        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);

        checkpoint.fee = 1;
        checkpoint.crossMsgs = new CrossMsg[](1);
        checkpoint.crossMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: networkName.createSubnetId(subnetAddress), rawAddress: address(1)}),
                to: IPCAddress({subnetId: networkName, rawAddress: address(2)}),
                value: 1,
                nonce: 0,
                method: METHOD_SEND,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        require(checkpoint.crossMsgs[0].message.applyType(networkName) == IPCMsgType.BottomUp);

        vm.expectCall(subnetAddress, 0, abi.encodeWithSelector(ISubnetActor.reward.selector, checkpoint.fee), 1);

        (, , , , uint256 circSupplyBefore, ) = getSubnet(subnetAddress);

        gwRouter.commitChildCheck(checkpoint);

        (, , uint256 appliedBottomUpNonce, , uint256 circSupplyAfter, ) = getSubnet(subnetAddress);

        require(appliedBottomUpNonce == 1);
        require(circSupplyAfter == circSupplyBefore - checkpoint.fee - checkpoint.crossMsgs[0].message.value);
    }

    function testGatewayDiamond_CommitChildCheck_Works_SameSubnet(uint64 blockNumber) public {
        address subnetAddress = address(100);
        vm.assume(blockNumber < type(uint64).max / 2 - 11);
        vm.roll(blockNumber);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);
        gwRouter.commitChildCheck(checkpoint);

        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        BottomUpCheckpoint memory checkpoint2 = createCheckpoint(subnetAddress, 2 * DEFAULT_CHECKPOINT_PERIOD);

        gwRouter.commitChildCheck(checkpoint2);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_InvalidCrossMsgNonce(uint64 blockNumber) public {
        address subnetAddress = address(sa);
        vm.assume(blockNumber < type(uint64).max / 2 - 11);
        vm.roll(blockNumber);

        address validatorAddress = address(100);

        _join(validatorAddress);

        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        fund(funderAddress, fundAmount);

        vm.stopPrank();
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        SubnetID memory networkName = gwInfo.getNetworkName();
        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);

        checkpoint.crossMsgs = new CrossMsg[](1);
        checkpoint.crossMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: networkName.createSubnetId(subnetAddress), rawAddress: address(1)}),
                to: IPCAddress({subnetId: networkName, rawAddress: address(2)}),
                value: 1,
                nonce: 1,
                method: METHOD_SEND,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        require(checkpoint.crossMsgs[0].message.applyType(networkName) == IPCMsgType.BottomUp);

        vm.expectRevert(InvalidCrossMsgNonce.selector);

        gwRouter.commitChildCheck(checkpoint);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_NotInitialized() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);
        vm.expectRevert(NotInitialized.selector);
        gwRouter2.commitChildCheck(checkpoint);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_InvalidCheckpointSource() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        address notSubnetAddress = address(101);

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(notSubnetAddress);
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: 0,
            fee: 0,
            crossMsgs: new CrossMsg[](0),
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        vm.expectRevert(InvalidCheckpointSource.selector);
        gwRouter.commitChildCheck(checkpoint);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_InvalidCheckpointEpoch_PrevEpoch() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);
        gwRouter.commitChildCheck(checkpoint);

        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        BottomUpCheckpoint memory checkpoint2 = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD / 2);
        vm.expectRevert(InvalidCheckpointEpoch.selector);
        gwRouter.commitChildCheck(checkpoint2);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_InvalidCheckpointEpoch_CurrentEpoch() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        BottomUpCheckpoint memory checkpoint = createCheckpoint(subnetAddress, DEFAULT_CHECKPOINT_PERIOD);
        gwRouter.commitChildCheck(checkpoint);

        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        vm.expectRevert(InvalidCheckpointEpoch.selector);
        gwRouter.commitChildCheck(checkpoint);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_SubnetNotActive() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            fee: 0,
            crossMsgs: new CrossMsg[](0),
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        vm.expectRevert(SubnetNotActive.selector);
        gwRouter.commitChildCheck(checkpoint);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_InconsistentPrevCheckpoint() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            fee: 0,
            crossMsgs: new CrossMsg[](0),
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });
        gwRouter.commitChildCheck(checkpoint);

        checkpoint.fee = 100; // mess with the checkpoint to get different hash

        BottomUpCheckpoint memory checkpoint2 = BottomUpCheckpoint({
            source: subnetId,
            epoch: 2 * DEFAULT_CHECKPOINT_PERIOD,
            fee: 0,
            crossMsgs: new CrossMsg[](0),
            prevHash: checkpoint.toHash(),
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        vm.expectRevert(InconsistentPrevCheckpoint.selector);
        gwRouter.commitChildCheck(checkpoint2);
    }

    function testGatewayDiamond_CommitChildCheck_Fails_NotEnoughSubnetCircSupply() public {
        address subnetAddress = address(100);
        vm.startPrank(subnetAddress);
        vm.deal(subnetAddress, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, subnetAddress);

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            fee: MIN_COLLATERAL_AMOUNT * 2,
            crossMsgs: new CrossMsg[](0),
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        vm.expectRevert(NotEnoughSubnetCircSupply.selector);
        gwRouter.commitChildCheck(checkpoint);
    }

    function testGatewayDiamond_Fund_Works_ReactivatedSubnet() public {
        address validatorAddress = address(100);

        _join(validatorAddress);

        vm.prank(validatorAddress);
        sa.leave();

        _join(validatorAddress);

        require(sa.status() == Status.Active);

        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        fund(funderAddress, fundAmount);
    }

    function testGatewayDiamond_Fund_Works_EthAccountSingleFunding() public {
        address validatorAddress = address(100);

        _join(validatorAddress);

        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        fund(funderAddress, fundAmount);
    }

    function testGatewayDiamond_Fund_Works_BLSAccountSingleFunding() public {
        address validatorAddress = address(100);
        _join(validatorAddress);

        uint256 fundAmount = 1 ether;
        vm.startPrank(BLS_ACCOUNT_ADDREESS);
        vm.deal(BLS_ACCOUNT_ADDREESS, fundAmount + 1);

        fund(BLS_ACCOUNT_ADDREESS, fundAmount);
    }

    function testGatewayDiamond_Fund_Works_MultipleFundings() public {
        uint8 numberOfFunds = 5;
        uint256 fundAmount = 1 ether;

        address validatorAddress = address(100);
        address funderAddress = address(101);

        _join(validatorAddress);

        vm.startPrank(funderAddress);
        vm.expectCall(address(sa), 0, abi.encodeWithSelector(sa.reward.selector, gwInfo.crossMsgFee()), 5);

        for (uint256 i = 0; i < numberOfFunds; i++) {
            vm.deal(funderAddress, fundAmount + 1);

            fund(funderAddress, fundAmount);
        }
    }

    function testGatewayDiamond_Fund_Fails_WrongSubnet() public {
        address validatorAddress = address(100);
        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        _join(validatorAddress);

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        address[] memory wrongPath = new address[](3);
        wrongPath[0] = address(1);
        wrongPath[1] = address(2);

        vm.expectRevert(NotRegisteredSubnet.selector);

        gwManager.fund{value: fundAmount}(SubnetID(ROOTNET_CHAINID, wrongPath));
    }

    function testGatewayDiamond_Fund_Fails_InvalidAccount() public {
        address validatorAddress = address(100);
        address invalidAccount = address(sa);
        uint256 fundAmount = 1 ether;

        _join(validatorAddress);

        vm.startPrank(invalidAccount);
        vm.deal(invalidAccount, fundAmount + 1);

        (SubnetID memory subnetId, , , , , ) = getSubnet(address(sa));

        vm.expectRevert(NotSignableAccount.selector);

        gwManager.fund{value: fundAmount}(subnetId);
    }

    function testGatewayDiamond_Fund_Fails_NotRegistered() public {
        address validatorAddress = address(100);
        address funderAddress = address(101);
        uint256 fundAmount = 1 ether;

        _join(validatorAddress);

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, fundAmount + 1);

        address[] memory wrongSubnetPath = new address[](2);
        wrongSubnetPath[0] = vm.addr(102);
        wrongSubnetPath[0] = vm.addr(103);
        SubnetID memory wrongSubnetId = SubnetID({root: ROOTNET_CHAINID, route: wrongSubnetPath});

        vm.expectRevert(NotRegisteredSubnet.selector);
        gwManager.fund{value: fundAmount}(wrongSubnetId);
    }

    function testGatewayDiamond_Fund_Fails_InsufficientAmount() public {
        address validatorAddress = address(100);
        address funderAddress = address(101);

        _join(validatorAddress);

        vm.startPrank(funderAddress);
        vm.deal(funderAddress, 1 ether);

        (SubnetID memory subnetId, , , , , ) = getSubnet(address(sa));

        vm.expectRevert(NotEnoughFee.selector);

        gwManager.fund{value: 0}(subnetId);
    }

    function testGatewayDiamond_Release_Fails_InsufficientAmount() public {
        address[] memory path = new address[](2);
        path[0] = address(1);
        path[1] = address(2);

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });
        gatewayDiamond = createDiamond(constructorParams);
        gwInfo = InfoFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwRouter = RouterFacet(address(gatewayDiamond));

        address callerAddress = address(100);

        vm.startPrank(callerAddress);
        vm.deal(callerAddress, 1 ether);
        vm.expectRevert(NotEnoughFee.selector);

        gwManager.release{value: 0}();
    }

    function testGatewayDiamond_Release_Fails_InvalidAccount() public {
        address[] memory path = new address[](2);
        path[0] = address(1);
        path[1] = address(2);

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });

        gatewayDiamond = createDiamond(constructorParams);

        address invalidAccount = address(sa);

        vm.startPrank(invalidAccount);
        vm.deal(invalidAccount, 1 ether);
        vm.expectRevert(NotSignableAccount.selector);

        gwManager.release{value: 1 ether}();
    }

    function testGatewayDiamond_Release_Works_BLSAccount(uint256 releaseAmount, uint256 crossMsgFee) public {
        vm.assume(releaseAmount > 0 && releaseAmount < type(uint256).max);
        vm.assume(crossMsgFee > 0 && crossMsgFee < releaseAmount);

        address[] memory path = new address[](2);
        path[0] = makeAddr("root");
        path[1] = makeAddr("subnet_one");

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: crossMsgFee,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });
        gatewayDiamond = createDiamond(constructorParams);
        gwInfo = InfoFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwRouter = RouterFacet(address(gatewayDiamond));

        vm.roll(0);
        vm.warp(0);
        vm.startPrank(BLS_ACCOUNT_ADDREESS);
        vm.deal(BLS_ACCOUNT_ADDREESS, releaseAmount + 1);
        release(releaseAmount, crossMsgFee, EPOCH_ONE);
    }

    function testGatewayDiamond_Release_Works_EmptyCrossMsgMeta(uint256 releaseAmount, uint256 crossMsgFee) public {
        vm.assume(releaseAmount > 0 && releaseAmount < type(uint256).max);
        vm.assume(crossMsgFee > 0 && crossMsgFee < releaseAmount);

        address[] memory path = new address[](2);
        path[0] = makeAddr("root");
        path[1] = makeAddr("subnet_one");

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: crossMsgFee,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });
        gatewayDiamond = createDiamond(constructorParams);
        gwInfo = InfoFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwRouter = RouterFacet(address(gatewayDiamond));

        address callerAddress = address(100);

        vm.roll(0);
        vm.warp(0);
        vm.startPrank(callerAddress);
        vm.deal(callerAddress, releaseAmount + 1);

        release(releaseAmount, crossMsgFee, EPOCH_ONE);
    }

    function testGatewayDiamond_Release_Works_NonEmptyCrossMsgMeta(uint256 releaseAmount, uint256 crossMsgFee) public {
        vm.assume(releaseAmount > 0 && releaseAmount < type(uint256).max / 2);
        vm.assume(crossMsgFee > 0 && crossMsgFee < releaseAmount);

        address[] memory path = new address[](2);
        path[0] = makeAddr("root");
        path[1] = makeAddr("subnet_one");

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: crossMsgFee,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });
        gatewayDiamond = createDiamond(constructorParams);
        gwInfo = InfoFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwRouter = RouterFacet(address(gatewayDiamond));

        address callerAddress = address(100);

        vm.roll(0);
        vm.warp(0);
        vm.startPrank(callerAddress);
        vm.deal(callerAddress, 2 * releaseAmount + 1);

        release(releaseAmount, crossMsgFee, EPOCH_ONE);

        release(releaseAmount, crossMsgFee, EPOCH_ONE);
    }

    function testGatewayDiamond_SendCrossMessage_Fails_NoDestination() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);

        vm.expectRevert(InvalidCrossMsgDestinationSubnet.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({subnetId: SubnetID({root: 0, route: new address[](0)}), rawAddress: caller}),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: false
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_NotSignableAccount() public {
        address caller = address(sa);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);

        vm.expectRevert(NotSignableAccount.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: false
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_NoCurrentNetwork() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = gwInfo.getNetworkName();
        vm.expectRevert(CannotSendCrossMsgToItself.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: caller}),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_DifferentMessageValue() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = gwInfo.getNetworkName().createSubnetId(caller);
        vm.expectRevert(NotEnoughFunds.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: caller}),
                    value: 5,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_EmptyNetwork() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = SubnetID(0, new address[](0));
        vm.expectRevert(InvalidCrossMsgDestinationSubnet.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: caller}),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_InvalidCrossMsgFromSubnetId() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = gwInfo.getNetworkName().createSubnetId(caller);
        vm.expectRevert(InvalidCrossMsgFromSubnetId.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({subnetId: SubnetID({root: 0, route: new address[](0)}), rawAddress: caller}),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: caller}),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_InvalidCrossMsgFromRawAddress() public {
        address caller = vm.addr(100);
        address invalidCaller = vm.addr(200);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = gwInfo.getNetworkName().createSubnetId(caller);
        vm.expectRevert(InvalidCrossMsgFromRawAddress.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: invalidCaller
                    }),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: caller}),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_InvalidToAddr() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = gwInfo.getNetworkName().createSubnetId(caller);
        vm.expectRevert(InvalidCrossMsgDestinationAddress.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: address(0)}),
                    value: CROSS_MSG_FEE + 1,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Fails_NotEnoughGas() public {
        address caller = vm.addr(100);
        vm.startPrank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);
        SubnetID memory destinationSubnet = gwInfo.getNetworkName().createSubnetId(caller);
        vm.expectRevert(NotEnoughFee.selector);
        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE - 1}(
            CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({
                        subnetId: SubnetID({root: ROOTNET_CHAINID, route: new address[](0)}),
                        rawAddress: caller
                    }),
                    to: IPCAddress({subnetId: destinationSubnet, rawAddress: address(0)}),
                    value: 0,
                    nonce: 0,
                    method: METHOD_SEND,
                    params: new bytes(0)
                }),
                wrapped: true
            })
        );
    }

    function testGatewayDiamond_SendCrossMessage_Works_TopDown_SameSubnet() public {
        address caller = vm.addr(100);
        vm.prank(caller);
        vm.deal(caller, MIN_COLLATERAL_AMOUNT + CROSS_MSG_FEE + 2);
        registerSubnet(MIN_COLLATERAL_AMOUNT, caller);

        address receiver = address(this); // callback to reward() method
        vm.prank(receiver);
        vm.deal(receiver, MIN_COLLATERAL_AMOUNT + 1);
        registerSubnet(MIN_COLLATERAL_AMOUNT, receiver);

        SubnetID memory destinationSubnet = gwInfo.getNetworkName().createSubnetId(receiver);
        SubnetID memory from = gwInfo.getNetworkName().createSubnetId(caller);

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: caller}),
                to: IPCAddress({subnetId: destinationSubnet, rawAddress: receiver}),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: true
        });

        vm.prank(caller);
        vm.expectCall(receiver, 0, abi.encodeWithSelector(ISubnetActor.reward.selector, CROSS_MSG_FEE), 1);

        gwRouter.sendCrossMessage{value: CROSS_MSG_FEE + 1}(crossMsg);

        (SubnetID memory id, , uint256 nonce, , uint256 circSupply, ) = getSubnet(address(this));

        require(crossMsg.message.applyType(gwInfo.getNetworkName()) == IPCMsgType.TopDown);
        require(id.equals(destinationSubnet));
        require(nonce == 1);
        require(circSupply == CROSS_MSG_FEE + 1);
        require(gwInfo.getNetworkName().equals(destinationSubnet.commonParent(from)));
        require(gwInfo.appliedTopDownNonce() == 1);
    }

    function reward(uint256 amount) external view {
        console.log("reward method called with %d", amount);
    }

    function testGatewayDiamond_SendCrossMessage_Works_BottomUp_CurrentNetworkNotCommonParent() public {
        address receiver = vm.addr(101);
        address caller = vm.addr(100);

        vm.prank(receiver);
        vm.deal(receiver, MIN_COLLATERAL_AMOUNT);
        registerSubnetGW(MIN_COLLATERAL_AMOUNT, receiver, gatewayDiamond2);

        vm.prank(caller);
        vm.deal(caller, CROSS_MSG_FEE + 2);

        SubnetID memory network2 = gwInfo2.getNetworkName();
        address[] memory destinationPath = new address[](1);
        destinationPath[0] = ROOTNET_ADDRESS;
        SubnetID memory destinationSubnet = SubnetID({root: ROOTNET_CHAINID, route: destinationPath});

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: network2, rawAddress: caller}),
                to: IPCAddress({subnetId: destinationSubnet, rawAddress: receiver}),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: true
        });

        vm.prank(caller);
        gwRouter2.sendCrossMessage{value: CROSS_MSG_FEE + 1}(crossMsg);

        require(crossMsg.message.applyType(gwInfo2.getNetworkName()) == IPCMsgType.BottomUp);
        require(gwInfo2.appliedTopDownNonce() == 0);
        require(gwInfo2.bottomUpNonce() == 1);
    }

    function testGatewayDiamond_SendCrossMessage_Works_BottomUp_CurrentNetworkCommonParent() public {
        // the receiver is a network 1 address, but we are declaring it is network2 so we can use it in the tests
        address receiver = vm.addr(101);
        address caller = vm.addr(100);

        vm.prank(caller);
        vm.deal(caller, CROSS_MSG_FEE + 2);
        SubnetID memory network2 = gwInfo2.getNetworkName();
        address[] memory rootnetPath = new address[](1);
        rootnetPath[0] = ROOTNET_ADDRESS;
        SubnetID memory destinationSubnet = SubnetID({root: ROOTNET_CHAINID, route: rootnetPath});

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: network2, rawAddress: caller}),
                to: IPCAddress({subnetId: destinationSubnet, rawAddress: receiver}),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: true
        });

        require(crossMsg.message.applyType(gwInfo2.getNetworkName()) == IPCMsgType.BottomUp);

        vm.prank(caller);

        gwRouter2.sendCrossMessage{value: CROSS_MSG_FEE + 1}(crossMsg);

        require(gwInfo2.appliedTopDownNonce() == 0);
    }

    function testGatewayDiamond_WhitelistPropagator_Works() public {
        address caller = vm.addr(100);
        address receiver = vm.addr(101);

        vm.prank(receiver);
        vm.deal(receiver, MIN_COLLATERAL_AMOUNT);
        registerSubnet(MIN_COLLATERAL_AMOUNT, receiver);

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: caller}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName().createSubnetId(receiver), rawAddress: receiver}),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: false
        });

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = crossMsg;
        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });
        vm.prank(TOPDOWN_VALIDATOR_1);
        vm.deal(TOPDOWN_VALIDATOR_1, 1);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        bytes32 postboxItemId = crossMsg.toHash();
        address[] memory ownersToAdd = new address[](2);
        ownersToAdd[0] = receiver;

        vm.prank(caller);
        vm.deal(caller, CROSS_MSG_FEE + 2);
        gwRouter.whitelistPropagator(postboxItemId, ownersToAdd);

        require(gwInfo.postboxHasOwner(postboxItemId, caller), "gw.postboxHasOwner(postboxItemId, caller)");
        require(gwInfo.postboxHasOwner(postboxItemId, receiver), "gw.postboxHasOwner(postboxItemId, receiver)");

        (StorableMsg memory storableMsg, bool wrapped) = gwInfo.postbox(postboxItemId);
        CrossMsg memory msgFrompostbox = CrossMsg(storableMsg, wrapped);
        require(msgFrompostbox.toHash() == crossMsg.toHash());
    }

    function testGatewayDiamond_WhitelistPropagator_Fails_NotOwner() public {
        address caller = vm.addr(100);
        vm.deal(caller, 1 ether);
        address receiver = vm.addr(101);

        bytes32 postBoxItemId = setupWhiteListMethod(caller);

        address[] memory owners = new address[](1);
        owners[0] = caller;

        vm.prank(receiver);
        vm.expectRevert(InvalidPostboxOwner.selector);
        gwRouter.whitelistPropagator(postBoxItemId, owners);
    }

    function testGatewayDiamond_WhitelistPropagator_Fails_PostboxItemDoesNotExist() public {
        address caller = vm.addr(100);
        vm.deal(caller, 1 ether);
        setupWhiteListMethod(caller);

        address[] memory owners = new address[](1);
        owners[0] = caller;

        vm.expectRevert(InvalidPostboxOwner.selector);

        gwRouter.whitelistPropagator(bytes32(0), owners);
    }

    function testGatewayDiamond_Propagate_Works_WithFeeRemainder() external {
        address[] memory validators = setupValidators();
        address caller = validators[0];

        bytes32 postboxId = setupWhiteListMethod(caller);

        vm.deal(caller, 1 ether);
        vm.expectCall(caller, 1 ether - gwInfo.crossMsgFee(), new bytes(0), 1);
        vm.expectCall(address(this), 0, abi.encodeWithSelector(ISubnetActor.reward.selector, gwInfo.crossMsgFee()), 1);

        vm.prank(caller);
        gwRouter.propagate{value: 1 ether}(postboxId);

        require(caller.balance == 1 ether - gwInfo.crossMsgFee());
    }

    function testGatewayDiamond_Propagate_Works_NoFeeReminder() external {
        address[] memory validators = setupValidators();
        address caller = validators[0];

        uint256 fee = gwInfo.crossMsgFee();

        bytes32 postboxId = setupWhiteListMethod(caller);

        vm.deal(caller, fee);
        vm.prank(caller);

        vm.expectCall(caller, 0, EMPTY_BYTES, 0);

        gwRouter.propagate{value: fee}(postboxId);
        require(caller.balance == 0, "caller.balance == 0");
    }

    function testGatewayDiamond_Propagate_Fails_NotEnoughFee() public {
        address caller = vm.addr(100);
        vm.deal(caller, 1 ether);

        vm.expectRevert(NotEnoughFee.selector);
        gwRouter.propagate(bytes32(""));
    }

    function testGatewayDiamond_Propagate_Fails_NotOwner() public {
        address caller = vm.addr(100);
        vm.deal(caller, 1 ether);
        address notOwner = vm.addr(102);

        bytes32 postboxItemCid = setupWhiteListMethod(caller);

        address[] memory owners = new address[](1);
        owners[0] = caller;

        vm.prank(notOwner);
        vm.deal(notOwner, 1 ether);
        vm.expectRevert(InvalidPostboxOwner.selector);
        gwRouter.propagate{value: 1 ether}(postboxItemCid);
    }

    function testGatewayDiamond_Propagate_Fails_PostboxItemDoesNotExist() public {
        vm.prank(vm.addr(100));
        vm.deal(vm.addr(100), 1 ether);
        vm.expectRevert(InvalidPostboxOwner.selector);
        gwRouter.propagate{value: 1 ether}(bytes32(0));
    }

    function setupWhiteListMethod(address caller) internal returns (bytes32) {
        address[] memory validators = setupValidators();

        registerSubnet(MIN_COLLATERAL_AMOUNT, address(this));

        CrossMsg memory crossMsg = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName().createSubnetId(caller), rawAddress: caller}),
                to: IPCAddress({
                    subnetId: gwInfo.getNetworkName().createSubnetId(address(this)),
                    rawAddress: address(this)
                }),
                value: CROSS_MSG_FEE + 1,
                nonce: 0,
                method: METHOD_SEND,
                params: new bytes(0)
            }),
            wrapped: false
        });

        // we add a validator with 10 times as much weight as the default validator.
        // This way we have 10/11 votes and we reach majority, setting the message in postbox
        // addValidator(caller, 1000);

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = crossMsg;
        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[2]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        return crossMsg.toHash();
    }

    function testGatewayDiamond_SetMembership_Fails_NotSystemActor() public {
        address caller = vm.addr(100);

        address[] memory validators = new address[](1);
        validators[0] = caller;
        uint256[] memory weights = new uint256[](1);
        weights[0] = 100;

        vm.prank(caller);
        vm.expectRevert(NotSystemActor.selector);
        gwManager.setMembership(validators, weights);
    }

    function testGatewayDiamond_SetMembership_Fails_ValidatorsAndWeightsNotEqual() public {
        address[] memory validators = new address[](1);
        validators[0] = vm.addr(100);
        uint256[] memory weights = new uint256[](2);
        weights[0] = 100;
        weights[1] = 130;

        vm.prank(FilAddress.SYSTEM_ACTOR);
        vm.expectRevert(ValidatorsAndWeightsLengthMismatch.selector);
        gwManager.setMembership(validators, weights);
    }

    function testGatewayDiamond_SetMembership_Fails_ZeroWeight() public {
        address[] memory validators = new address[](1);
        validators[0] = vm.addr(100);
        uint256[] memory weights = new uint256[](1);
        weights[0] = 0;

        vm.prank(FilAddress.SYSTEM_ACTOR);
        vm.expectRevert(ValidatorWeightIsZero.selector);
        gwManager.setMembership(validators, weights);
    }

    function testGatewayDiamond_SetMembership_Works_MultipleValidators() public {
        address[] memory validators = new address[](2);
        validators[0] = vm.addr(100);
        validators[1] = vm.addr(101);
        uint256[] memory weights = new uint256[](2);
        weights[0] = 100;
        weights[1] = 150;

        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager.setMembership(validators, weights);

        require(gwInfo.totalWeight() == 250);
    }

    function testGatewayDiamond_SetMembership_Works_NewValidators() public {
        addValidator(vm.addr(100), 100);

        require(gwInfo.totalWeight() == 100);

        addValidator(vm.addr(101), 1000);

        require(gwInfo.totalWeight() == 1000);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_NotSignableAccount() public {
        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });

        address validator = vm.addr(400);
        vm.prank(validator);
        vm.expectRevert(NotSignableAccount.selector);
        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_EpochAlreadyExecuted() public {
        address validator = address(100);

        addValidator(validator, 100);

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });

        vm.prank(validator);
        vm.deal(validator, 1 ether);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validator);
        vm.expectRevert(EpochAlreadyExecuted.selector);
        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_EpochNotVotable() public {
        address validator = vm.addr(100);

        addValidator(validator);

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD + 1,
            topDownMsgs: new CrossMsg[](0)
        });

        vm.prank(validator);
        vm.expectRevert(EpochNotVotable.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_ValidatorAlreadyVoted() public {
        address[] memory validators = setupValidators();

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[0]);
        vm.expectRevert(ValidatorAlreadyVoted.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_NotInitialized() public {
        address[] memory path = new address[](2);
        path[0] = address(0);
        path[1] = address(1);

        GatewayDiamond.ConstructorParams memory constructorParams = GatewayDiamond.ConstructorParams({
            networkName: SubnetID({root: ROOTNET_CHAINID, route: path}),
            bottomUpCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            topDownCheckPeriod: DEFAULT_CHECKPOINT_PERIOD,
            msgFee: CROSS_MSG_FEE,
            majorityPercentage: DEFAULT_MAJORITY_PERCENTAGE
        });
        gatewayDiamond = createDiamond(constructorParams);
        gwInfo = InfoFacet(address(gatewayDiamond));
        gwManager = SubnetManagerFacet(address(gatewayDiamond));
        gwRouter = RouterFacet(address(gatewayDiamond));

        address validator = vm.addr(100);

        addValidator(validator, 100);

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });

        vm.prank(validator);
        vm.deal(validator, 1);
        vm.expectRevert(NotInitialized.selector);
        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_NotValidator() public {
        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });

        address nonValidator = vm.addr(400);
        vm.prank(nonValidator);
        vm.deal(nonValidator, 1);
        vm.expectRevert(NotValidator.selector);
        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_MessagesNotSorted() public {
        address[] memory validators = setupValidators();

        CrossMsg[] memory topDownMsgs = new CrossMsg[](2);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 10,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });
        topDownMsgs[1] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 0,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validators[0]);
        vm.expectRevert(MessagesNotSorted.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_InvalidCrossMsgDestinationAddress() public {
        address validator = address(100);

        addValidator(validator, 100);

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(0)}),
                value: 0,
                nonce: 10,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validator);
        vm.expectRevert(InvalidCrossMsgDestinationAddress.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_NotEnoughBalance() public {
        address validator = address(100);

        addValidator(validator, 100);

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 100 ether,
                nonce: 10,
                method: METHOD_SEND,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validator);
        vm.expectRevert(NotEnoughBalance.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_InvalidCrossMsgDestinationSubnet() public {
        address validator = address(100);

        addValidator(validator, 100);

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: SubnetID(0, new address[](0)), rawAddress: address(this)}),
                value: 0,
                nonce: 10,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validator);
        vm.deal(validator, 1);
        vm.expectRevert(InvalidCrossMsgDestinationSubnet.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Fails_TopDownInvalidCrossMsgNonce() public {
        address validator = address(100);

        addValidator(validator, 100);

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        // apply type = topdown
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 10,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validator);
        vm.deal(validator, 1);
        vm.expectRevert(InvalidCrossMsgNonce.selector);

        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Works_ConsensusReachedAndExecuted() public {
        address[] memory validators = setupValidators();

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: validators[0]}),
                value: address(gatewayDiamond).balance,
                nonce: 0,
                method: METHOD_SEND,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });
        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[2]);

        gwRouter.submitTopDownCheckpoint(checkpoint);

        (, uint256 first, uint256 last) = gwInfo.executableQueue();

        require(gwInfo.lastVotingExecutedEpoch() == checkpoint.epoch);
        require(first == 0);
        require(last == 0);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_FuzzNumberOfMessages(uint256 n) public {
        vm.assume(n < 19594); // TODO: test with different memory limit
        address[] memory validators = new address[](1);
        validators[0] = vm.addr(100);
        vm.deal(validators[0], 1);
        uint256[] memory weights = new uint[](1);
        weights[0] = 100;

        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager.setMembership(validators, weights);

        CrossMsg[] memory topDownMsgs = new CrossMsg[](n);
        for (uint64 i = 0; i < n; i++) {
            topDownMsgs[i] = CrossMsg({
                message: StorableMsg({
                    from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                    to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                    value: 0,
                    nonce: i,
                    method: this.callback.selector,
                    params: EMPTY_BYTES
                }),
                wrapped: false
            });
        }

        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(checkpoint);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Works_ConsensusReachedAndAddedToQueue() public {
        address[] memory validators = setupValidators();

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 0,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });
        uint64 nextEpoch = DEFAULT_CHECKPOINT_PERIOD + 10;
        TopDownCheckpoint memory checkpoint = TopDownCheckpoint({epoch: nextEpoch, topDownMsgs: topDownMsgs});

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        vm.prank(validators[2]);
        // should not call
        vm.expectCall(address(this), abi.encodeWithSelector(this.callback.selector), 0);
        gwRouter.submitTopDownCheckpoint(checkpoint);

        (, uint256 first, uint256 last) = gwInfo.executableQueue();

        require(gwInfo.lastVotingExecutedEpoch() == 0);
        require(first == nextEpoch);
        require(last == nextEpoch);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Works_ConsensusReachedAndExecuteNext() public {
        address[] memory validators = setupValidators();

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 0,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory currentCheckpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });
        TopDownCheckpoint memory futureCheckpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD + 10,
            topDownMsgs: topDownMsgs
        });

        // reaching consensus for the future checkpoint, so it should be added to the queue
        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(futureCheckpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(futureCheckpoint);

        vm.prank(validators[2]);
        gwRouter.submitTopDownCheckpoint(futureCheckpoint);

        // reaching consensus for the current checkpoint, but since it contains 0 cross msgs
        // it should execute the first checkpoint from the queue
        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(currentCheckpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(currentCheckpoint);

        vm.prank(validators[2]);
        // should not call
        vm.expectCall(address(this), abi.encodeWithSelector(this.callback.selector), 1);
        gwRouter.submitTopDownCheckpoint(currentCheckpoint);

        (, uint256 first, uint256 last) = gwInfo.executableQueue();

        require(gwInfo.lastVotingExecutedEpoch() == futureCheckpoint.epoch);
        require(first == 0);
        require(last == 0);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Works_ConsensusReachedButNextEpochInFuture() public {
        address[] memory validators = setupValidators();

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 0,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        uint64 nextEpoch = DEFAULT_CHECKPOINT_PERIOD + 50;
        TopDownCheckpoint memory currentCheckpoint = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });
        TopDownCheckpoint memory futureCheckpoint = TopDownCheckpoint({epoch: nextEpoch, topDownMsgs: topDownMsgs});

        // reaching consensus for the future checkpoint, so it should be added to the queue
        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(futureCheckpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(futureCheckpoint);

        vm.prank(validators[2]);
        gwRouter.submitTopDownCheckpoint(futureCheckpoint);

        // reaching consensus for the current checkpoint, but since it contains 0 cross msgs
        // it should execute the first checkpoint from the queue, but since it's far in the future
        // it should not execute anything

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(currentCheckpoint);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(currentCheckpoint);

        vm.prank(validators[2]);
        // should not call
        vm.expectCall(address(this), abi.encodeWithSelector(this.callback.selector), 0);
        gwRouter.submitTopDownCheckpoint(currentCheckpoint);

        (, uint256 first, uint256 last) = gwInfo.executableQueue();

        require(gwInfo.lastVotingExecutedEpoch() == DEFAULT_CHECKPOINT_PERIOD);
        require(first == nextEpoch);
        require(last == nextEpoch);
    }

    function testGatewayDiamond_SubmitTopDownCheckpoint_Works_RoundAbort() public {
        address[] memory validators = setupValidators();

        CrossMsg[] memory topDownMsgs = new CrossMsg[](1);
        topDownMsgs[0] = CrossMsg({
            message: StorableMsg({
                from: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                to: IPCAddress({subnetId: gwInfo.getNetworkName(), rawAddress: address(this)}),
                value: 0,
                nonce: 0,
                method: this.callback.selector,
                params: EMPTY_BYTES
            }),
            wrapped: false
        });

        TopDownCheckpoint memory checkpoint1 = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: new CrossMsg[](0)
        });
        TopDownCheckpoint memory checkpoint2 = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });
        topDownMsgs[0].wrapped = true;
        TopDownCheckpoint memory checkpoint3 = TopDownCheckpoint({
            epoch: DEFAULT_CHECKPOINT_PERIOD,
            topDownMsgs: topDownMsgs
        });

        vm.prank(validators[0]);
        gwRouter.submitTopDownCheckpoint(checkpoint1);

        vm.prank(validators[1]);
        gwRouter.submitTopDownCheckpoint(checkpoint2);

        vm.prank(validators[2]);
        gwRouter.submitTopDownCheckpoint(checkpoint3);

        (, uint256 first, uint256 last) = gwInfo.executableQueue();

        require(gwInfo.lastVotingExecutedEpoch() == 0);
        require(first == 0);
        require(last == 0);
    }

    function setupValidators() internal returns (address[] memory) {
        address validator1 = vm.addr(100);
        address validator2 = vm.addr(200);
        address validator3 = vm.addr(300);
        address[] memory validators = new address[](3);
        uint256[] memory weights = new uint256[](3);

        vm.deal(validator1, 1);
        vm.deal(validator2, 1);
        vm.deal(validator3, 1);

        validators[0] = validator1;
        validators[1] = validator2;
        validators[2] = validator3;

        weights[0] = 100;
        weights[1] = 100;
        weights[2] = 100;

        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager.setMembership(validators, weights);

        return validators;
    }

    function addValidator(address validator) internal {
        addValidator(validator, 100);
    }

    function addValidator(address validator, uint256 weight) internal {
        address[] memory validators = new address[](1);
        validators[0] = validator;
        uint256[] memory weights = new uint256[](1);
        weights[0] = weight;

        vm.deal(validator, 1);
        vm.prank(FilAddress.SYSTEM_ACTOR);
        gwManager.setMembership(validators, weights);
    }

    function callback() public view {
        console.log("callback called");
    }

    function fund(address funderAddress, uint256 fundAmount) internal {
        uint256 fundAmountWithSubtractedFee = fundAmount - gwInfo.crossMsgFee();

        (SubnetID memory subnetId, , uint256 nonceBefore, , uint256 circSupplyBefore, ) = getSubnet(address(sa));

        uint256 expectedTopDownMsgsLength = gwInfo.getSubnetTopDownMsgsLength(subnetId) + 1;
        uint256 expectedNonce = nonceBefore + 1;
        uint256 expectedCircSupply = circSupplyBefore + fundAmountWithSubtractedFee;

        require(gwInfo.crossMsgFee() > 0, "crossMsgFee is 0");

        // vm.expectCall(address(sa), gwInfo.crossMsgFee(), abi.encodeWithSelector(sa.reward.selector), 1);

        gwManager.fund{value: fundAmount}(subnetId);

        (, , uint256 nonce, , uint256 circSupply, ) = getSubnet(address(sa));

        require(gwInfo.getSubnetTopDownMsgsLength(subnetId) == expectedTopDownMsgsLength);

        require(nonce == expectedNonce);
        require(circSupply == expectedCircSupply);

        for (uint256 msgIndex = 0; msgIndex < expectedTopDownMsgsLength; msgIndex++) {
            CrossMsg memory topDownMsg = gwInfo.getSubnetTopDownMsg(subnetId, msgIndex);

            require(topDownMsg.message.nonce == msgIndex);
            require(topDownMsg.message.value == fundAmountWithSubtractedFee);
            require(
                keccak256(abi.encode(topDownMsg.message.to)) ==
                    keccak256(abi.encode(IPCAddress({subnetId: subnetId, rawAddress: funderAddress})))
            );
            require(
                keccak256(abi.encode(topDownMsg.message.from)) ==
                    keccak256(abi.encode(IPCAddress({subnetId: subnetId.getParentSubnet(), rawAddress: funderAddress})))
            );
        }
    }

    function _join(address validatorAddress) internal {
        vm.prank(validatorAddress);
        vm.deal(validatorAddress, MIN_COLLATERAL_AMOUNT + 1);
        sa.join{value: MIN_COLLATERAL_AMOUNT}(DEFAULT_NET_ADDR, FvmAddress({addrType: 1, payload: new bytes(20)}));

        require(sa.status() == Status.Active);
    }

    function release(uint256 releaseAmount, uint256 crossMsgFee, uint64 epoch) internal {
        (, , uint256 feeBefore, , , , ) = gwInfo.bottomUpCheckpoints(epoch);

        uint256 expectedNonce = gwInfo.bottomUpNonce() + 1;
        uint256 expectedCheckpointDataFee = feeBefore + crossMsgFee;

        gwManager.release{value: releaseAmount}();

        (, , uint256 fee, , , , ) = gwInfo.bottomUpCheckpoints(epoch);

        require(fee == expectedCheckpointDataFee, "cpDataAfter.fee == expectedCheckpointDataFee");
        require(gwInfo.bottomUpNonce() == expectedNonce, "gwInfo.bottomUpNonce() == expectedNonce");
    }

    function createCheckpoint(
        address subnetAddress,
        uint64 blockNumber
    ) internal view returns (BottomUpCheckpoint memory) {
        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);
        BottomUpCheckpoint memory checkpoint = BottomUpCheckpoint({
            source: subnetId,
            epoch: blockNumber,
            fee: 0,
            crossMsgs: new CrossMsg[](0),
            prevHash: EMPTY_HASH,
            children: new ChildCheck[](0),
            proof: new bytes(0)
        });

        return checkpoint;
    }

    function addStake(uint256 stakeAmount, address subnetAddress) internal {
        uint256 balanceBefore = subnetAddress.balance;
        (, uint256 stakedBefore, , , , ) = getSubnet(subnetAddress);

        gwManager.addStake{value: stakeAmount}();

        uint256 balanceAfter = subnetAddress.balance;
        (, uint256 stakedAfter, , , , ) = getSubnet(subnetAddress);

        require(balanceAfter == balanceBefore - stakeAmount);
        require(stakedAfter == stakedBefore + stakeAmount);
    }

    function registerSubnetGW(uint256 collateral, address subnetAddress, GatewayDiamond gw) internal {
        gwRouter = RouterFacet(address(gw));
        gwManager = SubnetManagerFacet(address(gw));
        gwInfo = InfoFacet(address(gw));

        gwManager.register{value: collateral}();

        (SubnetID memory id, uint256 stake, uint256 topDownNonce, , uint256 circSupply, Status status) = getSubnetGW(
            subnetAddress,
            gw
        );

        SubnetID memory parentNetwork = gwInfo.getNetworkName();

        require(
            id.toHash() == parentNetwork.createSubnetId(subnetAddress).toHash(),
            "id.toHash() == parentNetwork.createSubnetId(subnetAddress).toHash()"
        );
        require(stake == collateral, "stake == collateral");
        require(topDownNonce == 0, "nonce == 0");
        require(circSupply == 0, "circSupply == 0");
        require(status == Status.Active, "status == Status.Active");
    }

    function registerSubnet(uint256 collateral, address subnetAddress) internal {
        registerSubnetGW(collateral, subnetAddress, gatewayDiamond);
    }

    function getSubnetGW(
        address subnetAddress,
        GatewayDiamond gw
    ) internal returns (SubnetID memory, uint256, uint256, uint256, uint256, Status) {
        gwRouter = RouterFacet(address(gw));
        gwManager = SubnetManagerFacet(address(gw));
        gwInfo = InfoFacet(address(gw));

        SubnetID memory subnetId = gwInfo.getNetworkName().createSubnetId(subnetAddress);

        (
            Status status,
            uint64 topDownNonce,
            uint256 appliedBottomUpNonce,
            uint256 stake,
            ,
            uint256 circSupply,
            SubnetID memory id,

        ) = gwInfo.subnets(subnetId.toHash());

        return (id, stake, topDownNonce, appliedBottomUpNonce, circSupply, status);
    }

    function getSubnet(
        address subnetAddress
    ) internal returns (SubnetID memory, uint256, uint256, uint256, uint256, Status) {
        return getSubnetGW(subnetAddress, gatewayDiamond);
    }

    function generateSelectors(string memory facetName) internal returns (bytes4[] memory facetSelectors) {
        string[] memory inputs = new string[](3);
        inputs[0] = "python3";
        inputs[1] = "scripts/python/get_selectors.py";
        inputs[2] = facetName;

        bytes memory res = vm.ffi(inputs);
        facetSelectors = abi.decode(res, (bytes4[]));
    }
}