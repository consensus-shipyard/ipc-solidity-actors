# Properties

List of identified and checked invariants of the IPC protocol following the categorization by [Certora](https://github.com/Certora/Tutorials/blob/master/06.Lesson_ThinkingProperties/Categorizing_Properties.pdf):

-   Valid States
-   State Transitions
-   Variable Transitions
-   High-Level Properties
-   Unit Tests
-   Valid States
-   State Transitions
-   Variable Transitions
-   High-Level Properties
-   Unit Tests

## Subnet Registry

| Property | Description                                                | Category             | Tested |
| -------- | ---------------------------------------------------------- | -------------------- | ------ |
| SR-01    | The Gateway address is not changed                         | Variable Transitions | ✅     |
| SR-02    | If a subnet was created then it's address can be retrieved | High Level           | ✅     |

## Subnet Actor

| Property | Description                                                                                                    | Category             | Tested |
| -------- | -------------------------------------------------------------------------------------------------------------- | -------------------- | ------ |
| SA-01    | The number of joined validators is equal to the number of total validators.                                    | Variable Transitions | ✅     |
| SA-02    | The sum of the Subnet Actor Handler's ETH balance plus the total staked sum should equal the total ETH_SUPPLY. | Unit Test            | ✅     |
| SA-03    | The sum of the validator stakes is equal to the total confirmed collateral.                                    | Valid State          | ✅     |
| SA-04    | After leving the subnet, a validator can withdraw all ETHs that were staked.                                   | High Level           | ✅     |
