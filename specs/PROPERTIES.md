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
